//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_compute_result_combiner.sv
// Description  : This module groups the outputs of the compute engine into
//                results and applies back-pressure to the compute engine
//                streams that are ready before the others.
//                This module could also be used to route results according to
//                the ID of the result.
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

module cl_compute_result_combiner (
    input logic clock_i,
    input logic reset_i,

    // Compute results to workers
    fifo_if.master_write result_bus,

    // AXI-Stream interfaces from compute engine
    axi_stream_simple_if.slave s_axis_result_ta,
    axi_stream_simple_if.slave s_axis_result_tb,
    axi_stream_simple_if.slave s_axis_result_match,
    axi_stream_simple_if.slave s_axis_result_insertion,
    axi_stream_simple_if.slave s_axis_result_deletion,
    axi_stream_simple_if.slave s_axis_id
);

    logic result_combiner_ready;

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // The combiner is ready if the output bus is not full and if all the inputs are valid
    // This is OK since the master must not wait on ready to be valid (AXI4-Stream)
    assign result_combiner_ready = (~result_bus.full) & (&{s_axis_result_ta.tvalid,
                                                           s_axis_result_tb.tvalid,
                                                           s_axis_result_match.tvalid,
                                                           s_axis_result_insertion.tvalid,
                                                           s_axis_result_deletion.tvalid,
                                                           s_axis_id.tvalid});

    /////////////
    // Outputs //
    /////////////

    // Write to the output bus when we are ready (this takes the bus "full" signal into account)
    assign result_bus.write = result_combiner_ready;

    // Assign the results to the result output bus
    assign result_bus.write_data.match     = s_axis_result_match.tdata;
    assign result_bus.write_data.insertion = s_axis_result_insertion.tdata;
    assign result_bus.write_data.deletion  = s_axis_result_deletion.tdata;
    assign result_bus.write_data.temp_A    = s_axis_result_ta.tdata;
    assign result_bus.write_data.temp_B    = s_axis_result_tb.tdata;
    // TODO : Manage ID

    // Ready signal is the same for all streams
    // AXI-Stream transfers when tready and tvalid are both asserted
    assign s_axis_result_ta.tready         = result_combiner_ready;
    assign s_axis_result_tb.tready         = result_combiner_ready;
    assign s_axis_result_match.tready      = result_combiner_ready;
    assign s_axis_result_insertion.tready  = result_combiner_ready;
    assign s_axis_result_deletion.tready   = result_combiner_ready;
    assign s_axis_id.tready                = result_combiner_ready;

endmodule // cl_compute_result_combiner
