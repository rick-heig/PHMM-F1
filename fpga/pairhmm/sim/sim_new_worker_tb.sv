//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_new_worker_tb.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 13.02.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    13.02.19           Creation
//-----------------------------------------------------------------------------

//`include "cl_defines.vh"
`include "cl_pairhmm_package.vh"

module sim_new_worker_tb;
    logic reset;
    logic clock = 'b0;
    logic enable;
    logic final_result_valid_obs;

    /* Ref : https://www.drive5.com/usearch/manual/quality_score.html */
    localparam QUAL_OFFSET = 33; /* Phred score offset - Illumina, Ion Torrent, PacBio, and Sanger */

    localparam MAX_SEQUENCE_LENGTH = 2048;
    localparam ADDR_WIDTH = $clog2(MAX_SEQUENCE_LENGTH);
    localparam HAP_LEN = 41;

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

    fifo_if #(.T(PairHMMPackage::floating_point_t)) final_result_bus(clock);
    assign #0 final_result_bus.full = 0;

    bram_if #(.T(PairHMMPackage::read_base_info_t), .ADDR_WIDTH(ADDR_WIDTH)) read_info_bus(clock);
    bram_if #(.T(PairHMMPackage::hap_base_info_t),  .ADDR_WIDTH(ADDR_WIDTH)) hap_info_bus(clock);

    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_hap_base_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_base_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_q_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_i_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_d_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_c_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_i_right_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_d_right_bus (clock);
    bram_t #(.T(logic[7:0]), .ADDR_WIDTH(ADDR_WIDTH)) bram_read_c_right_bus (clock);

    assign #0 bram_hap_base_bus.read_en   = hap_info_bus.read_en;
    assign #0 bram_hap_base_bus.read_addr = hap_info_bus.read_addr;
    assign #0 hap_info_bus.read_data.base = bram_hap_base_bus.read_data;

    /* Same read enable for all the read related ROMs */
    assign #0 bram_read_base_bus.read_en    = read_info_bus.read_en;
    assign #0 bram_read_q_bus.read_en       = read_info_bus.read_en;
    assign #0 bram_read_i_bus.read_en       = read_info_bus.read_en;
    assign #0 bram_read_d_bus.read_en       = read_info_bus.read_en;
    assign #0 bram_read_c_bus.read_en       = read_info_bus.read_en;
    assign #0 bram_read_i_right_bus.read_en = read_info_bus.read_en;
    assign #0 bram_read_d_right_bus.read_en = read_info_bus.read_en;
    assign #0 bram_read_c_right_bus.read_en = read_info_bus.read_en;

    /* Same address for all the read related ROMs */
    assign #0 bram_read_base_bus.read_addr    = read_info_bus.read_addr;
    assign #0 bram_read_q_bus.read_addr       = read_info_bus.read_addr;
    assign #0 bram_read_i_bus.read_addr       = read_info_bus.read_addr;
    assign #0 bram_read_d_bus.read_addr       = read_info_bus.read_addr;
    assign #0 bram_read_c_bus.read_addr       = read_info_bus.read_addr;
    assign #0 bram_read_i_right_bus.read_addr = read_info_bus.read_addr + 1;
    assign #0 bram_read_d_right_bus.read_addr = read_info_bus.read_addr + 1;
    assign #0 bram_read_c_right_bus.read_addr = read_info_bus.read_addr + 1;

    assign #0 read_info_bus.read_data = '{bram_read_base_bus.read_data,
                                          '{bram_read_q_bus.read_data,
                                            bram_read_i_bus.read_data,
                                            bram_read_d_bus.read_data,
                                            bram_read_c_bus.read_data},
                                          bram_read_i_right_bus.read_data,
                                          bram_read_d_right_bus.read_data,
                                          bram_read_c_right_bus.read_data};

    fifo_if #(.T(PairHMMPackage::request_t)) compute_request_bus(clock);
    fifo_if #(.T(PairHMMPackage::result_t))  compute_result_bus(clock);

    ///////////////////////
    // Device Under Test //
    ///////////////////////
    cl_pairhmm_new_worker_core_synth #(
        .MAX_SEQUENCE_LENGTH(MAX_SEQUENCE_LENGTH),
        .DEBUG_VERBOSITY(1)
    ) dut (
        .clock_i(clock),
        .reset_i(reset),
        .enable_i(enable),
        .read_len_i(11'd41), // Minus 1 because zero based, Plus 1 because extra row
        .hap_len_i(HAP_LEN), // Minus 1 because zero based
        .initial_condition_i($shortrealtobits(shortreal'(3.402823e+38 / (16 * HAP_LEN)))),
        .read_info_bus(read_info_bus),
        .hap_info_bus(hap_info_bus),
        .compute_request_bus(compute_request_bus),
        .compute_result_bus(compute_result_bus),
        .final_result_bus(final_result_bus)
    );

    assign #0 final_result_valid_obs = final_result_bus.write;

    ////////////////////////////
    // Simulated Compute Core //
    ////////////////////////////
    sim_compute_engine_fifo_if compute_engine (
        .clock_i(clock),
        .reset_i(reset),
        .compute_request_bus(compute_request_bus),
        .compute_result_bus(compute_result_bus)
    );

    //////////////
    // Memories //
    //////////////

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

endmodule // sim_new_worker_tb
