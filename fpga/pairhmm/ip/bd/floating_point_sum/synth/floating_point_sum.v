//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
//Date        : Tue May  7 15:39:29 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target floating_point_sum.bd
//Design      : floating_point_sum
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "floating_point_sum,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=floating_point_sum,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "floating_point_sum.hwdef" *) 
module floating_point_sum
   (M_AXIS_SUM_RESULT_tdata,
    M_AXIS_SUM_RESULT_tready,
    M_AXIS_SUM_RESULT_tuser,
    M_AXIS_SUM_RESULT_tvalid,
    S_AXIS_A_tdata,
    S_AXIS_A_tready,
    S_AXIS_A_tuser,
    S_AXIS_A_tvalid,
    S_AXIS_B_tdata,
    S_AXIS_B_tready,
    S_AXIS_B_tvalid,
    aclk,
    aresetn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_SUM_RESULT TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_SUM_RESULT, CLK_DOMAIN floating_point_sum_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 8}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 8}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 8}}}}}} TUSER_WIDTH 8}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 8" *) output [31:0]M_AXIS_SUM_RESULT_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_SUM_RESULT TREADY" *) input M_AXIS_SUM_RESULT_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_SUM_RESULT TUSER" *) output [7:0]M_AXIS_SUM_RESULT_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_SUM_RESULT TVALID" *) output M_AXIS_SUM_RESULT_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_A TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_A, CLK_DOMAIN floating_point_sum_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 8" *) input [31:0]S_AXIS_A_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_A TREADY" *) output S_AXIS_A_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_A TUSER" *) input [7:0]S_AXIS_A_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_A TVALID" *) input S_AXIS_A_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_B TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_B, CLK_DOMAIN floating_point_sum_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_B_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_B TREADY" *) output S_AXIS_B_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_B TVALID" *) input S_AXIS_B_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF M_AXIS_SUM_RESULT:S_AXIS_A:S_AXIS_B, ASSOCIATED_RESET aresetn, CLK_DOMAIN floating_point_sum_aclk, FREQ_HZ 10000000, PHASE 0.000" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW" *) input aresetn;

  wire [31:0]S_AXIS_A_0_1_TDATA;
  wire S_AXIS_A_0_1_TREADY;
  wire [7:0]S_AXIS_A_0_1_TUSER;
  wire S_AXIS_A_0_1_TVALID;
  wire [31:0]S_AXIS_B_0_1_TDATA;
  wire S_AXIS_B_0_1_TREADY;
  wire S_AXIS_B_0_1_TVALID;
  wire aclk_0_1;
  wire aresetn_0_1;
  wire [31:0]floating_point_sum_0_M_AXIS_RESULT_TDATA;
  wire floating_point_sum_0_M_AXIS_RESULT_TREADY;
  wire [7:0]floating_point_sum_0_M_AXIS_RESULT_TUSER;
  wire floating_point_sum_0_M_AXIS_RESULT_TVALID;

  assign M_AXIS_SUM_RESULT_tdata[31:0] = floating_point_sum_0_M_AXIS_RESULT_TDATA;
  assign M_AXIS_SUM_RESULT_tuser[7:0] = floating_point_sum_0_M_AXIS_RESULT_TUSER;
  assign M_AXIS_SUM_RESULT_tvalid = floating_point_sum_0_M_AXIS_RESULT_TVALID;
  assign S_AXIS_A_0_1_TDATA = S_AXIS_A_tdata[31:0];
  assign S_AXIS_A_0_1_TUSER = S_AXIS_A_tuser[7:0];
  assign S_AXIS_A_0_1_TVALID = S_AXIS_A_tvalid;
  assign S_AXIS_A_tready = S_AXIS_A_0_1_TREADY;
  assign S_AXIS_B_0_1_TDATA = S_AXIS_B_tdata[31:0];
  assign S_AXIS_B_0_1_TVALID = S_AXIS_B_tvalid;
  assign S_AXIS_B_tready = S_AXIS_B_0_1_TREADY;
  assign aclk_0_1 = aclk;
  assign aresetn_0_1 = aresetn;
  assign floating_point_sum_0_M_AXIS_RESULT_TREADY = M_AXIS_SUM_RESULT_tready;
  floating_point_sum_floating_point_sum_0_0 floating_point_sum_0
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .m_axis_result_tdata(floating_point_sum_0_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(floating_point_sum_0_M_AXIS_RESULT_TREADY),
        .m_axis_result_tuser(floating_point_sum_0_M_AXIS_RESULT_TUSER),
        .m_axis_result_tvalid(floating_point_sum_0_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_1_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_1_TREADY),
        .s_axis_a_tuser(S_AXIS_A_0_1_TUSER),
        .s_axis_a_tvalid(S_AXIS_A_0_1_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_1_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_1_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_1_TVALID));
endmodule
