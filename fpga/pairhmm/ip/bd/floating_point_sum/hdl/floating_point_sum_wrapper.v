//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
//Date        : Tue May  7 15:39:29 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target floating_point_sum_wrapper.bd
//Design      : floating_point_sum_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module floating_point_sum_wrapper
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
  output [31:0]M_AXIS_SUM_RESULT_tdata;
  input M_AXIS_SUM_RESULT_tready;
  output [7:0]M_AXIS_SUM_RESULT_tuser;
  output M_AXIS_SUM_RESULT_tvalid;
  input [31:0]S_AXIS_A_tdata;
  output S_AXIS_A_tready;
  input [7:0]S_AXIS_A_tuser;
  input S_AXIS_A_tvalid;
  input [31:0]S_AXIS_B_tdata;
  output S_AXIS_B_tready;
  input S_AXIS_B_tvalid;
  input aclk;
  input aresetn;

  wire [31:0]M_AXIS_SUM_RESULT_tdata;
  wire M_AXIS_SUM_RESULT_tready;
  wire [7:0]M_AXIS_SUM_RESULT_tuser;
  wire M_AXIS_SUM_RESULT_tvalid;
  wire [31:0]S_AXIS_A_tdata;
  wire S_AXIS_A_tready;
  wire [7:0]S_AXIS_A_tuser;
  wire S_AXIS_A_tvalid;
  wire [31:0]S_AXIS_B_tdata;
  wire S_AXIS_B_tready;
  wire S_AXIS_B_tvalid;
  wire aclk;
  wire aresetn;

  floating_point_sum floating_point_sum_i
       (.M_AXIS_SUM_RESULT_tdata(M_AXIS_SUM_RESULT_tdata),
        .M_AXIS_SUM_RESULT_tready(M_AXIS_SUM_RESULT_tready),
        .M_AXIS_SUM_RESULT_tuser(M_AXIS_SUM_RESULT_tuser),
        .M_AXIS_SUM_RESULT_tvalid(M_AXIS_SUM_RESULT_tvalid),
        .S_AXIS_A_tdata(S_AXIS_A_tdata),
        .S_AXIS_A_tready(S_AXIS_A_tready),
        .S_AXIS_A_tuser(S_AXIS_A_tuser),
        .S_AXIS_A_tvalid(S_AXIS_A_tvalid),
        .S_AXIS_B_tdata(S_AXIS_B_tdata),
        .S_AXIS_B_tready(S_AXIS_B_tready),
        .S_AXIS_B_tvalid(S_AXIS_B_tvalid),
        .aclk(aclk),
        .aresetn(aresetn));
endmodule
