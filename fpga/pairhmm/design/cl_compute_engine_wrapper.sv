//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_compute_engine_wrapper.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 05.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    05.03.19           Creation
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_compute_engine_wrapper (
    // Standard inputs
    input logic clock_i,
    input logic reset_i,

    // Input stream (Could be multiple streams in the future)
    fifo_if.slave_write compute_req_bus,

    // Output stream (Could be multiple streams in the future)
    fifo_if.master_write result_bus
);

    ////////////
    // Busses //
    ////////////

    //localparam NUM_BYTES = $bits(PairHMMPackage::floating_point_t) / $bits(byte);
    localparam NUM_BYTES = 4;
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_top_insertion(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_top_deletion(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_one_min_c_qual_right(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_top_match(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_i_qual_right(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_d_qual_right(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_left_ta(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_left_tb(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_prior(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_i_qual(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_left_match(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_c_qual(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_left_insertion(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_d_qual(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_top_match_bis(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_c_qual_bis(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_top_deletion_bis(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_id(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_result_ta(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_result_tb(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_result_match(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_result_insertion(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_result_deletion(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_id_out(.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(NUM_BYTES)) axis_one_constant(.aclk(clock_i));

    //////////////////////////
    // Instanciated Modules //
    //////////////////////////

    // Compute Stream Separator for Compute Unit
    cl_compute_stream_separator separator (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .compute_req_bus(compute_req_bus),
        .m_axis_top_insertion(axis_top_insertion),
        .m_axis_top_deletion(axis_top_deletion),
        .m_axis_one_min_c_qual_right(axis_one_min_c_qual_right),
        .m_axis_top_match(axis_top_match),
        .m_axis_one_constant(axis_one_constant),
        .m_axis_i_qual_right(axis_i_qual_right),
        .m_axis_d_qual_right(axis_d_qual_right),
        .m_axis_left_ta(axis_left_ta),
        .m_axis_left_tb(axis_left_tb),
        .m_axis_prior(axis_prior),
        .m_axis_i_qual(axis_i_qual),
        .m_axis_left_match(axis_left_match),
        .m_axis_c_qual(axis_c_qual),
        .m_axis_left_insertion(axis_left_insertion),
        .m_axis_d_qual(axis_d_qual),
        .m_axis_top_match_bis(axis_top_match_bis),
        .m_axis_c_qual_bis(axis_c_qual_bis),
        .m_axis_top_deletion_bis(axis_top_deletion_bis),
        .m_axis_id(axis_id)
    );

    // Compute Unit (Compute Engine)
    // Emacs replace regexp to connect empty () ports with busses :
    // \([SM]\)_\(.*?\)_\(t.*?\)(),$ -> \1_\2_\3(\,(downcase \2).\3),
    compute_unit_wrapper compute_core (
        .M_AXIS_ID_tdata(axis_id_out.tdata),
        .M_AXIS_ID_tready(axis_id_out.tready),
        .M_AXIS_ID_tvalid(axis_id_out.tvalid),
        .M_AXIS_RESULT_DELETION_tdata(axis_result_deletion.tdata),
        .M_AXIS_RESULT_DELETION_tready(axis_result_deletion.tready),
        .M_AXIS_RESULT_DELETION_tvalid(axis_result_deletion.tvalid),
        .M_AXIS_RESULT_INSERTION_tdata(axis_result_insertion.tdata),
        .M_AXIS_RESULT_INSERTION_tready(axis_result_insertion.tready),
        .M_AXIS_RESULT_INSERTION_tvalid(axis_result_insertion.tvalid),
        .M_AXIS_RESULT_MATCH_tdata(axis_result_match.tdata),
        .M_AXIS_RESULT_MATCH_tready(axis_result_match.tready),
        .M_AXIS_RESULT_MATCH_tvalid(axis_result_match.tvalid),
        .M_AXIS_RESULT_TA_tdata(axis_result_ta.tdata),
        .M_AXIS_RESULT_TA_tready(axis_result_ta.tready),
        .M_AXIS_RESULT_TA_tvalid(axis_result_ta.tvalid),
        .M_AXIS_RESULT_TB_tdata(axis_result_tb.tdata),
        .M_AXIS_RESULT_TB_tready(axis_result_tb.tready),
        .M_AXIS_RESULT_TB_tvalid(axis_result_tb.tvalid),
        .S_AXIS_C_QUAL_BIS_tdata(axis_c_qual_bis.tdata),
        .S_AXIS_C_QUAL_BIS_tready(axis_c_qual_bis.tready),
        .S_AXIS_C_QUAL_BIS_tvalid(axis_c_qual_bis.tvalid),
        .S_AXIS_C_QUAL_tdata(axis_c_qual.tdata),
        .S_AXIS_C_QUAL_tready(axis_c_qual.tready),
        .S_AXIS_C_QUAL_tvalid(axis_c_qual.tvalid),
        .S_AXIS_D_QUAL_RIGHT_tdata(axis_d_qual_right.tdata),
        .S_AXIS_D_QUAL_RIGHT_tready(axis_d_qual_right.tready),
        .S_AXIS_D_QUAL_RIGHT_tvalid(axis_d_qual_right.tvalid),
        .S_AXIS_D_QUAL_tdata(axis_d_qual.tdata),
        .S_AXIS_D_QUAL_tready(axis_d_qual.tready),
        .S_AXIS_D_QUAL_tvalid(axis_d_qual.tvalid),
        .S_AXIS_ID_tdata(axis_id.tdata),
        .S_AXIS_ID_tready(axis_id.tready),
        .S_AXIS_ID_tvalid(axis_id.tvalid),
        .S_AXIS_I_QUAL_tdata(axis_i_qual.tdata),
        .S_AXIS_I_QUAL_tready(axis_i_qual.tready),
        .S_AXIS_I_QUAL_tvalid(axis_i_qual.tvalid),
        .S_AXIS_LEFT_INSERTION_tdata(axis_left_insertion.tdata),
        .S_AXIS_LEFT_INSERTION_tready(axis_left_insertion.tready),
        .S_AXIS_LEFT_INSERTION_tvalid(axis_left_insertion.tvalid),
        .S_AXIS_LEFT_MATCH_tdata(axis_left_match.tdata),
        .S_AXIS_LEFT_MATCH_tready(axis_left_match.tready),
        .S_AXIS_LEFT_MATCH_tvalid(axis_left_match.tvalid),
        .S_AXIS_LEFT_TA_tdata(axis_left_ta.tdata),
        .S_AXIS_LEFT_TA_tready(axis_left_ta.tready),
        .S_AXIS_LEFT_TA_tvalid(axis_left_ta.tvalid),
        .S_AXIS_LEFT_TB_tdata(axis_left_tb.tdata),
        .S_AXIS_LEFT_TB_tready(axis_left_tb.tready),
        .S_AXIS_LEFT_TB_tvalid(axis_left_tb.tvalid),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata(axis_one_min_c_qual_right.tdata),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready(axis_one_min_c_qual_right.tready),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid(axis_one_min_c_qual_right.tvalid),
        .S_AXIS_ONE_CONSTANT_tdata(axis_one_constant.tdata),
        .S_AXIS_ONE_CONSTANT_tready(axis_one_constant.tready),
        .S_AXIS_ONE_CONSTANT_tvalid(axis_one_constant.tvalid),
        .S_AXIS_I_QUAL_RIGHT_tdata(axis_i_qual_right.tdata),
        .S_AXIS_I_QUAL_RIGHT_tready(axis_i_qual_right.tready),
        .S_AXIS_I_QUAL_RIGHT_tvalid(axis_i_qual_right.tvalid),
        .S_AXIS_PRIOR_tdata(axis_prior.tdata),
        .S_AXIS_PRIOR_tready(axis_prior.tready),
        .S_AXIS_PRIOR_tvalid(axis_prior.tvalid),
        .S_AXIS_TOP_DELETION_BIS_tdata(axis_top_deletion_bis.tdata),
        .S_AXIS_TOP_DELETION_BIS_tready(axis_top_deletion_bis.tready),
        .S_AXIS_TOP_DELETION_BIS_tvalid(axis_top_deletion_bis.tvalid),
        .S_AXIS_TOP_DELETION_tdata(axis_top_deletion.tdata),
        .S_AXIS_TOP_DELETION_tready(axis_top_deletion.tready),
        .S_AXIS_TOP_DELETION_tvalid(axis_top_deletion.tvalid),
        .S_AXIS_TOP_INSERTION_tdata(axis_top_insertion.tdata),
        .S_AXIS_TOP_INSERTION_tready(axis_top_insertion.tready),
        .S_AXIS_TOP_INSERTION_tvalid(axis_top_insertion.tvalid),
        .S_AXIS_TOP_MATCH_BIS_tdata(axis_top_match_bis.tdata),
        .S_AXIS_TOP_MATCH_BIS_tready(axis_top_match_bis.tready),
        .S_AXIS_TOP_MATCH_BIS_tvalid(axis_top_match_bis.tvalid),
        .S_AXIS_TOP_MATCH_tdata(axis_top_match.tdata),
        .S_AXIS_TOP_MATCH_tready(axis_top_match.tready),
        .S_AXIS_TOP_MATCH_tvalid(axis_top_match.tvalid),
        .aclk(clock_i),
        .aresetn(~reset_i)
    );

    // Compute Result Combiner for results from Compute Unit (engine)
    cl_compute_result_combiner combiner (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .result_bus(result_bus),
        .s_axis_result_ta(axis_result_ta),
        .s_axis_result_tb(axis_result_tb),
        .s_axis_result_match(axis_result_match),
        .s_axis_result_insertion(axis_result_insertion),
        .s_axis_result_deletion(axis_result_deletion),
        .s_axis_id(axis_id_out)
    );

endmodule // cl_compute_engine_wrapper
