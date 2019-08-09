//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_pairhmm_worker_stream.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 25.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    25.03.19           Creation
//-----------------------------------------------------------------------------
`include "cl_pairhmm_package.vh"

module cl_pairhmm_worker_stream #(
    parameter MAX_SEQUENCE_LENGTH = 2048,
    parameter DEBUG_VERBOSITY = 0,
    parameter WORKER_ID = 0
) (
    // Standard inputs
    input logic clock_i,
    input logic reset_i,

    // Control interface
    input PairHMMPackage::work_request_2_t request_i,
    input  logic start_i,
    output logic ready_o,
    output logic done_o,

    axi_stream_simple_if.slave stream_in_bus,

    input PairHMMPackage::store_type_t stream_type_i,

    fifo_if.master_write compute_request_bus,

    fifo_if.master_read  compute_result_bus,

    axi_stream_simple_if.master result_sum_bus,
    axi_stream_simple_if.slave  sum_result_bus,
    axi_stream_simple_if.master result_bus,
    output logic [7:0]   tid,
    PairHMMPackage::id_t id
);
    // Vivado 2017.4 cannot synth a let statement
    //let min (a, b) = (a < b) ? a : b;

    // FSM state type
    typedef enum {IDLE, STORING, COMPUTE} state_type_t;

    // Constants
    localparam NUCL_SIZE              = $bits(PairHMMPackage::nucleotide_t);
    localparam QUAL_SIZE              = $bits(PairHMMPackage::quality_t);
    localparam BRAM_WORD_WIDTH        = 32;
    localparam BRAM_ADDR_WIDTH        = $clog2(MAX_SEQUENCE_LENGTH / 4);
    localparam NUM_NUCL_IN_WORD       = BRAM_WORD_WIDTH / NUCL_SIZE;
    localparam NUM_QUAL_IN_WORD       = BRAM_WORD_WIDTH / QUAL_SIZE;
    localparam BRAM_QUAL_ADDR_WIDTH   = $clog2(MAX_SEQUENCE_LENGTH / NUM_QUAL_IN_WORD);
    localparam BRAM_NUCL_ADDR_WIDTH   = $clog2(MAX_SEQUENCE_LENGTH / NUM_NUCL_IN_WORD);
    localparam STORE_COUNTER_WIDTH    = $clog2(MAX_SEQUENCE_LENGTH / ((NUM_QUAL_IN_WORD < NUM_NUCL_IN_WORD) ? NUM_QUAL_IN_WORD : NUM_NUCL_IN_WORD));
    //localparam STORE_COUNTER_WIDTH    = $clog2(MAX_SEQUENCE_LENGTH / min(NUM_QUAL_IN_WORD, NUM_NUCL_IN_WORD));
    localparam NUM_NUCL_SEL_BITS      = $clog2(NUM_NUCL_IN_WORD);
    localparam NUM_QUAL_SEL_BITS      = $clog2(NUM_QUAL_IN_WORD);

    // FSM signals
    state_type_t state_reg, state_next;

    // Request reg
    PairHMMPackage::work_request_2_t request_reg;

    // Counters
    logic [STORE_COUNTER_WIDTH-1:0] store_counter;
    PairHMMPackage::store_type_t    store_type_reg;

    // AXI-Stream registers
    logic [BRAM_WORD_WIDTH-1:0] axis_data_reg;
    logic                       axis_valid_reg;
;
    logic [BRAM_ADDR_WIDTH-1:0] bram_write_addr;
    logic                       write_to_bram;
    logic [BRAM_ADDR_WIDTH+NUM_NUCL_SEL_BITS-1:0] prefetch_bram_addr;

    logic [BRAM_ADDR_WIDTH-1:0] read_brams_read_addr;
    logic [BRAM_ADDR_WIDTH-1:0] hap_bram_read_addr;
    logic [BRAM_ADDR_WIDTH-1:0] read_brams_read_prefetch_addr;

    logic                       computation_done;

    // Busses (There are two busses because the BRAMs used are true dual port)
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0] ), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_read_base_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_read_q_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_read_i_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_read_d_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_read_c_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram1_hap_base_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_read_base_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_read_q_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_read_i_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_read_d_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_read_c_bus (clock_i);
    bram_if #(.T(logic[BRAM_WORD_WIDTH-1:0]), .ADDR_WIDTH(BRAM_ADDR_WIDTH)) bram2_hap_base_bus (clock_i);

    // Busses to worker
    bram_if #(.T(PairHMMPackage::read_base_info_t), .ADDR_WIDTH(BRAM_ADDR_WIDTH+NUM_NUCL_SEL_BITS)) read_info_bus(clock_i);
    bram_if #(.T(PairHMMPackage::hap_base_info_t),  .ADDR_WIDTH(BRAM_ADDR_WIDTH+NUM_NUCL_SEL_BITS)) hap_info_bus(clock_i);

    //////////////////////
    // Bus Assignations //
    //////////////////////

    // Assign read addresses to the busses
    assign read_brams_read_addr = read_info_bus.read_addr[$bits(read_info_bus.read_addr)-1:NUM_NUCL_SEL_BITS];
    assign read_brams_read_prefetch_addr = prefetch_bram_addr[$bits(prefetch_bram_addr)-1:NUM_QUAL_SEL_BITS];

    // The used busses share the same addresses, the other ones are set to 0
    // The 1 busses use the prefetch address
    assign bram1_read_base_bus.read_addr = '0;
    assign bram2_read_base_bus.read_addr = read_brams_read_addr;
    assign bram1_read_q_bus.read_addr    = '0;
    assign bram2_read_q_bus.read_addr    = read_brams_read_addr;
    assign bram1_read_i_bus.read_addr    = read_brams_read_prefetch_addr;
    assign bram2_read_i_bus.read_addr    = read_brams_read_addr;
    assign bram1_read_d_bus.read_addr    = read_brams_read_prefetch_addr;
    assign bram2_read_d_bus.read_addr    = read_brams_read_addr;
    assign bram1_read_c_bus.read_addr    = read_brams_read_prefetch_addr;
    assign bram2_read_c_bus.read_addr    = read_brams_read_addr;

    // Assign the read enable signals
    assign bram1_read_base_bus.read_en   = 'b1;
    assign bram2_read_base_bus.read_en   = read_info_bus.read_en;
    assign bram1_read_q_bus.read_en      = 'b1;
    assign bram2_read_q_bus.read_en      = read_info_bus.read_en;
    assign bram1_read_i_bus.read_en      = read_info_bus.read_en;
    assign bram2_read_i_bus.read_en      = read_info_bus.read_en;
    assign bram1_read_d_bus.read_en      = read_info_bus.read_en;
    assign bram2_read_d_bus.read_en      = read_info_bus.read_en;
    assign bram1_read_c_bus.read_en      = read_info_bus.read_en;
    assign bram2_read_c_bus.read_en      = read_info_bus.read_en;

    // Assign the hap read address
    assign hap_bram_read_addr = hap_info_bus.read_addr[$size(hap_info_bus.read_addr)-1:NUM_NUCL_SEL_BITS];
    assign bram1_hap_base_bus.read_addr  = '0;
    assign bram2_hap_base_bus.read_addr  = hap_bram_read_addr;

    // Assign the read enable signals
    assign bram1_hap_base_bus.read_en    = 'b1;
    assign bram2_hap_base_bus.read_en    = hap_info_bus.read_en;

    // Below are muxes to select the right info in the BRAM word
    // Note : The index must be registered to be aligned with the
    // addres that was used when read enable was asserted
    logic [NUM_NUCL_SEL_BITS-1:0] read_data_nucl_sel_reg;
    logic [NUM_QUAL_SEL_BITS-1:0] read_data_qual_sel_reg;
    always_ff @(posedge clock_i) begin
        if (read_info_bus.read_en) begin
            read_data_nucl_sel_reg <= read_info_bus.read_addr[NUM_NUCL_SEL_BITS-1:0];
            read_data_qual_sel_reg <= read_info_bus.read_addr[NUM_QUAL_SEL_BITS-1:0];
        end
    end
    assign read_info_bus.read_data.base                         = bram2_read_base_bus.read_data[read_data_nucl_sel_reg*NUCL_SIZE +:NUCL_SIZE];
    assign read_info_bus.read_data.base_quals.base_qual         = bram2_read_q_bus.read_data[read_data_qual_sel_reg*QUAL_SIZE +:QUAL_SIZE];
    assign read_info_bus.read_data.base_quals.insertion_qual    = bram2_read_i_bus.read_data[read_data_qual_sel_reg*QUAL_SIZE +:QUAL_SIZE];
    assign read_info_bus.read_data.base_quals.deletion_qual     = bram2_read_d_bus.read_data[read_data_qual_sel_reg*QUAL_SIZE +:QUAL_SIZE];
    assign read_info_bus.read_data.base_quals.continuation_qual = bram2_read_c_bus.read_data[read_data_qual_sel_reg*QUAL_SIZE +:QUAL_SIZE];

    // Here we need to prefetch some info, therefore we use the other BRAM bus
    assign prefetch_bram_addr = read_info_bus.read_addr + 1; // +1 since we need the info of the next base
    // Below are muxes to select the right info in the BRAM word
    // Note : The index must be registered to be aligned with the
    // addres that was used when read enable was asserted
    logic [NUM_QUAL_SEL_BITS-1:0] read_data_prefetch_sel_reg;
    always_ff @(posedge clock_i) begin
        if (read_info_bus.read_en) begin
            read_data_prefetch_sel_reg <= prefetch_bram_addr[NUM_QUAL_SEL_BITS-1:0];
        end
    end
    assign read_info_bus.read_data.insertion_qual_right = bram1_read_i_bus.read_data[read_data_prefetch_sel_reg*QUAL_SIZE +:QUAL_SIZE];
    assign read_info_bus.read_data.deletion_qual_right = bram1_read_d_bus.read_data[read_data_prefetch_sel_reg*QUAL_SIZE +:QUAL_SIZE];
    assign read_info_bus.read_data.continuation_qual_right = bram1_read_c_bus.read_data[read_data_prefetch_sel_reg*QUAL_SIZE +:QUAL_SIZE];

    // Below are muxes to select the right info in the BRAM word
    // Note : The index must be registered to be aligned with the
    // addres that was used when read enable was asserted
    logic [NUM_NUCL_SEL_BITS-1:0] hap_data_sel_reg;
    always_ff @(posedge clock_i) begin
        if (hap_info_bus.read_en) begin
            hap_data_sel_reg <= hap_info_bus.read_addr[NUM_NUCL_SEL_BITS-1:0];
        end
    end
    assign hap_info_bus.read_data.base = bram2_hap_base_bus.read_data[hap_data_sel_reg*NUCL_SIZE +:NUCL_SIZE];

    // Registers on AXI-Stream interface (to make this easier to route and improve timings)
    always_ff @(posedge clock_i) begin
        // Register the valid signal
        if (reset_i) begin
            axis_valid_reg <= 1'b0;
        end else begin
            axis_valid_reg <= stream_in_bus.tvalid;
        end
        // Register the data
        axis_data_reg  <= stream_in_bus.tdata;
        store_type_reg <= stream_type_i;
    end

    // The busses share the same data, write enable will decide where the data goes
    assign bram1_read_base_bus.write_data = axis_data_reg;
    assign bram1_read_q_bus.write_data    = axis_data_reg;
    assign bram1_read_i_bus.write_data    = axis_data_reg;
    assign bram1_read_d_bus.write_data    = axis_data_reg;
    assign bram1_read_c_bus.write_data    = axis_data_reg;
    assign bram1_hap_base_bus.write_data  = axis_data_reg;

    // Write address
    assign bram_write_addr                = store_counter;

    // The busses share the same write address
    assign bram1_read_base_bus.write_addr = bram_write_addr;
    assign bram1_read_q_bus.write_addr    = bram_write_addr;
    assign bram1_read_i_bus.write_addr    = bram_write_addr;
    assign bram1_read_d_bus.write_addr    = bram_write_addr;
    assign bram1_read_c_bus.write_addr    = bram_write_addr;
    assign bram1_hap_base_bus.write_addr  = bram_write_addr;

    // Write enable
    assign write_to_bram                = axis_valid_reg;

    // Each BRAM must only be written with the correct type, only one is written to at a time
    assign bram1_read_base_bus.write_en = write_to_bram && (store_type_reg == PairHMMPackage::STORE_R);
    assign bram1_read_q_bus.write_en    = write_to_bram && (store_type_reg == PairHMMPackage::STORE_Q);
    assign bram1_read_i_bus.write_en    = write_to_bram && (store_type_reg == PairHMMPackage::STORE_I);
    assign bram1_read_d_bus.write_en    = write_to_bram && (store_type_reg == PairHMMPackage::STORE_D);
    assign bram1_read_c_bus.write_en    = write_to_bram && (store_type_reg == PairHMMPackage::STORE_C);
    assign bram1_hap_base_bus.write_en  = write_to_bram && (store_type_reg == PairHMMPackage::STORE_H);

    // Store counter
    always_ff @(posedge clock_i) begin
        // TODO : Add reset when new request is being transferred !
        if (reset_i) begin
            store_counter <= 0;
        end else begin
            // Reset the counter when stream type changes
            if (stream_type_i != store_type_reg) begin
                store_counter <= 0;
            // Increment counter upon transfer (only need to check valid since we are always ready)
            end else if (axis_valid_reg) begin
                store_counter <= store_counter + 1;
            end
        end
    end

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // The computation is done when the final result has been written (accepted)
    assign computation_done = result_bus.tvalid && result_bus.tready;

    /////////
    // FSM //
    /////////

    // State register
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            state_reg      <= IDLE;
        end else begin
            state_reg      <= state_next;
        end
    end

    // Next state logic
    always_comb begin
        state_next = state_reg; // Default next state : remain the same

        case (state_reg)
            IDLE: begin
                if (start_i) begin
                    state_next = COMPUTE;
                end
            end

            STORING: begin
                state_next = IDLE; // TODO
            end

            COMPUTE: begin
                if (computation_done) begin
                    state_next = IDLE;
                end
            end

        endcase // case (state_reg)
    end // always_comb

    ///////////////
    // Registers //
    ///////////////

    // Request register
    always_ff @(posedge clock_i) begin
        // Enable only if IDLE
        if (start_i && (state_reg == IDLE)) begin
            request_reg <= request_i;
        end
    end

    ////////////
    // Worker //
    ////////////

    logic [$bits(request_reg.read_len_min_1)-1:0] read_len_s;
    assign read_len_s = request_reg.read_len_min_1 + 1; // Plus 1 because extra row

    cl_pairhmm_new_worker_core_synth #(
        .MAX_SEQUENCE_LENGTH(MAX_SEQUENCE_LENGTH),
        .DEBUG_VERBOSITY(DEBUG_VERBOSITY),
        .WORKER_ID(WORKER_ID)
    ) worker (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .enable_i(logic'(state_reg == COMPUTE)),
        .read_len_i(read_len_s),
        .hap_len_i(request_reg.hap_len_min_1),
        .initial_condition_i(request_reg.initial_condition),
        .read_info_bus(read_info_bus),
        .hap_info_bus(hap_info_bus),
        .compute_request_bus(compute_request_bus),
        .compute_result_bus(compute_result_bus),
        .result_sum_bus(result_sum_bus),
        .sum_result_bus(sum_result_bus),
        .final_result_bus(result_bus),
        .tid(tid)
    );

    ///////////
    // BRAMs //
    ///////////

    // Note : BRAM up to 1024 x 32b still resides in a single 36k BRAM
    // 512 x 32b is used here (2048 bases)
    worker_bram read_base_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(bram1_read_base_bus.write_en),
        .addra(bram1_read_base_bus.write_addr),
        .dina(bram1_read_base_bus.write_data),
        .douta(),
        .clkb(clock_i),
        .enb(bram2_read_base_bus.read_en),
        .web(1'b0),
        .addrb(bram2_read_base_bus.read_addr),
        .dinb('0),
        .doutb(bram2_read_base_bus.read_data)
    );

    worker_bram read_q_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(bram1_read_q_bus.write_en),
        .addra(bram1_read_q_bus.write_addr),
        .dina(bram1_read_q_bus.write_data),
        .douta(bram1_read_q_bus.read_data),
        .clkb(clock_i),
        .enb(bram2_read_q_bus.read_en),
        .web(1'b0),
        .addrb(bram2_read_q_bus.read_addr),
        .dinb('0),
        .doutb(bram2_read_q_bus.read_data)
    );

    worker_bram read_i_bram (
        .clka(clock_i),
        .ena((state_reg == COMPUTE) ? bram1_read_i_bus.read_en : 1'b1),
        .wea(bram1_read_i_bus.write_en),
        .addra((state_reg == COMPUTE) ? bram1_read_i_bus.read_addr : bram1_read_i_bus.write_addr),
        .dina(bram1_read_i_bus.write_data),
        .douta(bram1_read_i_bus.read_data),
        .clkb(clock_i),
        .enb(bram2_read_i_bus.read_en),
        .web(1'b0),
        .addrb(bram2_read_i_bus.read_addr),
        .dinb('0),
        .doutb(bram2_read_i_bus.read_data)
    );

    worker_bram read_d_bram (
        .clka(clock_i),
        .ena((state_reg == COMPUTE) ? bram1_read_d_bus.read_en : 1'b1),
        .wea(bram1_read_d_bus.write_en),
        .addra((state_reg == COMPUTE) ? bram1_read_d_bus.read_addr : bram1_read_d_bus.write_addr),
        .dina(bram1_read_d_bus.write_data),
        .douta(bram1_read_d_bus.read_data),
        .clkb(clock_i),
        .enb(bram2_read_d_bus.read_en),
        .web(1'b0),
        .addrb(bram2_read_d_bus.read_addr),
        .dinb('0),
        .doutb(bram2_read_d_bus.read_data)
    );

    worker_bram read_c_bram (
        .clka(clock_i),
        .ena((state_reg == COMPUTE) ? bram1_read_c_bus.read_en : 1'b1),
        .wea(bram1_read_c_bus.write_en),
        .addra((state_reg == COMPUTE) ? bram1_read_c_bus.read_addr : bram1_read_c_bus.write_addr),
        .dina(bram1_read_c_bus.write_data),
        .douta(bram1_read_c_bus.read_data),
        .clkb(clock_i),
        .enb(bram2_read_c_bus.read_en),
        .web(1'b0),
        .addrb(bram2_read_c_bus.read_addr),
        .dinb('0),
        .doutb(bram2_read_c_bus.read_data)
    );

    worker_bram hap_base_bram (
        .clka(clock_i),
        .ena(1'b1),
        .wea(bram1_hap_base_bus.write_en),
        .addra(bram1_hap_base_bus.write_addr),
        .dina(bram1_hap_base_bus.write_data),
        .douta(),
        .clkb(clock_i),
        .enb(bram2_hap_base_bus.read_en),
        .web(1'b0),
        .addrb(bram2_hap_base_bus.read_addr),
        .dinb('0),
        .doutb(bram2_hap_base_bus.read_data)
    );

    /////////////
    // Outputs //
    /////////////
    assign ready_o = (state_reg == IDLE);
    assign stream_in_bus.tready = 1'b1; // We are always ready
    assign done_o = computation_done;
    assign id = request_reg.id;

endmodule // cl_pairhmm_worker_stream
