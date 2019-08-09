//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
//Date        : Tue May  7 15:41:52 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target compute_unit.bd
//Design      : compute_unit
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "compute_unit,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=compute_unit,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=17,numReposBlks=17,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "compute_unit.hwdef" *) 
module compute_unit
   (M_AXIS_ID_tdata,
    M_AXIS_ID_tready,
    M_AXIS_ID_tvalid,
    M_AXIS_RESULT_DELETION_tdata,
    M_AXIS_RESULT_DELETION_tready,
    M_AXIS_RESULT_DELETION_tvalid,
    M_AXIS_RESULT_INSERTION_tdata,
    M_AXIS_RESULT_INSERTION_tready,
    M_AXIS_RESULT_INSERTION_tvalid,
    M_AXIS_RESULT_MATCH_tdata,
    M_AXIS_RESULT_MATCH_tready,
    M_AXIS_RESULT_MATCH_tvalid,
    M_AXIS_RESULT_TA_tdata,
    M_AXIS_RESULT_TA_tready,
    M_AXIS_RESULT_TA_tvalid,
    M_AXIS_RESULT_TB_tdata,
    M_AXIS_RESULT_TB_tready,
    M_AXIS_RESULT_TB_tvalid,
    S_AXIS_C_QUAL_BIS_tdata,
    S_AXIS_C_QUAL_BIS_tready,
    S_AXIS_C_QUAL_BIS_tvalid,
    S_AXIS_C_QUAL_tdata,
    S_AXIS_C_QUAL_tready,
    S_AXIS_C_QUAL_tvalid,
    S_AXIS_D_QUAL_RIGHT_tdata,
    S_AXIS_D_QUAL_RIGHT_tready,
    S_AXIS_D_QUAL_RIGHT_tvalid,
    S_AXIS_D_QUAL_tdata,
    S_AXIS_D_QUAL_tready,
    S_AXIS_D_QUAL_tvalid,
    S_AXIS_ID_tdata,
    S_AXIS_ID_tready,
    S_AXIS_ID_tvalid,
    S_AXIS_I_QUAL_RIGHT_tdata,
    S_AXIS_I_QUAL_RIGHT_tready,
    S_AXIS_I_QUAL_RIGHT_tvalid,
    S_AXIS_I_QUAL_tdata,
    S_AXIS_I_QUAL_tready,
    S_AXIS_I_QUAL_tvalid,
    S_AXIS_LEFT_INSERTION_tdata,
    S_AXIS_LEFT_INSERTION_tready,
    S_AXIS_LEFT_INSERTION_tvalid,
    S_AXIS_LEFT_MATCH_tdata,
    S_AXIS_LEFT_MATCH_tready,
    S_AXIS_LEFT_MATCH_tvalid,
    S_AXIS_LEFT_TA_tdata,
    S_AXIS_LEFT_TA_tready,
    S_AXIS_LEFT_TA_tvalid,
    S_AXIS_LEFT_TB_tdata,
    S_AXIS_LEFT_TB_tready,
    S_AXIS_LEFT_TB_tvalid,
    S_AXIS_ONE_CONSTANT_tdata,
    S_AXIS_ONE_CONSTANT_tready,
    S_AXIS_ONE_CONSTANT_tvalid,
    S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata,
    S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready,
    S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid,
    S_AXIS_PRIOR_tdata,
    S_AXIS_PRIOR_tready,
    S_AXIS_PRIOR_tvalid,
    S_AXIS_TOP_DELETION_BIS_tdata,
    S_AXIS_TOP_DELETION_BIS_tready,
    S_AXIS_TOP_DELETION_BIS_tvalid,
    S_AXIS_TOP_DELETION_tdata,
    S_AXIS_TOP_DELETION_tready,
    S_AXIS_TOP_DELETION_tvalid,
    S_AXIS_TOP_INSERTION_tdata,
    S_AXIS_TOP_INSERTION_tready,
    S_AXIS_TOP_INSERTION_tvalid,
    S_AXIS_TOP_MATCH_BIS_tdata,
    S_AXIS_TOP_MATCH_BIS_tready,
    S_AXIS_TOP_MATCH_BIS_tvalid,
    S_AXIS_TOP_MATCH_tdata,
    S_AXIS_TOP_MATCH_tready,
    S_AXIS_TOP_MATCH_tvalid,
    aclk,
    aresetn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_ID TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_ID, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_ID_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_ID TREADY" *) input M_AXIS_ID_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_ID TVALID" *) output M_AXIS_ID_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_DELETION TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_RESULT_DELETION, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_RESULT_DELETION_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_DELETION TREADY" *) input M_AXIS_RESULT_DELETION_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_DELETION TVALID" *) output M_AXIS_RESULT_DELETION_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_INSERTION TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_RESULT_INSERTION, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_RESULT_INSERTION_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_INSERTION TREADY" *) input M_AXIS_RESULT_INSERTION_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_INSERTION TVALID" *) output M_AXIS_RESULT_INSERTION_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_MATCH TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_RESULT_MATCH, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_RESULT_MATCH_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_MATCH TREADY" *) input M_AXIS_RESULT_MATCH_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_MATCH TVALID" *) output M_AXIS_RESULT_MATCH_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TA TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_RESULT_TA, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_RESULT_TA_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TA TREADY" *) input M_AXIS_RESULT_TA_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TA TVALID" *) output M_AXIS_RESULT_TA_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TB TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_RESULT_TB, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency width format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {float {sigwidth {attribs {resolve_type generated dependency fractwidth format long minimum {} maximum {}} value 24}}}}} TDATA_WIDTH 32 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_underflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value underflow} enabled {attribs {resolve_type generated dependency underflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency underflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value overflow} enabled {attribs {resolve_type generated dependency overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_invalid_op {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value invalid_op} enabled {attribs {resolve_type generated dependency invalid_op_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency invalid_op_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency invalid_op_bitoffset format long minimum {} maximum {}} value 0}}} field_div_by_zero {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value div_by_zero} enabled {attribs {resolve_type generated dependency div_by_zero_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency div_by_zero_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency div_by_zero_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_input_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_input_overflow} enabled {attribs {resolve_type generated dependency accum_input_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_input_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_input_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_accum_overflow {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value accum_overflow} enabled {attribs {resolve_type generated dependency accum_overflow_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency accum_overflow_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency accum_overflow_bitoffset format long minimum {} maximum {}} value 0}}} field_a_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value a_tuser} enabled {attribs {resolve_type generated dependency a_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency a_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency a_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_b_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value b_tuser} enabled {attribs {resolve_type generated dependency b_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency b_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency b_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_c_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value c_tuser} enabled {attribs {resolve_type generated dependency c_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency c_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency c_tuser_bitoffset format long minimum {} maximum {}} value 0}}} field_operation_tuser {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value operation_tuser} enabled {attribs {resolve_type generated dependency operation_tuser_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency operation_tuser_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency operation_tuser_bitoffset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_RESULT_TB_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TB TREADY" *) input M_AXIS_RESULT_TB_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT_TB TVALID" *) output M_AXIS_RESULT_TB_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL_BIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_C_QUAL_BIS, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_C_QUAL_BIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL_BIS TREADY" *) output S_AXIS_C_QUAL_BIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL_BIS TVALID" *) input S_AXIS_C_QUAL_BIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_C_QUAL, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_C_QUAL_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL TREADY" *) output S_AXIS_C_QUAL_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_C_QUAL TVALID" *) input S_AXIS_C_QUAL_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL_RIGHT TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_D_QUAL_RIGHT, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_D_QUAL_RIGHT_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL_RIGHT TREADY" *) output S_AXIS_D_QUAL_RIGHT_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL_RIGHT TVALID" *) input S_AXIS_D_QUAL_RIGHT_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_D_QUAL, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_D_QUAL_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL TREADY" *) output S_AXIS_D_QUAL_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_D_QUAL TVALID" *) input S_AXIS_D_QUAL_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ID TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_ID, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_ID_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ID TREADY" *) output S_AXIS_ID_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ID TVALID" *) input S_AXIS_ID_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL_RIGHT TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_I_QUAL_RIGHT, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_I_QUAL_RIGHT_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL_RIGHT TREADY" *) output S_AXIS_I_QUAL_RIGHT_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL_RIGHT TVALID" *) input S_AXIS_I_QUAL_RIGHT_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_I_QUAL, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_I_QUAL_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL TREADY" *) output S_AXIS_I_QUAL_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_I_QUAL TVALID" *) input S_AXIS_I_QUAL_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_INSERTION TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_LEFT_INSERTION, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_LEFT_INSERTION_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_INSERTION TREADY" *) output S_AXIS_LEFT_INSERTION_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_INSERTION TVALID" *) input S_AXIS_LEFT_INSERTION_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_MATCH TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_LEFT_MATCH, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_LEFT_MATCH_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_MATCH TREADY" *) output S_AXIS_LEFT_MATCH_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_MATCH TVALID" *) input S_AXIS_LEFT_MATCH_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TA TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_LEFT_TA, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_LEFT_TA_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TA TREADY" *) output S_AXIS_LEFT_TA_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TA TVALID" *) input S_AXIS_LEFT_TA_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TB TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_LEFT_TB, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_LEFT_TB_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TB TREADY" *) output S_AXIS_LEFT_TB_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_LEFT_TB TVALID" *) input S_AXIS_LEFT_TB_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_CONSTANT TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_ONE_CONSTANT, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_ONE_CONSTANT_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_CONSTANT TREADY" *) output S_AXIS_ONE_CONSTANT_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_CONSTANT TVALID" *) input S_AXIS_ONE_CONSTANT_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_MIN_C_QUAL_RIGHT TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_ONE_MIN_C_QUAL_RIGHT, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_MIN_C_QUAL_RIGHT TREADY" *) output S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_ONE_MIN_C_QUAL_RIGHT TVALID" *) input S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_PRIOR TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_PRIOR, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_PRIOR_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_PRIOR TREADY" *) output S_AXIS_PRIOR_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_PRIOR TVALID" *) input S_AXIS_PRIOR_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION_BIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_TOP_DELETION_BIS, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_TOP_DELETION_BIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION_BIS TREADY" *) output S_AXIS_TOP_DELETION_BIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION_BIS TVALID" *) input S_AXIS_TOP_DELETION_BIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_TOP_DELETION, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_TOP_DELETION_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION TREADY" *) output S_AXIS_TOP_DELETION_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_DELETION TVALID" *) input S_AXIS_TOP_DELETION_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_INSERTION TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_TOP_INSERTION, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_TOP_INSERTION_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_INSERTION TREADY" *) output S_AXIS_TOP_INSERTION_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_INSERTION TVALID" *) input S_AXIS_TOP_INSERTION_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH_BIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_TOP_MATCH_BIS, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_TOP_MATCH_BIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH_BIS TREADY" *) output S_AXIS_TOP_MATCH_BIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH_BIS TVALID" *) input S_AXIS_TOP_MATCH_BIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_TOP_MATCH, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_TOP_MATCH_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH TREADY" *) output S_AXIS_TOP_MATCH_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_TOP_MATCH TVALID" *) input S_AXIS_TOP_MATCH_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF S_AXIS_fI_j:S_AXIS_fD_j:S_AXIS_a_dm:S_AXIS_a_mm:S_AXIS_fM_j:S_AXIS_ta_i:S_AXIS_tb_i:S_AXIS_prior:S_AXIS_a_mi:S_AXIS_fM_i:S_AXIS_a_ii:S_AXIS_fI_i:S_AXIS_a_md:S_AXIS_fM_j_copy:S_AXIS_a_dd:S_AXIS_fD_j_copy:M_AXIS_RESULT_TBA:M_AXIS_RESULT_TB:M_AXIS_RESULT_MATCH:M_AXIS_RESULT_INSERTION:M_AXIS_RESULT_DELETION:M_AXIS_RESULT_TA:S_AXIS_TOP_INSERTION:S_AXIS_TOP_DELETION:S_AXIS_ONE_MIN_C_QUAL_RIGHT:S_AXIS_TOP_MATCH:S_AXIS_ONE_MIN_I_QUAL_RIGHT:S_AXIS_D_QUAL_RIGHT:S_AXIS_LEFT_TA:S_AXIS_LEFT_TB:S_AXIS_I_QUAL:S_AXIS_LEFT_MATCH:S_AXIS_C_QUAL:S_AXIS_LEFT_INSERTION:S_AXIS_D_QUAL:S_AXIS_TOP_MATCH_BIS:S_AXIS_C_QUAL_BIS:S_AXIS_TOP_DELETION_BIS:M_AXIS_ID:S_AXIS_ID:S_AXIS_ONE_CONSTANT:S_AXIS_I_QUAL_RIGHT, ASSOCIATED_RESET aresetn, CLK_DOMAIN compute_unit_aclk, FREQ_HZ 10000000, PHASE 0.000" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW" *) input aresetn;

  wire [31:0]S_AXIS_0_1_TDATA;
  wire S_AXIS_0_1_TREADY;
  wire S_AXIS_0_1_TVALID;
  wire [31:0]S_AXIS_0_2_TDATA;
  wire S_AXIS_0_2_TREADY;
  wire S_AXIS_0_2_TVALID;
  wire [31:0]S_AXIS_0_3_TDATA;
  wire S_AXIS_0_3_TREADY;
  wire S_AXIS_0_3_TVALID;
  wire [31:0]S_AXIS_0_4_TDATA;
  wire S_AXIS_0_4_TREADY;
  wire S_AXIS_0_4_TVALID;
  wire [31:0]S_AXIS_A_0_1_TDATA;
  wire S_AXIS_A_0_1_TREADY;
  wire S_AXIS_A_0_1_TVALID;
  wire [31:0]S_AXIS_A_0_3_TDATA;
  wire S_AXIS_A_0_3_TREADY;
  wire S_AXIS_A_0_3_TVALID;
  wire [31:0]S_AXIS_A_0_4_TDATA;
  wire S_AXIS_A_0_4_TREADY;
  wire S_AXIS_A_0_4_TVALID;
  wire [31:0]S_AXIS_A_0_5_TDATA;
  wire S_AXIS_A_0_5_TREADY;
  wire S_AXIS_A_0_5_TVALID;
  wire [31:0]S_AXIS_A_0_6_TDATA;
  wire S_AXIS_A_0_6_TREADY;
  wire S_AXIS_A_0_6_TVALID;
  wire [31:0]S_AXIS_A_0_7_TDATA;
  wire S_AXIS_A_0_7_TREADY;
  wire S_AXIS_A_0_7_TVALID;
  wire [31:0]S_AXIS_A_0_8_TDATA;
  wire S_AXIS_A_0_8_TREADY;
  wire S_AXIS_A_0_8_TVALID;
  wire [31:0]S_AXIS_B_0_1_TDATA;
  wire S_AXIS_B_0_1_TREADY;
  wire S_AXIS_B_0_1_TVALID;
  wire [31:0]S_AXIS_B_0_3_TDATA;
  wire S_AXIS_B_0_3_TREADY;
  wire S_AXIS_B_0_3_TVALID;
  wire [31:0]S_AXIS_B_0_4_TDATA;
  wire S_AXIS_B_0_4_TREADY;
  wire S_AXIS_B_0_4_TVALID;
  wire [31:0]S_AXIS_B_0_5_TDATA;
  wire S_AXIS_B_0_5_TREADY;
  wire S_AXIS_B_0_5_TVALID;
  wire [31:0]S_AXIS_B_0_6_TDATA;
  wire S_AXIS_B_0_6_TREADY;
  wire S_AXIS_B_0_6_TVALID;
  wire [31:0]S_AXIS_B_0_7_TDATA;
  wire S_AXIS_B_0_7_TREADY;
  wire S_AXIS_B_0_7_TVALID;
  wire [31:0]S_AXIS_D_QUAL_RIGHT_1_TDATA;
  wire S_AXIS_D_QUAL_RIGHT_1_TREADY;
  wire S_AXIS_D_QUAL_RIGHT_1_TVALID;
  wire [31:0]S_AXIS_ONE_CONSTANT_1_TDATA;
  wire S_AXIS_ONE_CONSTANT_1_TREADY;
  wire S_AXIS_ONE_CONSTANT_1_TVALID;
  wire aclk_0_1;
  wire [31:0]add_0_M_AXIS_RESULT_TDATA;
  wire add_0_M_AXIS_RESULT_TREADY;
  wire add_0_M_AXIS_RESULT_TVALID;
  wire [31:0]add_1_M_AXIS_RESULT_TDATA;
  wire add_1_M_AXIS_RESULT_TREADY;
  wire add_1_M_AXIS_RESULT_TVALID;
  wire [31:0]add_2_M_AXIS_RESULT_TDATA;
  wire add_2_M_AXIS_RESULT_TREADY;
  wire add_2_M_AXIS_RESULT_TVALID;
  wire [31:0]add_3_M_AXIS_RESULT_TDATA;
  wire add_3_M_AXIS_RESULT_TREADY;
  wire add_3_M_AXIS_RESULT_TVALID;
  wire [31:0]add_4_M_AXIS_RESULT_TDATA;
  wire add_4_M_AXIS_RESULT_TREADY;
  wire add_4_M_AXIS_RESULT_TVALID;
  wire aresetn_1;
  wire [31:0]axis_data_fifo_0_M_AXIS_TDATA;
  wire axis_data_fifo_0_M_AXIS_TREADY;
  wire axis_data_fifo_0_M_AXIS_TVALID;
  wire [31:0]axis_data_fifo_1_M_AXIS_TDATA;
  wire axis_data_fifo_1_M_AXIS_TREADY;
  wire axis_data_fifo_1_M_AXIS_TVALID;
  wire [31:0]axis_data_fifo_3_M_AXIS1_TDATA;
  wire axis_data_fifo_3_M_AXIS1_TREADY;
  wire axis_data_fifo_3_M_AXIS1_TVALID;
  wire [31:0]axis_data_fifo_3_M_AXIS_TDATA;
  wire axis_data_fifo_3_M_AXIS_TREADY;
  wire axis_data_fifo_3_M_AXIS_TVALID;
  wire [31:0]floating_point_0_M_AXIS_RESULT_TDATA;
  wire floating_point_0_M_AXIS_RESULT_TREADY;
  wire floating_point_0_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_0_M_AXIS_RESULT_TDATA;
  wire mul_0_M_AXIS_RESULT_TREADY;
  wire mul_0_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_1_M_AXIS_RESULT_TDATA;
  wire mul_1_M_AXIS_RESULT_TREADY;
  wire mul_1_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_2_M_AXIS_RESULT_TDATA;
  wire mul_2_M_AXIS_RESULT_TREADY;
  wire mul_2_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_3_M_AXIS_RESULT_TDATA;
  wire mul_3_M_AXIS_RESULT_TREADY;
  wire mul_3_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_4_M_AXIS_RESULT_TDATA;
  wire mul_4_M_AXIS_RESULT_TREADY;
  wire mul_4_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_5_M_AXIS_RESULT_TDATA;
  wire mul_5_M_AXIS_RESULT_TREADY;
  wire mul_5_M_AXIS_RESULT_TVALID;
  wire [31:0]mul_6_M_AXIS_RESULT_TDATA;
  wire mul_6_M_AXIS_RESULT_TREADY;
  wire mul_6_M_AXIS_RESULT_TVALID;

  assign M_AXIS_ID_tdata[31:0] = axis_data_fifo_3_M_AXIS1_TDATA;
  assign M_AXIS_ID_tvalid = axis_data_fifo_3_M_AXIS1_TVALID;
  assign M_AXIS_RESULT_DELETION_tdata[31:0] = add_3_M_AXIS_RESULT_TDATA;
  assign M_AXIS_RESULT_DELETION_tvalid = add_3_M_AXIS_RESULT_TVALID;
  assign M_AXIS_RESULT_INSERTION_tdata[31:0] = add_2_M_AXIS_RESULT_TDATA;
  assign M_AXIS_RESULT_INSERTION_tvalid = add_2_M_AXIS_RESULT_TVALID;
  assign M_AXIS_RESULT_MATCH_tdata[31:0] = mul_2_M_AXIS_RESULT_TDATA;
  assign M_AXIS_RESULT_MATCH_tvalid = mul_2_M_AXIS_RESULT_TVALID;
  assign M_AXIS_RESULT_TA_tdata[31:0] = mul_0_M_AXIS_RESULT_TDATA;
  assign M_AXIS_RESULT_TA_tvalid = mul_0_M_AXIS_RESULT_TVALID;
  assign M_AXIS_RESULT_TB_tdata[31:0] = mul_1_M_AXIS_RESULT_TDATA;
  assign M_AXIS_RESULT_TB_tvalid = mul_1_M_AXIS_RESULT_TVALID;
  assign S_AXIS_0_1_TDATA = S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata[31:0];
  assign S_AXIS_0_1_TVALID = S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid;
  assign S_AXIS_0_2_TDATA = S_AXIS_TOP_MATCH_tdata[31:0];
  assign S_AXIS_0_2_TVALID = S_AXIS_TOP_MATCH_tvalid;
  assign S_AXIS_0_3_TDATA = S_AXIS_PRIOR_tdata[31:0];
  assign S_AXIS_0_3_TVALID = S_AXIS_PRIOR_tvalid;
  assign S_AXIS_0_4_TDATA = S_AXIS_ID_tdata[31:0];
  assign S_AXIS_0_4_TVALID = S_AXIS_ID_tvalid;
  assign S_AXIS_A_0_1_TDATA = S_AXIS_TOP_INSERTION_tdata[31:0];
  assign S_AXIS_A_0_1_TVALID = S_AXIS_TOP_INSERTION_tvalid;
  assign S_AXIS_A_0_3_TDATA = S_AXIS_LEFT_TA_tdata[31:0];
  assign S_AXIS_A_0_3_TVALID = S_AXIS_LEFT_TA_tvalid;
  assign S_AXIS_A_0_4_TDATA = S_AXIS_I_QUAL_tdata[31:0];
  assign S_AXIS_A_0_4_TVALID = S_AXIS_I_QUAL_tvalid;
  assign S_AXIS_A_0_5_TDATA = S_AXIS_C_QUAL_tdata[31:0];
  assign S_AXIS_A_0_5_TVALID = S_AXIS_C_QUAL_tvalid;
  assign S_AXIS_A_0_6_TDATA = S_AXIS_D_QUAL_tdata[31:0];
  assign S_AXIS_A_0_6_TVALID = S_AXIS_D_QUAL_tvalid;
  assign S_AXIS_A_0_7_TDATA = S_AXIS_C_QUAL_BIS_tdata[31:0];
  assign S_AXIS_A_0_7_TVALID = S_AXIS_C_QUAL_BIS_tvalid;
  assign S_AXIS_A_0_8_TDATA = S_AXIS_I_QUAL_RIGHT_tdata[31:0];
  assign S_AXIS_A_0_8_TVALID = S_AXIS_I_QUAL_RIGHT_tvalid;
  assign S_AXIS_B_0_1_TDATA = S_AXIS_TOP_DELETION_tdata[31:0];
  assign S_AXIS_B_0_1_TVALID = S_AXIS_TOP_DELETION_tvalid;
  assign S_AXIS_B_0_3_TDATA = S_AXIS_LEFT_TB_tdata[31:0];
  assign S_AXIS_B_0_3_TVALID = S_AXIS_LEFT_TB_tvalid;
  assign S_AXIS_B_0_4_TDATA = S_AXIS_LEFT_MATCH_tdata[31:0];
  assign S_AXIS_B_0_4_TVALID = S_AXIS_LEFT_MATCH_tvalid;
  assign S_AXIS_B_0_5_TDATA = S_AXIS_LEFT_INSERTION_tdata[31:0];
  assign S_AXIS_B_0_5_TVALID = S_AXIS_LEFT_INSERTION_tvalid;
  assign S_AXIS_B_0_6_TDATA = S_AXIS_TOP_MATCH_BIS_tdata[31:0];
  assign S_AXIS_B_0_6_TVALID = S_AXIS_TOP_MATCH_BIS_tvalid;
  assign S_AXIS_B_0_7_TDATA = S_AXIS_TOP_DELETION_BIS_tdata[31:0];
  assign S_AXIS_B_0_7_TVALID = S_AXIS_TOP_DELETION_BIS_tvalid;
  assign S_AXIS_C_QUAL_BIS_tready = S_AXIS_A_0_7_TREADY;
  assign S_AXIS_C_QUAL_tready = S_AXIS_A_0_5_TREADY;
  assign S_AXIS_D_QUAL_RIGHT_1_TDATA = S_AXIS_D_QUAL_RIGHT_tdata[31:0];
  assign S_AXIS_D_QUAL_RIGHT_1_TVALID = S_AXIS_D_QUAL_RIGHT_tvalid;
  assign S_AXIS_D_QUAL_RIGHT_tready = S_AXIS_D_QUAL_RIGHT_1_TREADY;
  assign S_AXIS_D_QUAL_tready = S_AXIS_A_0_6_TREADY;
  assign S_AXIS_ID_tready = S_AXIS_0_4_TREADY;
  assign S_AXIS_I_QUAL_RIGHT_tready = S_AXIS_A_0_8_TREADY;
  assign S_AXIS_I_QUAL_tready = S_AXIS_A_0_4_TREADY;
  assign S_AXIS_LEFT_INSERTION_tready = S_AXIS_B_0_5_TREADY;
  assign S_AXIS_LEFT_MATCH_tready = S_AXIS_B_0_4_TREADY;
  assign S_AXIS_LEFT_TA_tready = S_AXIS_A_0_3_TREADY;
  assign S_AXIS_LEFT_TB_tready = S_AXIS_B_0_3_TREADY;
  assign S_AXIS_ONE_CONSTANT_1_TDATA = S_AXIS_ONE_CONSTANT_tdata[31:0];
  assign S_AXIS_ONE_CONSTANT_1_TVALID = S_AXIS_ONE_CONSTANT_tvalid;
  assign S_AXIS_ONE_CONSTANT_tready = S_AXIS_ONE_CONSTANT_1_TREADY;
  assign S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready = S_AXIS_0_1_TREADY;
  assign S_AXIS_PRIOR_tready = S_AXIS_0_3_TREADY;
  assign S_AXIS_TOP_DELETION_BIS_tready = S_AXIS_B_0_7_TREADY;
  assign S_AXIS_TOP_DELETION_tready = S_AXIS_B_0_1_TREADY;
  assign S_AXIS_TOP_INSERTION_tready = S_AXIS_A_0_1_TREADY;
  assign S_AXIS_TOP_MATCH_BIS_tready = S_AXIS_B_0_6_TREADY;
  assign S_AXIS_TOP_MATCH_tready = S_AXIS_0_2_TREADY;
  assign aclk_0_1 = aclk;
  assign add_2_M_AXIS_RESULT_TREADY = M_AXIS_RESULT_INSERTION_tready;
  assign add_3_M_AXIS_RESULT_TREADY = M_AXIS_RESULT_DELETION_tready;
  assign aresetn_1 = aresetn;
  assign axis_data_fifo_3_M_AXIS1_TREADY = M_AXIS_ID_tready;
  assign mul_0_M_AXIS_RESULT_TREADY = M_AXIS_RESULT_TA_tready;
  assign mul_1_M_AXIS_RESULT_TREADY = M_AXIS_RESULT_TB_tready;
  assign mul_2_M_AXIS_RESULT_TREADY = M_AXIS_RESULT_MATCH_tready;
  compute_unit_add_0_0 add_0
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(add_0_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(add_0_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(add_0_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_1_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_1_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_1_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_1_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_1_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_1_TVALID));
  compute_unit_add_1_0 add_1
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(add_1_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(add_1_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(add_1_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_3_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_3_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_3_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_3_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_3_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_3_TVALID));
  compute_unit_add_2_0 add_2
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(add_2_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(add_2_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(add_2_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(mul_3_M_AXIS_RESULT_TDATA),
        .s_axis_a_tready(mul_3_M_AXIS_RESULT_TREADY),
        .s_axis_a_tvalid(mul_3_M_AXIS_RESULT_TVALID),
        .s_axis_b_tdata(mul_4_M_AXIS_RESULT_TDATA),
        .s_axis_b_tready(mul_4_M_AXIS_RESULT_TREADY),
        .s_axis_b_tvalid(mul_4_M_AXIS_RESULT_TVALID));
  compute_unit_add_3_0 add_3
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(add_3_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(add_3_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(add_3_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(mul_5_M_AXIS_RESULT_TDATA),
        .s_axis_a_tready(mul_5_M_AXIS_RESULT_TREADY),
        .s_axis_a_tvalid(mul_5_M_AXIS_RESULT_TVALID),
        .s_axis_b_tdata(mul_6_M_AXIS_RESULT_TDATA),
        .s_axis_b_tready(mul_6_M_AXIS_RESULT_TREADY),
        .s_axis_b_tvalid(mul_6_M_AXIS_RESULT_TVALID));
  compute_unit_add_4_0 add_4
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(add_4_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(add_4_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(add_4_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_8_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_8_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_8_TVALID),
        .s_axis_b_tdata(S_AXIS_D_QUAL_RIGHT_1_TDATA),
        .s_axis_b_tready(S_AXIS_D_QUAL_RIGHT_1_TREADY),
        .s_axis_b_tvalid(S_AXIS_D_QUAL_RIGHT_1_TVALID));
  compute_unit_axis_data_fifo_0_0 axis_data_fifo_0
       (.m_axis_tdata(axis_data_fifo_0_M_AXIS_TDATA),
        .m_axis_tready(axis_data_fifo_0_M_AXIS_TREADY),
        .m_axis_tvalid(axis_data_fifo_0_M_AXIS_TVALID),
        .s_axis_aclk(aclk_0_1),
        .s_axis_aresetn(aresetn_1),
        .s_axis_tdata(S_AXIS_0_1_TDATA),
        .s_axis_tready(S_AXIS_0_1_TREADY),
        .s_axis_tvalid(S_AXIS_0_1_TVALID));
  compute_unit_axis_data_fifo_1_0 axis_data_fifo_1
       (.m_axis_tdata(axis_data_fifo_1_M_AXIS_TDATA),
        .m_axis_tready(axis_data_fifo_1_M_AXIS_TREADY),
        .m_axis_tvalid(axis_data_fifo_1_M_AXIS_TVALID),
        .s_axis_aclk(aclk_0_1),
        .s_axis_aresetn(aresetn_1),
        .s_axis_tdata(S_AXIS_0_2_TDATA),
        .s_axis_tready(S_AXIS_0_2_TREADY),
        .s_axis_tvalid(S_AXIS_0_2_TVALID));
  compute_unit_axis_data_fifo_2_0 axis_data_fifo_2
       (.m_axis_tdata(axis_data_fifo_3_M_AXIS_TDATA),
        .m_axis_tready(axis_data_fifo_3_M_AXIS_TREADY),
        .m_axis_tvalid(axis_data_fifo_3_M_AXIS_TVALID),
        .s_axis_aclk(aclk_0_1),
        .s_axis_aresetn(aresetn_1),
        .s_axis_tdata(S_AXIS_0_3_TDATA),
        .s_axis_tready(S_AXIS_0_3_TREADY),
        .s_axis_tvalid(S_AXIS_0_3_TVALID));
  compute_unit_axis_data_fifo_3_0 axis_data_fifo_3
       (.m_axis_tdata(axis_data_fifo_3_M_AXIS1_TDATA),
        .m_axis_tready(axis_data_fifo_3_M_AXIS1_TREADY),
        .m_axis_tvalid(axis_data_fifo_3_M_AXIS1_TVALID),
        .s_axis_aclk(aclk_0_1),
        .s_axis_aresetn(aresetn_1),
        .s_axis_tdata(S_AXIS_0_4_TDATA),
        .s_axis_tready(S_AXIS_0_4_TREADY),
        .s_axis_tvalid(S_AXIS_0_4_TVALID));
  compute_unit_mul_0_0 mul_0
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_0_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_0_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_0_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(add_0_M_AXIS_RESULT_TDATA),
        .s_axis_a_tready(add_0_M_AXIS_RESULT_TREADY),
        .s_axis_a_tvalid(add_0_M_AXIS_RESULT_TVALID),
        .s_axis_b_tdata(axis_data_fifo_0_M_AXIS_TDATA),
        .s_axis_b_tready(axis_data_fifo_0_M_AXIS_TREADY),
        .s_axis_b_tvalid(axis_data_fifo_0_M_AXIS_TVALID));
  compute_unit_mul_1_0 mul_1
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_1_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_1_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_1_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(axis_data_fifo_1_M_AXIS_TDATA),
        .s_axis_a_tready(axis_data_fifo_1_M_AXIS_TREADY),
        .s_axis_a_tvalid(axis_data_fifo_1_M_AXIS_TVALID),
        .s_axis_b_tdata(floating_point_0_M_AXIS_RESULT_TDATA),
        .s_axis_b_tready(floating_point_0_M_AXIS_RESULT_TREADY),
        .s_axis_b_tvalid(floating_point_0_M_AXIS_RESULT_TVALID));
  compute_unit_mul_2_0 mul_2
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_2_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_2_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_2_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(add_1_M_AXIS_RESULT_TDATA),
        .s_axis_a_tready(add_1_M_AXIS_RESULT_TREADY),
        .s_axis_a_tvalid(add_1_M_AXIS_RESULT_TVALID),
        .s_axis_b_tdata(axis_data_fifo_3_M_AXIS_TDATA),
        .s_axis_b_tready(axis_data_fifo_3_M_AXIS_TREADY),
        .s_axis_b_tvalid(axis_data_fifo_3_M_AXIS_TVALID));
  compute_unit_mul_3_0 mul_3
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_3_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_3_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_3_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_4_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_4_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_4_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_4_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_4_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_4_TVALID));
  compute_unit_mul_4_0 mul_4
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_4_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_4_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_4_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_5_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_5_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_5_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_5_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_5_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_5_TVALID));
  compute_unit_mul_5_0 mul_5
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_5_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_5_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_5_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_6_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_6_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_6_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_6_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_6_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_6_TVALID));
  compute_unit_mul_6_0 mul_6
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(mul_6_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(mul_6_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(mul_6_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_A_0_7_TDATA),
        .s_axis_a_tready(S_AXIS_A_0_7_TREADY),
        .s_axis_a_tvalid(S_AXIS_A_0_7_TVALID),
        .s_axis_b_tdata(S_AXIS_B_0_7_TDATA),
        .s_axis_b_tready(S_AXIS_B_0_7_TREADY),
        .s_axis_b_tvalid(S_AXIS_B_0_7_TVALID));
  compute_unit_sub_0_0 sub_0
       (.aclk(aclk_0_1),
        .aresetn(aresetn_1),
        .m_axis_result_tdata(floating_point_0_M_AXIS_RESULT_TDATA),
        .m_axis_result_tready(floating_point_0_M_AXIS_RESULT_TREADY),
        .m_axis_result_tvalid(floating_point_0_M_AXIS_RESULT_TVALID),
        .s_axis_a_tdata(S_AXIS_ONE_CONSTANT_1_TDATA),
        .s_axis_a_tready(S_AXIS_ONE_CONSTANT_1_TREADY),
        .s_axis_a_tvalid(S_AXIS_ONE_CONSTANT_1_TVALID),
        .s_axis_b_tdata(add_4_M_AXIS_RESULT_TDATA),
        .s_axis_b_tready(add_4_M_AXIS_RESULT_TREADY),
        .s_axis_b_tvalid(add_4_M_AXIS_RESULT_TVALID));
endmodule
