//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_conveyer_axi_s.sv
// Description  : This is just a wrapper with interfaces
//
// Author       : Rick Wertenbroek
// Date         : 09.04.19
// Version      : 0.0
//
// Dependencies : cl_conveyer.sv
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    09.04.19           Creation
//-----------------------------------------------------------------------------

module cl_conveyer_axi_s #(
    parameter type T = logic[7:0],
    parameter REG_VERSION = 1
) (
    // Standard signals
    input logic clock_i,
    input logic reset_i,
    // In High-Priority Stream
    axi_stream_generic_if.slave  in_hi_pri,
    // In Low-Priority Stream
    axi_stream_generic_if.slave  in_lo_pri,
    // Out High-Priority Stream
    axi_stream_generic_if.master out_hi_pri,
    // Out Low-Priority Stream
    axi_stream_generic_if.master out_lo_pri
);

    cl_conveyer #(
        .T(T),
        .REG_VERSION(REG_VERSION)
    ) wrapped_conveyer (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .in_hi_pri_tdata(in_hi_pri.tdata),
        .in_hi_pri_tvalid(in_hi_pri.tvalid),
        .in_hi_pri_tready(in_hi_pri.tready),
        .in_lo_pri_tdata(in_lo_pri.tdata),
        .in_lo_pri_tvalid(in_lo_pri.tvalid),
        .in_lo_pri_tready(in_lo_pri.tready),
        .out_hi_pri_tdata(out_hi_pri.tdata),
        .out_hi_pri_tvalid(out_hi_pri.tvalid),
        .out_hi_pri_tready(out_hi_pri.tready),
        .out_lo_pri_tdata(out_lo_pri.tdata),
        .out_lo_pri_tvalid(out_lo_pri.tvalid),
        .out_lo_pri_tready(out_lo_pri.tready)
    );

endmodule // cl_conveyer_axi_s
