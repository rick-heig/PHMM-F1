//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_worker_tb.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 25.01.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    25.01.19           Creation
//-----------------------------------------------------------------------------

`include "cl_defines.vh"

module sim_worker_tb;

    /////////////
    // Signals //
    /////////////
    localparam ROM_DEPTH = 2048;
    localparam ADDR_WIDTH = $clog2(ROM_DEPTH);

    /* Ref : https://www.drive5.com/usearch/manual/quality_score.html */
    localparam QUAL_OFFSET = 33; /* Phred score offset - Illumina, Ion Torrent, PacBio, and Sanger */

    logic reset;
    logic clock = 'b0;
    logic enable;

    logic read_read_en;
    logic [ADDR_WIDTH-1:0] read_read_addr;

    logic [ADDR_WIDTH-1:0] read_len = 41;
    logic [ADDR_WIDTH-1:0] hap_len = 41;

    logic                            compute_ready;
    PairHMMPackage::request_t        request_obs;
    logic                            request_valid;
    PairHMMPackage::result_t         result_obs;
    logic                            result_valid;
    logic                            read_result_obs;
    PairHMMPackage::floating_point_t final_result_obs;
    logic                            final_result_valid_obs;

    /////////////
    // Stimuli //
    /////////////

    /* Clock generation */
    always #5 clock <= ~clock;

    /* Reset generation */
    initial begin
        reset     <= 'b1;
        #50 reset <= 'b0;
    end

    /* Enable signal generation */
    initial begin
        enable <= 'b0;
        #200 enable <= 'b1;
        wait (final_result_valid_obs == 'b1);
        enable <= 'b0;
    end

    ////////////
    // Busses //
    ////////////
    bram_t #(.T(nucleotide_t), .ADDR_WIDTH(ADDR_WIDTH)) bram_hap_base_bus (clock);
    bram_t #(.T(nucleotide_t), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_base_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_q_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_i_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_d_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_c_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_i_right_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_d_right_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_c_right_bus (clock);

    /* Instanciate all the BRAMs (ROMs) from files */
    sim_simple_rom_from_file_bram_interface #(
        .FILENAME("input/bram_hap_bases.txt")
    ) bram_hap_bases (
        .bus(bram_hap_base_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .FILENAME("input/bram_read_bases.txt")
    ) bram_read_bases (
        .bus(bram_read_base_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_q.txt")
    ) bram_read_q (
        .bus(bram_read_q_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_i.txt")
    ) bram_read_i (
        .bus(bram_read_i_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_d.txt")
    ) bram_read_d (
        .bus(bram_read_d_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_c.txt")
    ) bram_read_c (
        .bus(bram_read_c_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_i.txt")
    ) bram_read_i_r (
        .bus(bram_read_i_right_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_d.txt")
    ) bram_read_d_r (
        .bus(bram_read_d_right_bus)
    );

    sim_simple_rom_from_file_bram_interface #(
        .QUAL_OFFSET(QUAL_OFFSET),
        .FILENAME("input/bram_read_c.txt")
    ) bram_read_c_r (
        .bus(bram_read_c_right_bus)
    );

    /* Same read enable for all the read related ROMs */
    assign #0 bram_read_base_bus.read_en = read_read_en;
    assign #0 bram_read_q_bus.read_en = read_read_en;
    assign #0 bram_read_i_bus.read_en = read_read_en;
    assign #0 bram_read_d_bus.read_en = read_read_en;
    assign #0 bram_read_c_bus.read_en = read_read_en;
    assign #0 bram_read_i_right_bus.read_en = read_read_en;
    assign #0 bram_read_d_right_bus.read_en = read_read_en;
    assign #0 bram_read_c_right_bus.read_en = read_read_en;

    /* Same address for all the read related ROMs */
    assign #0 bram_read_base_bus.read_addr = read_read_addr;
    assign #0 bram_read_q_bus.read_addr = read_read_addr;
    assign #0 bram_read_i_bus.read_addr = read_read_addr;
    assign #0 bram_read_d_bus.read_addr = read_read_addr;
    assign #0 bram_read_c_bus.read_addr = read_read_addr;
    assign #0 bram_read_i_right_bus.read_addr = read_read_addr + 1;
    assign #0 bram_read_d_right_bus.read_addr = read_read_addr + 1;
    assign #0 bram_read_c_right_bus.read_addr = read_read_addr + 1;

    ///////////////////////
    // Device Under Test //
    ///////////////////////
    cl_pairhmm_worker_core #(
        .MAX_SEQUENCE_LENGTH(2048)
        ) dut (
        .clock_i(clock),
        .reset_i(reset),
        .enable_i(enable),

        .read_len_i(read_len),
        .read_pos_o(read_read_addr),
        .read_read_o(read_read_en),
        .read_base_i(bram_read_base_bus.read_data),
        .read_q_i(bram_read_q_bus.read_data),
        .read_i_i(bram_read_i_bus.read_data),
        .read_d_i(bram_read_d_bus.read_data),
        .read_c_i(bram_read_c_bus.read_data),
        .read_i_right_i(bram_read_i_right_bus.read_data),
        .read_d_right_i(bram_read_d_right_bus.read_data),
        .read_c_right_i(bram_read_c_right_bus.read_data),

        .hap_len_i(hap_len),
        .hap_pos_o(bram_hap_base_bus.read_addr),
        .hap_read_o(bram_hap_base_bus.read_en),
        .hap_base_i(bram_hap_base_bus.read_data),

        .compute_ready_i(compute_ready),
        .request_o(request_obs),
        .write_req_o(request_valid),

        .result_ready_i(result_valid),
        .result_i(result_obs),
        .read_result_o(read_result_obs),

        .result_o(final_result_obs),
        .result_valid_o(final_result_valid_obs));

    //////////////////////////////
    // Simulated Compute Engine //
    //////////////////////////////
    sim_compute_engine compute_core (
        .clock_i(clock),
        .reset_i(reset),

        .request_i(request_obs),
        .request_valid_i(request_valid),
        .compute_engine_ready_o(compute_ready),

        .result_o(result_obs),
        .result_valid_o(result_valid),
        .read_result_i(read_result_obs)
    );

endmodule // sim_worker_tb
