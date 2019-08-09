//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
//Date        : Tue May  7 15:41:52 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target compute_unit_wrapper.bd
//Design      : compute_unit_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module compute_unit_wrapper
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
  output [31:0]M_AXIS_ID_tdata;
  input M_AXIS_ID_tready;
  output M_AXIS_ID_tvalid;
  output [31:0]M_AXIS_RESULT_DELETION_tdata;
  input M_AXIS_RESULT_DELETION_tready;
  output M_AXIS_RESULT_DELETION_tvalid;
  output [31:0]M_AXIS_RESULT_INSERTION_tdata;
  input M_AXIS_RESULT_INSERTION_tready;
  output M_AXIS_RESULT_INSERTION_tvalid;
  output [31:0]M_AXIS_RESULT_MATCH_tdata;
  input M_AXIS_RESULT_MATCH_tready;
  output M_AXIS_RESULT_MATCH_tvalid;
  output [31:0]M_AXIS_RESULT_TA_tdata;
  input M_AXIS_RESULT_TA_tready;
  output M_AXIS_RESULT_TA_tvalid;
  output [31:0]M_AXIS_RESULT_TB_tdata;
  input M_AXIS_RESULT_TB_tready;
  output M_AXIS_RESULT_TB_tvalid;
  input [31:0]S_AXIS_C_QUAL_BIS_tdata;
  output S_AXIS_C_QUAL_BIS_tready;
  input S_AXIS_C_QUAL_BIS_tvalid;
  input [31:0]S_AXIS_C_QUAL_tdata;
  output S_AXIS_C_QUAL_tready;
  input S_AXIS_C_QUAL_tvalid;
  input [31:0]S_AXIS_D_QUAL_RIGHT_tdata;
  output S_AXIS_D_QUAL_RIGHT_tready;
  input S_AXIS_D_QUAL_RIGHT_tvalid;
  input [31:0]S_AXIS_D_QUAL_tdata;
  output S_AXIS_D_QUAL_tready;
  input S_AXIS_D_QUAL_tvalid;
  input [31:0]S_AXIS_ID_tdata;
  output S_AXIS_ID_tready;
  input S_AXIS_ID_tvalid;
  input [31:0]S_AXIS_I_QUAL_RIGHT_tdata;
  output S_AXIS_I_QUAL_RIGHT_tready;
  input S_AXIS_I_QUAL_RIGHT_tvalid;
  input [31:0]S_AXIS_I_QUAL_tdata;
  output S_AXIS_I_QUAL_tready;
  input S_AXIS_I_QUAL_tvalid;
  input [31:0]S_AXIS_LEFT_INSERTION_tdata;
  output S_AXIS_LEFT_INSERTION_tready;
  input S_AXIS_LEFT_INSERTION_tvalid;
  input [31:0]S_AXIS_LEFT_MATCH_tdata;
  output S_AXIS_LEFT_MATCH_tready;
  input S_AXIS_LEFT_MATCH_tvalid;
  input [31:0]S_AXIS_LEFT_TA_tdata;
  output S_AXIS_LEFT_TA_tready;
  input S_AXIS_LEFT_TA_tvalid;
  input [31:0]S_AXIS_LEFT_TB_tdata;
  output S_AXIS_LEFT_TB_tready;
  input S_AXIS_LEFT_TB_tvalid;
  input [31:0]S_AXIS_ONE_CONSTANT_tdata;
  output S_AXIS_ONE_CONSTANT_tready;
  input S_AXIS_ONE_CONSTANT_tvalid;
  input [31:0]S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata;
  output S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready;
  input S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid;
  input [31:0]S_AXIS_PRIOR_tdata;
  output S_AXIS_PRIOR_tready;
  input S_AXIS_PRIOR_tvalid;
  input [31:0]S_AXIS_TOP_DELETION_BIS_tdata;
  output S_AXIS_TOP_DELETION_BIS_tready;
  input S_AXIS_TOP_DELETION_BIS_tvalid;
  input [31:0]S_AXIS_TOP_DELETION_tdata;
  output S_AXIS_TOP_DELETION_tready;
  input S_AXIS_TOP_DELETION_tvalid;
  input [31:0]S_AXIS_TOP_INSERTION_tdata;
  output S_AXIS_TOP_INSERTION_tready;
  input S_AXIS_TOP_INSERTION_tvalid;
  input [31:0]S_AXIS_TOP_MATCH_BIS_tdata;
  output S_AXIS_TOP_MATCH_BIS_tready;
  input S_AXIS_TOP_MATCH_BIS_tvalid;
  input [31:0]S_AXIS_TOP_MATCH_tdata;
  output S_AXIS_TOP_MATCH_tready;
  input S_AXIS_TOP_MATCH_tvalid;
  input aclk;
  input aresetn;

  wire [31:0]M_AXIS_ID_tdata;
  wire M_AXIS_ID_tready;
  wire M_AXIS_ID_tvalid;
  wire [31:0]M_AXIS_RESULT_DELETION_tdata;
  wire M_AXIS_RESULT_DELETION_tready;
  wire M_AXIS_RESULT_DELETION_tvalid;
  wire [31:0]M_AXIS_RESULT_INSERTION_tdata;
  wire M_AXIS_RESULT_INSERTION_tready;
  wire M_AXIS_RESULT_INSERTION_tvalid;
  wire [31:0]M_AXIS_RESULT_MATCH_tdata;
  wire M_AXIS_RESULT_MATCH_tready;
  wire M_AXIS_RESULT_MATCH_tvalid;
  wire [31:0]M_AXIS_RESULT_TA_tdata;
  wire M_AXIS_RESULT_TA_tready;
  wire M_AXIS_RESULT_TA_tvalid;
  wire [31:0]M_AXIS_RESULT_TB_tdata;
  wire M_AXIS_RESULT_TB_tready;
  wire M_AXIS_RESULT_TB_tvalid;
  wire [31:0]S_AXIS_C_QUAL_BIS_tdata;
  wire S_AXIS_C_QUAL_BIS_tready;
  wire S_AXIS_C_QUAL_BIS_tvalid;
  wire [31:0]S_AXIS_C_QUAL_tdata;
  wire S_AXIS_C_QUAL_tready;
  wire S_AXIS_C_QUAL_tvalid;
  wire [31:0]S_AXIS_D_QUAL_RIGHT_tdata;
  wire S_AXIS_D_QUAL_RIGHT_tready;
  wire S_AXIS_D_QUAL_RIGHT_tvalid;
  wire [31:0]S_AXIS_D_QUAL_tdata;
  wire S_AXIS_D_QUAL_tready;
  wire S_AXIS_D_QUAL_tvalid;
  wire [31:0]S_AXIS_ID_tdata;
  wire S_AXIS_ID_tready;
  wire S_AXIS_ID_tvalid;
  wire [31:0]S_AXIS_I_QUAL_RIGHT_tdata;
  wire S_AXIS_I_QUAL_RIGHT_tready;
  wire S_AXIS_I_QUAL_RIGHT_tvalid;
  wire [31:0]S_AXIS_I_QUAL_tdata;
  wire S_AXIS_I_QUAL_tready;
  wire S_AXIS_I_QUAL_tvalid;
  wire [31:0]S_AXIS_LEFT_INSERTION_tdata;
  wire S_AXIS_LEFT_INSERTION_tready;
  wire S_AXIS_LEFT_INSERTION_tvalid;
  wire [31:0]S_AXIS_LEFT_MATCH_tdata;
  wire S_AXIS_LEFT_MATCH_tready;
  wire S_AXIS_LEFT_MATCH_tvalid;
  wire [31:0]S_AXIS_LEFT_TA_tdata;
  wire S_AXIS_LEFT_TA_tready;
  wire S_AXIS_LEFT_TA_tvalid;
  wire [31:0]S_AXIS_LEFT_TB_tdata;
  wire S_AXIS_LEFT_TB_tready;
  wire S_AXIS_LEFT_TB_tvalid;
  wire [31:0]S_AXIS_ONE_CONSTANT_tdata;
  wire S_AXIS_ONE_CONSTANT_tready;
  wire S_AXIS_ONE_CONSTANT_tvalid;
  wire [31:0]S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata;
  wire S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready;
  wire S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid;
  wire [31:0]S_AXIS_PRIOR_tdata;
  wire S_AXIS_PRIOR_tready;
  wire S_AXIS_PRIOR_tvalid;
  wire [31:0]S_AXIS_TOP_DELETION_BIS_tdata;
  wire S_AXIS_TOP_DELETION_BIS_tready;
  wire S_AXIS_TOP_DELETION_BIS_tvalid;
  wire [31:0]S_AXIS_TOP_DELETION_tdata;
  wire S_AXIS_TOP_DELETION_tready;
  wire S_AXIS_TOP_DELETION_tvalid;
  wire [31:0]S_AXIS_TOP_INSERTION_tdata;
  wire S_AXIS_TOP_INSERTION_tready;
  wire S_AXIS_TOP_INSERTION_tvalid;
  wire [31:0]S_AXIS_TOP_MATCH_BIS_tdata;
  wire S_AXIS_TOP_MATCH_BIS_tready;
  wire S_AXIS_TOP_MATCH_BIS_tvalid;
  wire [31:0]S_AXIS_TOP_MATCH_tdata;
  wire S_AXIS_TOP_MATCH_tready;
  wire S_AXIS_TOP_MATCH_tvalid;
  wire aclk;
  wire aresetn;

  compute_unit compute_unit_i
       (.M_AXIS_ID_tdata(M_AXIS_ID_tdata),
        .M_AXIS_ID_tready(M_AXIS_ID_tready),
        .M_AXIS_ID_tvalid(M_AXIS_ID_tvalid),
        .M_AXIS_RESULT_DELETION_tdata(M_AXIS_RESULT_DELETION_tdata),
        .M_AXIS_RESULT_DELETION_tready(M_AXIS_RESULT_DELETION_tready),
        .M_AXIS_RESULT_DELETION_tvalid(M_AXIS_RESULT_DELETION_tvalid),
        .M_AXIS_RESULT_INSERTION_tdata(M_AXIS_RESULT_INSERTION_tdata),
        .M_AXIS_RESULT_INSERTION_tready(M_AXIS_RESULT_INSERTION_tready),
        .M_AXIS_RESULT_INSERTION_tvalid(M_AXIS_RESULT_INSERTION_tvalid),
        .M_AXIS_RESULT_MATCH_tdata(M_AXIS_RESULT_MATCH_tdata),
        .M_AXIS_RESULT_MATCH_tready(M_AXIS_RESULT_MATCH_tready),
        .M_AXIS_RESULT_MATCH_tvalid(M_AXIS_RESULT_MATCH_tvalid),
        .M_AXIS_RESULT_TA_tdata(M_AXIS_RESULT_TA_tdata),
        .M_AXIS_RESULT_TA_tready(M_AXIS_RESULT_TA_tready),
        .M_AXIS_RESULT_TA_tvalid(M_AXIS_RESULT_TA_tvalid),
        .M_AXIS_RESULT_TB_tdata(M_AXIS_RESULT_TB_tdata),
        .M_AXIS_RESULT_TB_tready(M_AXIS_RESULT_TB_tready),
        .M_AXIS_RESULT_TB_tvalid(M_AXIS_RESULT_TB_tvalid),
        .S_AXIS_C_QUAL_BIS_tdata(S_AXIS_C_QUAL_BIS_tdata),
        .S_AXIS_C_QUAL_BIS_tready(S_AXIS_C_QUAL_BIS_tready),
        .S_AXIS_C_QUAL_BIS_tvalid(S_AXIS_C_QUAL_BIS_tvalid),
        .S_AXIS_C_QUAL_tdata(S_AXIS_C_QUAL_tdata),
        .S_AXIS_C_QUAL_tready(S_AXIS_C_QUAL_tready),
        .S_AXIS_C_QUAL_tvalid(S_AXIS_C_QUAL_tvalid),
        .S_AXIS_D_QUAL_RIGHT_tdata(S_AXIS_D_QUAL_RIGHT_tdata),
        .S_AXIS_D_QUAL_RIGHT_tready(S_AXIS_D_QUAL_RIGHT_tready),
        .S_AXIS_D_QUAL_RIGHT_tvalid(S_AXIS_D_QUAL_RIGHT_tvalid),
        .S_AXIS_D_QUAL_tdata(S_AXIS_D_QUAL_tdata),
        .S_AXIS_D_QUAL_tready(S_AXIS_D_QUAL_tready),
        .S_AXIS_D_QUAL_tvalid(S_AXIS_D_QUAL_tvalid),
        .S_AXIS_ID_tdata(S_AXIS_ID_tdata),
        .S_AXIS_ID_tready(S_AXIS_ID_tready),
        .S_AXIS_ID_tvalid(S_AXIS_ID_tvalid),
        .S_AXIS_I_QUAL_RIGHT_tdata(S_AXIS_I_QUAL_RIGHT_tdata),
        .S_AXIS_I_QUAL_RIGHT_tready(S_AXIS_I_QUAL_RIGHT_tready),
        .S_AXIS_I_QUAL_RIGHT_tvalid(S_AXIS_I_QUAL_RIGHT_tvalid),
        .S_AXIS_I_QUAL_tdata(S_AXIS_I_QUAL_tdata),
        .S_AXIS_I_QUAL_tready(S_AXIS_I_QUAL_tready),
        .S_AXIS_I_QUAL_tvalid(S_AXIS_I_QUAL_tvalid),
        .S_AXIS_LEFT_INSERTION_tdata(S_AXIS_LEFT_INSERTION_tdata),
        .S_AXIS_LEFT_INSERTION_tready(S_AXIS_LEFT_INSERTION_tready),
        .S_AXIS_LEFT_INSERTION_tvalid(S_AXIS_LEFT_INSERTION_tvalid),
        .S_AXIS_LEFT_MATCH_tdata(S_AXIS_LEFT_MATCH_tdata),
        .S_AXIS_LEFT_MATCH_tready(S_AXIS_LEFT_MATCH_tready),
        .S_AXIS_LEFT_MATCH_tvalid(S_AXIS_LEFT_MATCH_tvalid),
        .S_AXIS_LEFT_TA_tdata(S_AXIS_LEFT_TA_tdata),
        .S_AXIS_LEFT_TA_tready(S_AXIS_LEFT_TA_tready),
        .S_AXIS_LEFT_TA_tvalid(S_AXIS_LEFT_TA_tvalid),
        .S_AXIS_LEFT_TB_tdata(S_AXIS_LEFT_TB_tdata),
        .S_AXIS_LEFT_TB_tready(S_AXIS_LEFT_TB_tready),
        .S_AXIS_LEFT_TB_tvalid(S_AXIS_LEFT_TB_tvalid),
        .S_AXIS_ONE_CONSTANT_tdata(S_AXIS_ONE_CONSTANT_tdata),
        .S_AXIS_ONE_CONSTANT_tready(S_AXIS_ONE_CONSTANT_tready),
        .S_AXIS_ONE_CONSTANT_tvalid(S_AXIS_ONE_CONSTANT_tvalid),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata(S_AXIS_ONE_MIN_C_QUAL_RIGHT_tdata),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready(S_AXIS_ONE_MIN_C_QUAL_RIGHT_tready),
        .S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid(S_AXIS_ONE_MIN_C_QUAL_RIGHT_tvalid),
        .S_AXIS_PRIOR_tdata(S_AXIS_PRIOR_tdata),
        .S_AXIS_PRIOR_tready(S_AXIS_PRIOR_tready),
        .S_AXIS_PRIOR_tvalid(S_AXIS_PRIOR_tvalid),
        .S_AXIS_TOP_DELETION_BIS_tdata(S_AXIS_TOP_DELETION_BIS_tdata),
        .S_AXIS_TOP_DELETION_BIS_tready(S_AXIS_TOP_DELETION_BIS_tready),
        .S_AXIS_TOP_DELETION_BIS_tvalid(S_AXIS_TOP_DELETION_BIS_tvalid),
        .S_AXIS_TOP_DELETION_tdata(S_AXIS_TOP_DELETION_tdata),
        .S_AXIS_TOP_DELETION_tready(S_AXIS_TOP_DELETION_tready),
        .S_AXIS_TOP_DELETION_tvalid(S_AXIS_TOP_DELETION_tvalid),
        .S_AXIS_TOP_INSERTION_tdata(S_AXIS_TOP_INSERTION_tdata),
        .S_AXIS_TOP_INSERTION_tready(S_AXIS_TOP_INSERTION_tready),
        .S_AXIS_TOP_INSERTION_tvalid(S_AXIS_TOP_INSERTION_tvalid),
        .S_AXIS_TOP_MATCH_BIS_tdata(S_AXIS_TOP_MATCH_BIS_tdata),
        .S_AXIS_TOP_MATCH_BIS_tready(S_AXIS_TOP_MATCH_BIS_tready),
        .S_AXIS_TOP_MATCH_BIS_tvalid(S_AXIS_TOP_MATCH_BIS_tvalid),
        .S_AXIS_TOP_MATCH_tdata(S_AXIS_TOP_MATCH_tdata),
        .S_AXIS_TOP_MATCH_tready(S_AXIS_TOP_MATCH_tready),
        .S_AXIS_TOP_MATCH_tvalid(S_AXIS_TOP_MATCH_tvalid),
        .aclk(aclk),
        .aresetn(aresetn));
endmodule
