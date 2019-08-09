//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_workgroup_controller.sv
// Description  : This controller manages a group of workers by providing them
//                jobs and getting data for them via an AXI bus.
//
// Author       : Rick Wertenbroek
// Date         : 01.04.19
// Version      : 0.0
//
// Dependencies : cl_pairhmm_package.vh
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    01.04.19           Creation
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_workgroup_controller #(
    parameter NUMBER_OF_WORKERS = 2,
    parameter MAX_SEQUENCE_LENGTH = 2048,
    parameter DEBUG_VERBOSITY = 0
) (
    input logic                             clock_i,
    input logic                             reset_i,

    axi_stream_generic_if.slave             job_bus,
    axi_if.master                           axi_bus,

    axi_stream_simple_if.master             stream_out_bus,
    output PairHMMPackage::stream_type_t    stream_type_o,
    output PairHMMPackage::work_request_2_t request_o,
    input  logic [NUMBER_OF_WORKERS-1:0]    workers_ready_i,
    output logic                            start_o,
    output logic [7:0]                      selected_worker_o
);

    // The controller will :
    // 1) Check if a worker is ready
    // 2) If so select it
    // 3) Get a job from the job queue
    // 4) Send requests to the DDR4 to get the data
    // 5) Stream the data from the DDR4 to the worker
    // 6) Start the worker
    // 7) Go to 1

    // Constants
    localparam COUNTER_WIDTH          = $clog2(MAX_SEQUENCE_LENGTH);
    localparam BRAM_WORD_WIDTH        = 32;
    localparam AXI_DATA_WIDTH         = 512;
    localparam BRAM_WORDS_IN_AXI_DATA = AXI_DATA_WIDTH / BRAM_WORD_WIDTH;
    localparam NUM_SEL_BITS_AXI_DATA  = $clog2(BRAM_WORDS_IN_AXI_DATA);
    localparam STREAM_COUNTER_WIDTH    = (COUNTER_WIDTH - $clog2(BRAM_WORDS_IN_AXI_DATA)) + 1;
    localparam BRAM_ADDR_WIDTH        = $clog2(MAX_SEQUENCE_LENGTH / 4);
    localparam NUCL_SIZE              = $size(PairHMMPackage::nucleotide_t);
    localparam QUAL_SIZE              = $size(PairHMMPackage::quality_t);
    localparam NUM_NUCL_IN_WORD       = BRAM_WORD_WIDTH / NUCL_SIZE;
    localparam NUM_QUAL_IN_WORD       = BRAM_WORD_WIDTH / QUAL_SIZE;
    localparam NUM_NUCL_SEL_BITS      = $clog2(NUM_NUCL_IN_WORD);
    localparam NUM_QUAL_SEL_BITS      = $clog2(NUM_QUAL_IN_WORD);

    // FSM state type
    typedef enum {IDLE, GET_JOB, ISSUE_READ_REQ, WAIT_READ_RESP, STREAM_READ_RESP,
                  ISSUE_HAP_REQ, WAIT_HAP_RESP, STREAM_HAP_RESP, START_COMPUTE}  state_type_t;

    /////////////
    // Signals //
    /////////////
    state_type_t state_reg, state_next;
    PairHMMPackage::stream_type_t stream_type_reg, stream_type_next;

    // Shift register to store the data in BRAM (less logic than a mux)
    logic [BRAM_WORD_WIDTH-1:0] axi_data_reg [AXI_DATA_WIDTH/BRAM_WORD_WIDTH-1:0];

    PairHMMPackage::work_request_t request_reg;

    logic [$size(axi_bus.araddr)-1:0] axi_read_addr_reg;

    // Note : The size could be smaller
    logic [STREAM_COUNTER_WIDTH-1:0] stream_counter;
    logic [$clog2(BRAM_WORDS_IN_AXI_DATA)-1:0] shift_counter;
    logic [7:0]                                worker_counter;

    logic        worker_ready;
    logic        get_job;
    logic        read_length_streamed;
    logic        hap_length_streamed;
    logic        last_stream_read;
    logic        last_stream_hap;
    logic        axi_read_req_accepted;
    logic        axi_data_ready;
    logic        store_from_axi;
    logic        axi_data_streamed;


    ////////////////
    // Assertions //
    ////////////////
    initial begin
        assert (NUMBER_OF_WORKERS >= 2) else $error("Number of workers must be at least 2.");
        // Since the worker selection signals and counter are 8-bits, this could be made generic
        assert (NUMBER_OF_WORKERS <= 256) else $error("Only up to 256 workers supported in workgroup.");
    end

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    assign worker_ready = workers_ready_i[worker_counter];

    // We get a job when we are in the GET_JOB state and a there is a valid job
    assign get_job = (state_reg == GET_JOB) && job_bus.tvalid;
    // We are only ready to accept a job in the GET_JOB state
    assign job_bus.tready = (state_reg == GET_JOB);

    // In order to know when to change the type of data we acquire
    assign read_length_streamed = axi_data_streamed && (stream_counter == request_reg.read_len_min_1[$size(request_reg.read_len_min_1)-1:NUM_SEL_BITS_AXI_DATA+NUM_NUCL_SEL_BITS]);

    assign hap_length_streamed  = axi_data_streamed && (stream_counter == request_reg.hap_len_min_1[$size(request_reg.hap_len_min_1)-1:NUM_SEL_BITS_AXI_DATA+NUM_NUCL_SEL_BITS]);

    // The last stream for a read is when the last C quality has been streamed
    // The granularity is an AXI word (so it may happen that more bases are fetched,
    // and data requires to be aligned to an AXI word for each part)
    assign last_stream_read = (stream_type_reg == PairHMMPackage::STORE_C) && read_length_streamed;
    // The last stream for a hap is when the last base has been streamed
    assign last_stream_hap = (stream_type_reg == PairHMMPackage::STORE_H) && hap_length_streamed;

    // The AXI request will be accepted if the slave is ready
    assign axi_read_req_accepted = axi_bus.arready;
    // The AXI read data is ready when the slave asserts RVALID
    assign axi_data_ready = axi_bus.rvalid;

    // AXI request
    assign axi_bus.awid    = '0;
    assign axi_bus.awaddr  = '0;
    assign axi_bus.awlen   = '0;
    assign axi_bus.awsize  = '0;
    assign axi_bus.awburst = 2'b01;
    assign axi_bus.awvalid = '0;
    assign axi_bus.wid     = '0;
    assign axi_bus.wdata   = '0;
    assign axi_bus.wstrb   = '0;
    assign axi_bus.wlast   = '0;
    assign axi_bus.wvalid  = '0;
    assign axi_bus.bready  = '1;
    assign axi_bus.arid    = '0; // TODO : Check if necessary ?
    assign axi_bus.araddr  = axi_read_addr_reg;
    // Only do a single 512-bit data read (this could be optimized)
    assign axi_bus.arlen   = '0;    // Burst size is arlen + 1
    assign axi_bus.arsize  = 'b110; // 64-bytes (512-bit)
    assign axi_bus.arburst = 2'b01;
    assign axi_bus.arvalid = (state_reg == ISSUE_READ_REQ) || (state_reg == ISSUE_HAP_REQ);
    assign axi_bus.rready  = '1;

    // We store the data from AXI when it is ready
    assign store_from_axi = axi_bus.rvalid && ((state_reg == WAIT_READ_RESP) || (state_reg == WAIT_HAP_RESP));

    // The AXI data is streamed to the worker when all the subwords have been shifted
    assign axi_data_streamed = (shift_counter == (BRAM_WORDS_IN_AXI_DATA-1));

    //////////
    // FSMs //
    //////////

    // State registers
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            state_reg       <= IDLE;
            stream_type_reg <= PairHMMPackage::STORE_R;
        end else begin
            state_reg       <= state_next;
            stream_type_reg <= stream_type_next;
        end
    end

    // Next state logic
    always_comb begin
        state_next = state_reg; // Default next state : remain the same

        case (state_reg)
            IDLE: begin
                if (worker_ready) begin
                    state_next = GET_JOB;
                end
            end

            GET_JOB: begin
                if (get_job) begin
                    // Here we could optimize if the worker already has the data
                    // And just get the new read/hap data depending on what the
                    // worker already has.
                    state_next = ISSUE_READ_REQ;
                end
            end

            ISSUE_READ_REQ: begin
                // Here we wait until the AXI request has been accepted by slave
                if (axi_read_req_accepted) begin
                    state_next = WAIT_READ_RESP;
                end
            end

            WAIT_READ_RESP: begin
                // Here we wait until the AXI slave issues the data
                if (axi_data_ready) begin
                    state_next = STREAM_READ_RESP;
                end
            end

            STREAM_READ_RESP: begin
                // If the current AXI data word has been streamed to the worker
                if (axi_data_streamed) begin
                    // Last stream read is when we streamed the last quality
                    if (last_stream_read) begin
                        state_next = ISSUE_HAP_REQ;
                    // Else there is still data to fetch
                    end else begin
                        state_next = ISSUE_READ_REQ;
                    end
                end
            end

            ISSUE_HAP_REQ: begin
                // Here we wait until the AXI request has been accepted by slave
                if (axi_read_req_accepted) begin
                    state_next = WAIT_HAP_RESP;
                end
            end

            WAIT_HAP_RESP: begin
                // Here we wait until the AXI slave issues the data
                if (axi_data_ready) begin
                    state_next = STREAM_HAP_RESP;
                end
            end

            STREAM_HAP_RESP: begin
                // If the current AXI data word has been streamed to the worker
                if (axi_data_streamed) begin
                    // When we are done with the whole haplotype
                    if (last_stream_hap) begin
                        state_next = START_COMPUTE;
                    // Else there is still data to fetch
                    end else begin
                        state_next = ISSUE_HAP_REQ;
                    end
                end
            end

            START_COMPUTE: begin
                state_next = IDLE;
            end
        endcase // case (state_reg)
    end // always_comb

    // Next stream type logic
    always_comb begin
        stream_type_next = stream_type_reg; // Default continue to stream the same type

        // If we always start by storing a read
        if (state_reg == IDLE) begin
            stream_type_next = PairHMMPackage::STORE_R;
        // Else if we start the hap
        end else if ((state_reg != ISSUE_HAP_REQ) && (state_next == ISSUE_HAP_REQ)) begin
            stream_type_next = PairHMMPackage::STORE_H;
        // Else if we start a new section
        end else if (read_length_streamed) begin
            case (stream_type_reg)
                PairHMMPackage::STORE_R: begin
                    stream_type_next = PairHMMPackage::STORE_Q;
                end
                PairHMMPackage::STORE_Q: begin
                    stream_type_next = PairHMMPackage::STORE_I;
                end
                PairHMMPackage::STORE_I: begin
                    stream_type_next = PairHMMPackage::STORE_D;
                end
                PairHMMPackage::STORE_D: begin
                    stream_type_next = PairHMMPackage::STORE_C;
                end
            endcase // case (stream_type_reg)
        end
    end // always_comb

    ///////////////
    // Registers //
    ///////////////

    // AXI Data shift register
    always_ff @(posedge clock_i) begin
        // Stream the whole word
        if (store_from_axi) begin
            for (int i = 0; i < AXI_DATA_WIDTH/BRAM_WORD_WIDTH; i++) begin
                axi_data_reg[i] <= axi_bus.rdata[i*BRAM_WORD_WIDTH +:BRAM_WORD_WIDTH];
            end
        // Shift (no condition, since slave (BRAM) can accept data every cycle)
        end else begin
            for (int i = 0; i < AXI_DATA_WIDTH/BRAM_WORD_WIDTH-1; i++) begin
                axi_data_reg[i] <= axi_data_reg[i+1];
            end
        end
    end

    // Request register
    always_ff @(posedge clock_i) begin
        if (get_job) begin
            request_reg <= job_bus.tdata;
        end
    end

    //////////////
    // Counters //
    //////////////

    // AXI Read Address Counter
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            axi_read_addr_reg <= '0;
        end else begin
            if ((state_reg == GET_JOB) && (state_next == ISSUE_READ_REQ)) begin
                // Address is read address
                axi_read_addr_reg <= job_bus.tdata.read_addr;
            end else if ((state_reg == STREAM_READ_RESP) && (state_next == ISSUE_HAP_REQ)) begin
                // Address is hap address
                axi_read_addr_reg <= request_reg.hap_addr;
            end else begin
                if (store_from_axi) begin
                    // Increment counter
                    axi_read_addr_reg <= axi_read_addr_reg + 'd64; // TODO : Remove magic number
                    // An AXI transaction (single word) is 512 bits or 64 bytes in our case
                end
            end
        end
    end

    // Stream counter
    always_ff @(posedge clock_i) begin
        // Reset conditions
        if ((state_reg == IDLE) ||
            (read_length_streamed && (stream_type_reg != PairHMMPackage::STORE_H)) ||
            (hap_length_streamed && (stream_type_reg == PairHMMPackage::STORE_H))) begin
            stream_counter <= '0;
        end else begin
            if (((state_reg == STREAM_READ_RESP) && (state_next != STREAM_READ_RESP)) ||
                ((state_reg == STREAM_HAP_RESP)  && (state_next != STREAM_HAP_RESP))) begin
                stream_counter <= stream_counter + 1;
            end
        end
    end

    // Shift counter
    always_ff @(posedge clock_i) begin
        // Reset conditions (when we go in a STREAM state)
        if (((state_reg != STREAM_READ_RESP) && (state_next == STREAM_READ_RESP)) ||
            ((state_reg != STREAM_HAP_RESP)  && (state_next == STREAM_HAP_RESP))) begin
            shift_counter <= '0;
        end else begin
            // The counter only increments in STREAM states, but could also be free running
            // (remove the if (...) condition, this would save logic but be less clear
            if ((state_reg == STREAM_READ_RESP) || (state_reg == STREAM_HAP_RESP)) begin
                shift_counter <= shift_counter + 1;
            end
        end
    end

    // Worker counter (to search for a worker that is ready)
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            worker_counter <= 0;
        end else begin // Could be if (state_reg == IDLE)
            if (!worker_ready) begin
                if (worker_counter == (NUMBER_OF_WORKERS-1)) begin
                    worker_counter <= 0;
                end else begin
                    worker_counter <= worker_counter + 1;
                end
            end
        end
    end

    ///////////////////////
    // Outputs to Worker //
    ///////////////////////

    // Since the output busses are connected to all workers
    assign selected_worker_o           = worker_counter;

    // Request to worker
    assign request_o.read_len_min_1    = request_reg.read_len_min_1;
    assign request_o.hap_len_min_1     = request_reg.hap_len_min_1;
    assign request_o.initial_condition = request_reg.initial_condition;
    assign request_o.id                = request_reg.id;

    // Start command to worker
    assign start_o                     = (state_reg == START_COMPUTE);

    // Stream to worker
    assign stream_out_bus.tdata        = axi_data_reg[0];
    assign stream_out_bus.tvalid       = (state_reg == STREAM_READ_RESP) || (state_reg == STREAM_HAP_RESP);
    assign stream_type_o               = stream_type_reg;

endmodule // cl_workgroup_controller
