//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_main_controller.sv
// Description  : This is the main controller for a Pair-HMM batch, it will
//                generate all the jobs of the batch.
//
// Author       : Rick Wertenbroek
// Date         : 08.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    08.04.19           Creation
// 0.1       RWE    02.07.19           Restricted memory map to 64kB
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_main_controller #(
    parameter MAX_SEQUENCE_LENGTH = 2048,
    parameter VERSION_MAGIC = 'hDEADBEEF,
    parameter DEBUG_VERBOSITY = 0
) (
    input logic         clock_i,
    input logic         reset_i,

    axi_lite_if.slave            axi_lite_slave_bus,
    axi_stream_generic_if.master job_bus,

    dbg_if              dbg,
    output logic [10:0] bram_addr_o,
    input  logic [31:0] bram_data_i,

    output logic        reset_wb_o,
    output logic [31:0] total_number_of_jobs_min_1_o,
    output logic [31:0] ddr4_result_offset_o,
    output logic        total_number_valid_o
);

    ////////////////
    // Memory Map //
    ////////////////

    localparam MEMORY_MAP_BITS = 16;

    // The internal memory map spans 64kB
    // 0x0000 - 0xFFFF
    // ---------------
    // 0x0000 - 0x1FFF : Control
    // 0x2000 - 0x3FFF : Read Addresses
    // 0x4000 - 0x5FFF : Read Lengths
    // 0x6000 - 0x7FFF : Hap Addresses
    // 0x8000 - 0x9FFF : Hap Lengths
    // 0xA000 - 0xBFFF : Initial Conditions
    // 0xC000 - 0xDFFF : Unused
    // 0xE000 - 0xFFFF : Job logger RAM

    // Write here to start the machinery
    localparam START_OFFSET       = 'h1FF0;
    // Write the number of reads at this offset
    localparam NUM_READS_OFFSET   = 'h1000;
    // Write the number of haps at this offset
    localparam NUM_HAPS_OFFSET    = 'h1004;
    // Write the memory offset in the DDR4 at this offset
    localparam DDR4_OFFSET_OFFSET = 'h1008;

    // This AXI Slave uses a FSM to control the signals and therefore the
    // different busses are not decoupled. In order to improve performance of
    // the AXI Slave the command, data, and response busses should be decoupled
    // and pipeline everything to chain commands and data.
    // This was done for simplicity's sake and can be improved upon.

    ///////////////
    // Constants //
    ///////////////

    // These are constants, i.e., they are not meant to be changed (or you'll
    // need to adapt the rest of the code).
    localparam MAX_NUMBER_OF_READS = `MAX_NUMBER_OF_READS;
    localparam MAX_NUMBER_OF_HAPS  = `MAX_NUMBER_OF_HAPS;

    ///////////
    // Types //
    ///////////
    typedef enum {IDLE, CREATING_JOBS} state_type_t;
    typedef enum {AXI_IDLE, AXI_WAIT_DATA, AXI_SEND_RESP} axi_state_t;

    /////////////
    // Signals //
    /////////////

    state_type_t state_reg;
    state_type_t next_state;

    axi_state_t axi_state_reg;
    axi_state_t axi_next_state;

    logic [$clog2(MAX_NUMBER_OF_READS)-1:0] read_counter, read_counter_next;
    logic [$clog2(MAX_NUMBER_OF_HAPS)-1:0]  hap_counter, hap_counter_next;
    PairHMMPackage::id_t                    id_counter, id_counter_next;
    logic [$clog2(MAX_NUMBER_OF_READS)-1:0] number_of_reads_min_one_reg;
    logic [$clog2(MAX_NUMBER_OF_HAPS)-1:0]  number_of_haps_min_one_reg;

    logic [31:0]                            ddr4_result_offset_reg;

    logic                                   job_created;

    // Job data fields
    logic [31:0]                            read_addr;
    logic [$clog2(MAX_SEQUENCE_LENGTH)-1:0] read_len_min_1;
    logic [31:0]                            hap_addr;
    logic [$clog2(MAX_SEQUENCE_LENGTH)-1:0] hap_len_min_1;
    PairHMMPackage::floating_point_t        initial_condition;
    // Job data (work request) struct
    PairHMMPackage::work_request_t          job_data;

    logic                                   start_creating_jobs;
    logic                                   done_creating_jobs;

    logic                                   write_data_from_axi;
    logic                                   read_addr_bram_wen;
    logic                                   read_len_min_1_bram_wen;
    logic                                   hap_addr_bram_wen;
    logic                                   hap_len_min_1_bram_wen;
    logic                                   initial_condition_bram_wen;
    logic [$clog2(MAX_NUMBER_OF_READS)-1:0] read_brams_addr;
    logic [$clog2(MAX_NUMBER_OF_HAPS)-1:0]  hap_brams_addr;

    logic [MEMORY_MAP_BITS-1:0]             axi_transaction_addr_reg;
    logic [2:0]                             bram_selection_bits;
    logic                                   start_from_axi;

    /////////
    // AXI //
    /////////

    logic [31:0]                            rdata;

    //////////////
    // AXI read //
    //////////////

    // ARREADY
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            // Ready upon reset
            axi_lite_slave_bus.arready <= 'b1;
        end else begin
            // If a read request is sent we become non ready until
            if (axi_lite_slave_bus.arvalid) begin
                axi_lite_slave_bus.arready <= 'b0;
            // the read data has been transfered
            end else if (axi_lite_slave_bus.rvalid && axi_lite_slave_bus.rready) begin
                axi_lite_slave_bus.arready <= 'b1;
            end
        end
    end

    // RRESP
    assign axi_lite_slave_bus.rresp   = 'b0; // OK

    // RDATA
    always_ff @(posedge clock_i) begin
        if (axi_lite_slave_bus.arvalid && axi_lite_slave_bus.arready) begin
            rdata <= (axi_lite_slave_bus.araddr[15:0] == '0)   ? dbg.axi_read_issued_counter  :
                     (axi_lite_slave_bus.araddr[15:0] == 'h4)  ? dbg.axi_read_resp_counter    :
                     (axi_lite_slave_bus.araddr[15:0] == 'h8)  ? dbg.axi_write_issued_counter :
                     (axi_lite_slave_bus.araddr[15:0] == 'hc)  ? dbg.axi_write_resp_counter   :
                     (axi_lite_slave_bus.araddr[15:0] == 'h10) ? dbg.number_of_jobs_created   :
                     (axi_lite_slave_bus.araddr[15:0] == 'h14) ? dbg.number_of_results_to_wb  :
                     32'(VERSION_MAGIC);
        end
    end

    assign bram_addr_o = axi_lite_slave_bus.araddr[12:2]; // Access 32-bit words

    assign axi_lite_slave_bus.rdata = (axi_lite_slave_bus.araddr[15:13] == 'b111) ? bram_data_i : rdata; // 0xE000 - 0xFFFF

    // RVALID
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            // No data valid upon reset
            axi_lite_slave_bus.rvalid <= 'b0;
        end else begin
            // If there is a read request data will be valid next clock cycle
            if (axi_lite_slave_bus.arvalid && axi_lite_slave_bus.arready) begin
                axi_lite_slave_bus.rvalid <= 'b1;
            // If data has been accepted it is not valid anymore
            end else if (axi_lite_slave_bus.rvalid && axi_lite_slave_bus.rready) begin
                axi_lite_slave_bus.rvalid <= 'b0;
            end
        end
    end

    ///////////////
    // AXI write //
    ///////////////

    // AXI bus handling is done by the FSM below, this is only for simplicity
    // and readability, later this could be removed and each channel could
    // handle it's own signals, in a decoupled manner, i.e., the channels don't
    // wait on each other.

    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            axi_state_reg <= AXI_IDLE;
        end else begin
            axi_state_reg <= axi_next_state;
        end
    end

    always_comb begin
        // Default behavior is to stay in the same state
        axi_next_state = axi_state_reg;

        case (axi_state_reg)
            AXI_IDLE: begin
                if (axi_lite_slave_bus.awvalid) begin
                    axi_next_state = AXI_WAIT_DATA;
                end
            end

            AXI_WAIT_DATA: begin
                if (axi_lite_slave_bus.wvalid) begin
                    axi_next_state = AXI_SEND_RESP;
                end
            end

            AXI_SEND_RESP: begin
                if (axi_lite_slave_bus.bready) begin
                    axi_next_state = AXI_IDLE;
                end
            end
        endcase
    end

    assign axi_lite_slave_bus.awready = (axi_state_reg == AXI_IDLE);
    assign axi_lite_slave_bus.wready  = (axi_state_reg == AXI_WAIT_DATA);
    assign axi_lite_slave_bus.bvalid  = (axi_state_reg == AXI_SEND_RESP);
    assign axi_lite_slave_bus.bresp   = 'b0; // Okay !

    // Register data
    always_ff @(posedge clock_i) begin
        if (axi_state_reg == AXI_IDLE) begin
            // Explicit truncation
            axi_transaction_addr_reg <= axi_lite_slave_bus.awaddr[MEMORY_MAP_BITS-1:0];
            //axi_transaction_addr_reg <= axi_lite_slave_bus.awaddr[$high(axi_transaction_addr_reg):0];
        end
    end

    // Main write enable signal
    assign write_data_from_axi = (axi_lite_slave_bus.wvalid && axi_lite_slave_bus.wready);

    // Check the memory map
    assign bram_selection_bits = axi_transaction_addr_reg[MEMORY_MAP_BITS-1:(MEMORY_MAP_BITS-1)-2];

    // Individual BRAM write enable signals
    assign read_addr_bram_wen         = write_data_from_axi && (bram_selection_bits == 3'b001);
    assign read_len_min_1_bram_wen    = write_data_from_axi && (bram_selection_bits == 3'b010);
    assign hap_addr_bram_wen          = write_data_from_axi && (bram_selection_bits == 3'b011);
    assign hap_len_min_1_bram_wen     = write_data_from_axi && (bram_selection_bits == 3'b100);
    assign initial_condition_bram_wen = write_data_from_axi && (bram_selection_bits == 3'b101);

    // Addresses are not byte based but 32-bit word based for the BRAMs
    assign read_brams_addr            = axi_transaction_addr_reg[$clog2(MAX_NUMBER_OF_READS)-1+2:2];
    assign hap_brams_addr             = axi_transaction_addr_reg[$clog2(MAX_NUMBER_OF_HAPS)-1+2:2];

    // The start command comes from AXI when there is a write at address 0x1FFF
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            start_from_axi <= 'b0;
        end else begin
            if ((axi_transaction_addr_reg == START_OFFSET) &&
                (axi_state_reg == AXI_WAIT_DATA) &&
                axi_lite_slave_bus.wvalid) begin
                    start_from_axi <= 'b1;
            end else begin
                start_from_axi <= 'b0;
            end
        end
    end

    // The total number of reads is written from AXI
    always_ff @(posedge clock_i) begin
        if ((axi_transaction_addr_reg == NUM_READS_OFFSET) &&
            (axi_state_reg == AXI_WAIT_DATA) &&
            axi_lite_slave_bus.wvalid) begin
            number_of_reads_min_one_reg <= axi_lite_slave_bus.wdata;
        end
    end

    // The total number of haps is written from AXI
    always_ff @(posedge clock_i) begin
        if ((axi_transaction_addr_reg == NUM_HAPS_OFFSET) &&
            (axi_state_reg == AXI_WAIT_DATA) &&
            axi_lite_slave_bus.wvalid) begin
            number_of_haps_min_one_reg <= axi_lite_slave_bus.wdata;
        end
    end

    // The offset for the results in the DDR4
    always_ff @(posedge clock_i) begin
        if ((axi_transaction_addr_reg == DDR4_OFFSET_OFFSET) &&
            (axi_state_reg == AXI_WAIT_DATA) &&
            axi_lite_slave_bus.wvalid) begin
            ddr4_result_offset_reg <= axi_lite_slave_bus.wdata;
        end
    end

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // A job is created upon transfer to the job bus
    assign job_created = job_bus.tvalid && job_bus.tready;

    // We start creating jobs when we are in the IDLE state and receive the command from the AXI bus
    assign start_creating_jobs        = (state_reg == IDLE) && (start_from_axi);
    // We are done creating jobs whem the last job is created (this is indicated by the counters)
    assign done_creating_jobs         = job_created && (hap_counter == number_of_haps_min_one_reg) && (read_counter == number_of_reads_min_one_reg);

    assign job_data.read_addr         = read_addr;
    assign job_data.read_len_min_1    = read_len_min_1;
    assign job_data.hap_addr          = hap_addr;
    assign job_data.hap_len_min_1     = hap_len_min_1;
    assign job_data.initial_condition = initial_condition;
    assign job_data.id                = id_counter;

    /////////
    // FSM //
    /////////

    // FSM reg
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            state_reg <= IDLE;
        end else begin
            state_reg <= next_state;
        end
    end

    // FSM Next state
    always_comb begin
        // Default behavior is stay in the same state
        next_state = state_reg;

        case (state_reg)
            IDLE: begin
                if (start_creating_jobs) begin
                    next_state = CREATING_JOBS;
                end
            end

            CREATING_JOBS: begin
                if (done_creating_jobs) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    //////////////
    // Counters //
    //////////////

    // Counter next states
    always_comb begin
        // Default values
        read_counter_next = read_counter;
        hap_counter_next  = hap_counter;
        id_counter_next   = id_counter;

        if (state_reg == CREATING_JOBS) begin
            if (job_created) begin
                if (hap_counter == (number_of_haps_min_one_reg)) begin
                    hap_counter_next  = 0;
                    read_counter_next = read_counter + 1;
                end else begin
                    hap_counter_next = hap_counter + 1;
                end
                id_counter_next = id_counter + 1;
            end
        end
    end

    // Counter registers
    always_ff @(posedge clock_i) begin
        if (state_reg == IDLE) begin
            read_counter <= 0;
            hap_counter  <= 0;
            id_counter   <= 0;
        end else begin
            read_counter <= read_counter_next;
            hap_counter  <= hap_counter_next;
            id_counter   <= id_counter_next;
        end
    end

    ///////////
    // BRAMs //
    ///////////

    bram_32b_x_2048 read_addr_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(read_addr_bram_wen),
        .addra(read_brams_addr),
        .dina(axi_lite_slave_bus.wdata),
        .douta(),
        .clkb(clock_i),
        .enb(1'b1),
        .web(1'b0),
        .addrb(read_counter_next),
        .dinb('0),
        .doutb(read_addr)
    );

    bram_11b_x_2048 read_len_min_1_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(read_len_min_1_bram_wen),
        .addra(read_brams_addr),
        .dina(axi_lite_slave_bus.wdata[10:0]),
        .douta(),
        .clkb(clock_i),
        .enb(1'b1),
        .web(1'b0),
        .addrb(read_counter_next),
        .dinb('0),
        .doutb(read_len_min_1)
    );

    bram_32b_x_2048 hap_addr_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(hap_addr_bram_wen),
        .addra(hap_brams_addr),
        .dina(axi_lite_slave_bus.wdata),
        .douta(),
        .clkb(clock_i),
        .enb(1'b1),
        .web(1'b0),
        .addrb(hap_counter_next),
        .dinb('0),
        .doutb(hap_addr)
    );

    bram_11b_x_2048 hap_len_min_1_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(hap_len_min_1_bram_wen),
        .addra(hap_brams_addr),
        .dina(axi_lite_slave_bus.wdata[10:0]),
        .douta(),
        .clkb(clock_i),
        .enb(1'b1),
        .web(1'b0),
        .addrb(hap_counter_next),
        .dinb('0),
        .doutb(hap_len_min_1)
    );

    bram_32b_x_2048 initial_cond_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(initial_condition_bram_wen),
        .addra(hap_brams_addr),
        .dina(axi_lite_slave_bus.wdata),
        .douta(),
        .clkb(clock_i),
        .enb(1'b1),
        .web(1'b0),
        .addrb(hap_counter_next),
        .dinb('0),
        .doutb(initial_condition)
    );

    /////////////
    // Outputs //
    /////////////

    // Job (work request) stream
    assign job_bus.tvalid = (state_reg == CREATING_JOBS);
    assign job_bus.tdata  = job_data;

    // Reset the WB module counter values when beginning creating jobs
    assign reset_wb_o = (state_reg == IDLE) && (next_state == CREATING_JOBS);
    // The total number of jobs is valid when we send the last job
    assign total_number_valid_o = done_creating_jobs;
    assign total_number_of_jobs_min_1_o = id_counter;
    assign ddr4_result_offset_o = ddr4_result_offset_reg;

endmodule // cl_main_controller
