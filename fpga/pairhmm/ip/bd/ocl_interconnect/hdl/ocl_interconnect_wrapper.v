//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Mon Jul  1 15:21:36 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target ocl_interconnect_wrapper.bd
//Design      : ocl_interconnect_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ocl_interconnect_wrapper
   (ACLK,
    ARESETN,
    M00_AXI_LITE_araddr,
    M00_AXI_LITE_arprot,
    M00_AXI_LITE_arready,
    M00_AXI_LITE_arvalid,
    M00_AXI_LITE_awaddr,
    M00_AXI_LITE_awprot,
    M00_AXI_LITE_awready,
    M00_AXI_LITE_awvalid,
    M00_AXI_LITE_bready,
    M00_AXI_LITE_bresp,
    M00_AXI_LITE_bvalid,
    M00_AXI_LITE_rdata,
    M00_AXI_LITE_rready,
    M00_AXI_LITE_rresp,
    M00_AXI_LITE_rvalid,
    M00_AXI_LITE_wdata,
    M00_AXI_LITE_wready,
    M00_AXI_LITE_wstrb,
    M00_AXI_LITE_wvalid,
    M01_AXI_LITE_araddr,
    M01_AXI_LITE_arprot,
    M01_AXI_LITE_arready,
    M01_AXI_LITE_arvalid,
    M01_AXI_LITE_awaddr,
    M01_AXI_LITE_awprot,
    M01_AXI_LITE_awready,
    M01_AXI_LITE_awvalid,
    M01_AXI_LITE_bready,
    M01_AXI_LITE_bresp,
    M01_AXI_LITE_bvalid,
    M01_AXI_LITE_rdata,
    M01_AXI_LITE_rready,
    M01_AXI_LITE_rresp,
    M01_AXI_LITE_rvalid,
    M01_AXI_LITE_wdata,
    M01_AXI_LITE_wready,
    M01_AXI_LITE_wstrb,
    M01_AXI_LITE_wvalid,
    M02_AXI_LITE_araddr,
    M02_AXI_LITE_arprot,
    M02_AXI_LITE_arready,
    M02_AXI_LITE_arvalid,
    M02_AXI_LITE_awaddr,
    M02_AXI_LITE_awprot,
    M02_AXI_LITE_awready,
    M02_AXI_LITE_awvalid,
    M02_AXI_LITE_bready,
    M02_AXI_LITE_bresp,
    M02_AXI_LITE_bvalid,
    M02_AXI_LITE_rdata,
    M02_AXI_LITE_rready,
    M02_AXI_LITE_rresp,
    M02_AXI_LITE_rvalid,
    M02_AXI_LITE_wdata,
    M02_AXI_LITE_wready,
    M02_AXI_LITE_wstrb,
    M02_AXI_LITE_wvalid,
    M03_AXI_LITE_araddr,
    M03_AXI_LITE_arprot,
    M03_AXI_LITE_arready,
    M03_AXI_LITE_arvalid,
    M03_AXI_LITE_awaddr,
    M03_AXI_LITE_awprot,
    M03_AXI_LITE_awready,
    M03_AXI_LITE_awvalid,
    M03_AXI_LITE_bready,
    M03_AXI_LITE_bresp,
    M03_AXI_LITE_bvalid,
    M03_AXI_LITE_rdata,
    M03_AXI_LITE_rready,
    M03_AXI_LITE_rresp,
    M03_AXI_LITE_rvalid,
    M03_AXI_LITE_wdata,
    M03_AXI_LITE_wready,
    M03_AXI_LITE_wstrb,
    M03_AXI_LITE_wvalid,
    S00_AXI_LITE_araddr,
    S00_AXI_LITE_arprot,
    S00_AXI_LITE_arready,
    S00_AXI_LITE_arvalid,
    S00_AXI_LITE_awaddr,
    S00_AXI_LITE_awprot,
    S00_AXI_LITE_awready,
    S00_AXI_LITE_awvalid,
    S00_AXI_LITE_bready,
    S00_AXI_LITE_bresp,
    S00_AXI_LITE_bvalid,
    S00_AXI_LITE_rdata,
    S00_AXI_LITE_rready,
    S00_AXI_LITE_rresp,
    S00_AXI_LITE_rvalid,
    S00_AXI_LITE_wdata,
    S00_AXI_LITE_wready,
    S00_AXI_LITE_wstrb,
    S00_AXI_LITE_wvalid);
  input ACLK;
  input ARESETN;
  output [31:0]M00_AXI_LITE_araddr;
  output [2:0]M00_AXI_LITE_arprot;
  input M00_AXI_LITE_arready;
  output M00_AXI_LITE_arvalid;
  output [31:0]M00_AXI_LITE_awaddr;
  output [2:0]M00_AXI_LITE_awprot;
  input M00_AXI_LITE_awready;
  output M00_AXI_LITE_awvalid;
  output M00_AXI_LITE_bready;
  input [1:0]M00_AXI_LITE_bresp;
  input M00_AXI_LITE_bvalid;
  input [31:0]M00_AXI_LITE_rdata;
  output M00_AXI_LITE_rready;
  input [1:0]M00_AXI_LITE_rresp;
  input M00_AXI_LITE_rvalid;
  output [31:0]M00_AXI_LITE_wdata;
  input M00_AXI_LITE_wready;
  output [3:0]M00_AXI_LITE_wstrb;
  output M00_AXI_LITE_wvalid;
  output [31:0]M01_AXI_LITE_araddr;
  output [2:0]M01_AXI_LITE_arprot;
  input M01_AXI_LITE_arready;
  output M01_AXI_LITE_arvalid;
  output [31:0]M01_AXI_LITE_awaddr;
  output [2:0]M01_AXI_LITE_awprot;
  input M01_AXI_LITE_awready;
  output M01_AXI_LITE_awvalid;
  output M01_AXI_LITE_bready;
  input [1:0]M01_AXI_LITE_bresp;
  input M01_AXI_LITE_bvalid;
  input [31:0]M01_AXI_LITE_rdata;
  output M01_AXI_LITE_rready;
  input [1:0]M01_AXI_LITE_rresp;
  input M01_AXI_LITE_rvalid;
  output [31:0]M01_AXI_LITE_wdata;
  input M01_AXI_LITE_wready;
  output [3:0]M01_AXI_LITE_wstrb;
  output M01_AXI_LITE_wvalid;
  output [31:0]M02_AXI_LITE_araddr;
  output [2:0]M02_AXI_LITE_arprot;
  input M02_AXI_LITE_arready;
  output M02_AXI_LITE_arvalid;
  output [31:0]M02_AXI_LITE_awaddr;
  output [2:0]M02_AXI_LITE_awprot;
  input M02_AXI_LITE_awready;
  output M02_AXI_LITE_awvalid;
  output M02_AXI_LITE_bready;
  input [1:0]M02_AXI_LITE_bresp;
  input M02_AXI_LITE_bvalid;
  input [31:0]M02_AXI_LITE_rdata;
  output M02_AXI_LITE_rready;
  input [1:0]M02_AXI_LITE_rresp;
  input M02_AXI_LITE_rvalid;
  output [31:0]M02_AXI_LITE_wdata;
  input M02_AXI_LITE_wready;
  output [3:0]M02_AXI_LITE_wstrb;
  output M02_AXI_LITE_wvalid;
  output [31:0]M03_AXI_LITE_araddr;
  output [2:0]M03_AXI_LITE_arprot;
  input M03_AXI_LITE_arready;
  output M03_AXI_LITE_arvalid;
  output [31:0]M03_AXI_LITE_awaddr;
  output [2:0]M03_AXI_LITE_awprot;
  input M03_AXI_LITE_awready;
  output M03_AXI_LITE_awvalid;
  output M03_AXI_LITE_bready;
  input [1:0]M03_AXI_LITE_bresp;
  input M03_AXI_LITE_bvalid;
  input [31:0]M03_AXI_LITE_rdata;
  output M03_AXI_LITE_rready;
  input [1:0]M03_AXI_LITE_rresp;
  input M03_AXI_LITE_rvalid;
  output [31:0]M03_AXI_LITE_wdata;
  input M03_AXI_LITE_wready;
  output [3:0]M03_AXI_LITE_wstrb;
  output M03_AXI_LITE_wvalid;
  input [31:0]S00_AXI_LITE_araddr;
  input [2:0]S00_AXI_LITE_arprot;
  output S00_AXI_LITE_arready;
  input S00_AXI_LITE_arvalid;
  input [31:0]S00_AXI_LITE_awaddr;
  input [2:0]S00_AXI_LITE_awprot;
  output S00_AXI_LITE_awready;
  input S00_AXI_LITE_awvalid;
  input S00_AXI_LITE_bready;
  output [1:0]S00_AXI_LITE_bresp;
  output S00_AXI_LITE_bvalid;
  output [31:0]S00_AXI_LITE_rdata;
  input S00_AXI_LITE_rready;
  output [1:0]S00_AXI_LITE_rresp;
  output S00_AXI_LITE_rvalid;
  input [31:0]S00_AXI_LITE_wdata;
  output S00_AXI_LITE_wready;
  input [3:0]S00_AXI_LITE_wstrb;
  input S00_AXI_LITE_wvalid;

  wire ACLK;
  wire ARESETN;
  wire [31:0]M00_AXI_LITE_araddr;
  wire [2:0]M00_AXI_LITE_arprot;
  wire M00_AXI_LITE_arready;
  wire M00_AXI_LITE_arvalid;
  wire [31:0]M00_AXI_LITE_awaddr;
  wire [2:0]M00_AXI_LITE_awprot;
  wire M00_AXI_LITE_awready;
  wire M00_AXI_LITE_awvalid;
  wire M00_AXI_LITE_bready;
  wire [1:0]M00_AXI_LITE_bresp;
  wire M00_AXI_LITE_bvalid;
  wire [31:0]M00_AXI_LITE_rdata;
  wire M00_AXI_LITE_rready;
  wire [1:0]M00_AXI_LITE_rresp;
  wire M00_AXI_LITE_rvalid;
  wire [31:0]M00_AXI_LITE_wdata;
  wire M00_AXI_LITE_wready;
  wire [3:0]M00_AXI_LITE_wstrb;
  wire M00_AXI_LITE_wvalid;
  wire [31:0]M01_AXI_LITE_araddr;
  wire [2:0]M01_AXI_LITE_arprot;
  wire M01_AXI_LITE_arready;
  wire M01_AXI_LITE_arvalid;
  wire [31:0]M01_AXI_LITE_awaddr;
  wire [2:0]M01_AXI_LITE_awprot;
  wire M01_AXI_LITE_awready;
  wire M01_AXI_LITE_awvalid;
  wire M01_AXI_LITE_bready;
  wire [1:0]M01_AXI_LITE_bresp;
  wire M01_AXI_LITE_bvalid;
  wire [31:0]M01_AXI_LITE_rdata;
  wire M01_AXI_LITE_rready;
  wire [1:0]M01_AXI_LITE_rresp;
  wire M01_AXI_LITE_rvalid;
  wire [31:0]M01_AXI_LITE_wdata;
  wire M01_AXI_LITE_wready;
  wire [3:0]M01_AXI_LITE_wstrb;
  wire M01_AXI_LITE_wvalid;
  wire [31:0]M02_AXI_LITE_araddr;
  wire [2:0]M02_AXI_LITE_arprot;
  wire M02_AXI_LITE_arready;
  wire M02_AXI_LITE_arvalid;
  wire [31:0]M02_AXI_LITE_awaddr;
  wire [2:0]M02_AXI_LITE_awprot;
  wire M02_AXI_LITE_awready;
  wire M02_AXI_LITE_awvalid;
  wire M02_AXI_LITE_bready;
  wire [1:0]M02_AXI_LITE_bresp;
  wire M02_AXI_LITE_bvalid;
  wire [31:0]M02_AXI_LITE_rdata;
  wire M02_AXI_LITE_rready;
  wire [1:0]M02_AXI_LITE_rresp;
  wire M02_AXI_LITE_rvalid;
  wire [31:0]M02_AXI_LITE_wdata;
  wire M02_AXI_LITE_wready;
  wire [3:0]M02_AXI_LITE_wstrb;
  wire M02_AXI_LITE_wvalid;
  wire [31:0]M03_AXI_LITE_araddr;
  wire [2:0]M03_AXI_LITE_arprot;
  wire M03_AXI_LITE_arready;
  wire M03_AXI_LITE_arvalid;
  wire [31:0]M03_AXI_LITE_awaddr;
  wire [2:0]M03_AXI_LITE_awprot;
  wire M03_AXI_LITE_awready;
  wire M03_AXI_LITE_awvalid;
  wire M03_AXI_LITE_bready;
  wire [1:0]M03_AXI_LITE_bresp;
  wire M03_AXI_LITE_bvalid;
  wire [31:0]M03_AXI_LITE_rdata;
  wire M03_AXI_LITE_rready;
  wire [1:0]M03_AXI_LITE_rresp;
  wire M03_AXI_LITE_rvalid;
  wire [31:0]M03_AXI_LITE_wdata;
  wire M03_AXI_LITE_wready;
  wire [3:0]M03_AXI_LITE_wstrb;
  wire M03_AXI_LITE_wvalid;
  wire [31:0]S00_AXI_LITE_araddr;
  wire [2:0]S00_AXI_LITE_arprot;
  wire S00_AXI_LITE_arready;
  wire S00_AXI_LITE_arvalid;
  wire [31:0]S00_AXI_LITE_awaddr;
  wire [2:0]S00_AXI_LITE_awprot;
  wire S00_AXI_LITE_awready;
  wire S00_AXI_LITE_awvalid;
  wire S00_AXI_LITE_bready;
  wire [1:0]S00_AXI_LITE_bresp;
  wire S00_AXI_LITE_bvalid;
  wire [31:0]S00_AXI_LITE_rdata;
  wire S00_AXI_LITE_rready;
  wire [1:0]S00_AXI_LITE_rresp;
  wire S00_AXI_LITE_rvalid;
  wire [31:0]S00_AXI_LITE_wdata;
  wire S00_AXI_LITE_wready;
  wire [3:0]S00_AXI_LITE_wstrb;
  wire S00_AXI_LITE_wvalid;

  ocl_interconnect ocl_interconnect_i
       (.ACLK(ACLK),
        .ARESETN(ARESETN),
        .M00_AXI_LITE_araddr(M00_AXI_LITE_araddr),
        .M00_AXI_LITE_arprot(M00_AXI_LITE_arprot),
        .M00_AXI_LITE_arready(M00_AXI_LITE_arready),
        .M00_AXI_LITE_arvalid(M00_AXI_LITE_arvalid),
        .M00_AXI_LITE_awaddr(M00_AXI_LITE_awaddr),
        .M00_AXI_LITE_awprot(M00_AXI_LITE_awprot),
        .M00_AXI_LITE_awready(M00_AXI_LITE_awready),
        .M00_AXI_LITE_awvalid(M00_AXI_LITE_awvalid),
        .M00_AXI_LITE_bready(M00_AXI_LITE_bready),
        .M00_AXI_LITE_bresp(M00_AXI_LITE_bresp),
        .M00_AXI_LITE_bvalid(M00_AXI_LITE_bvalid),
        .M00_AXI_LITE_rdata(M00_AXI_LITE_rdata),
        .M00_AXI_LITE_rready(M00_AXI_LITE_rready),
        .M00_AXI_LITE_rresp(M00_AXI_LITE_rresp),
        .M00_AXI_LITE_rvalid(M00_AXI_LITE_rvalid),
        .M00_AXI_LITE_wdata(M00_AXI_LITE_wdata),
        .M00_AXI_LITE_wready(M00_AXI_LITE_wready),
        .M00_AXI_LITE_wstrb(M00_AXI_LITE_wstrb),
        .M00_AXI_LITE_wvalid(M00_AXI_LITE_wvalid),
        .M01_AXI_LITE_araddr(M01_AXI_LITE_araddr),
        .M01_AXI_LITE_arprot(M01_AXI_LITE_arprot),
        .M01_AXI_LITE_arready(M01_AXI_LITE_arready),
        .M01_AXI_LITE_arvalid(M01_AXI_LITE_arvalid),
        .M01_AXI_LITE_awaddr(M01_AXI_LITE_awaddr),
        .M01_AXI_LITE_awprot(M01_AXI_LITE_awprot),
        .M01_AXI_LITE_awready(M01_AXI_LITE_awready),
        .M01_AXI_LITE_awvalid(M01_AXI_LITE_awvalid),
        .M01_AXI_LITE_bready(M01_AXI_LITE_bready),
        .M01_AXI_LITE_bresp(M01_AXI_LITE_bresp),
        .M01_AXI_LITE_bvalid(M01_AXI_LITE_bvalid),
        .M01_AXI_LITE_rdata(M01_AXI_LITE_rdata),
        .M01_AXI_LITE_rready(M01_AXI_LITE_rready),
        .M01_AXI_LITE_rresp(M01_AXI_LITE_rresp),
        .M01_AXI_LITE_rvalid(M01_AXI_LITE_rvalid),
        .M01_AXI_LITE_wdata(M01_AXI_LITE_wdata),
        .M01_AXI_LITE_wready(M01_AXI_LITE_wready),
        .M01_AXI_LITE_wstrb(M01_AXI_LITE_wstrb),
        .M01_AXI_LITE_wvalid(M01_AXI_LITE_wvalid),
        .M02_AXI_LITE_araddr(M02_AXI_LITE_araddr),
        .M02_AXI_LITE_arprot(M02_AXI_LITE_arprot),
        .M02_AXI_LITE_arready(M02_AXI_LITE_arready),
        .M02_AXI_LITE_arvalid(M02_AXI_LITE_arvalid),
        .M02_AXI_LITE_awaddr(M02_AXI_LITE_awaddr),
        .M02_AXI_LITE_awprot(M02_AXI_LITE_awprot),
        .M02_AXI_LITE_awready(M02_AXI_LITE_awready),
        .M02_AXI_LITE_awvalid(M02_AXI_LITE_awvalid),
        .M02_AXI_LITE_bready(M02_AXI_LITE_bready),
        .M02_AXI_LITE_bresp(M02_AXI_LITE_bresp),
        .M02_AXI_LITE_bvalid(M02_AXI_LITE_bvalid),
        .M02_AXI_LITE_rdata(M02_AXI_LITE_rdata),
        .M02_AXI_LITE_rready(M02_AXI_LITE_rready),
        .M02_AXI_LITE_rresp(M02_AXI_LITE_rresp),
        .M02_AXI_LITE_rvalid(M02_AXI_LITE_rvalid),
        .M02_AXI_LITE_wdata(M02_AXI_LITE_wdata),
        .M02_AXI_LITE_wready(M02_AXI_LITE_wready),
        .M02_AXI_LITE_wstrb(M02_AXI_LITE_wstrb),
        .M02_AXI_LITE_wvalid(M02_AXI_LITE_wvalid),
        .M03_AXI_LITE_araddr(M03_AXI_LITE_araddr),
        .M03_AXI_LITE_arprot(M03_AXI_LITE_arprot),
        .M03_AXI_LITE_arready(M03_AXI_LITE_arready),
        .M03_AXI_LITE_arvalid(M03_AXI_LITE_arvalid),
        .M03_AXI_LITE_awaddr(M03_AXI_LITE_awaddr),
        .M03_AXI_LITE_awprot(M03_AXI_LITE_awprot),
        .M03_AXI_LITE_awready(M03_AXI_LITE_awready),
        .M03_AXI_LITE_awvalid(M03_AXI_LITE_awvalid),
        .M03_AXI_LITE_bready(M03_AXI_LITE_bready),
        .M03_AXI_LITE_bresp(M03_AXI_LITE_bresp),
        .M03_AXI_LITE_bvalid(M03_AXI_LITE_bvalid),
        .M03_AXI_LITE_rdata(M03_AXI_LITE_rdata),
        .M03_AXI_LITE_rready(M03_AXI_LITE_rready),
        .M03_AXI_LITE_rresp(M03_AXI_LITE_rresp),
        .M03_AXI_LITE_rvalid(M03_AXI_LITE_rvalid),
        .M03_AXI_LITE_wdata(M03_AXI_LITE_wdata),
        .M03_AXI_LITE_wready(M03_AXI_LITE_wready),
        .M03_AXI_LITE_wstrb(M03_AXI_LITE_wstrb),
        .M03_AXI_LITE_wvalid(M03_AXI_LITE_wvalid),
        .S00_AXI_LITE_araddr(S00_AXI_LITE_araddr),
        .S00_AXI_LITE_arprot(S00_AXI_LITE_arprot),
        .S00_AXI_LITE_arready(S00_AXI_LITE_arready),
        .S00_AXI_LITE_arvalid(S00_AXI_LITE_arvalid),
        .S00_AXI_LITE_awaddr(S00_AXI_LITE_awaddr),
        .S00_AXI_LITE_awprot(S00_AXI_LITE_awprot),
        .S00_AXI_LITE_awready(S00_AXI_LITE_awready),
        .S00_AXI_LITE_awvalid(S00_AXI_LITE_awvalid),
        .S00_AXI_LITE_bready(S00_AXI_LITE_bready),
        .S00_AXI_LITE_bresp(S00_AXI_LITE_bresp),
        .S00_AXI_LITE_bvalid(S00_AXI_LITE_bvalid),
        .S00_AXI_LITE_rdata(S00_AXI_LITE_rdata),
        .S00_AXI_LITE_rready(S00_AXI_LITE_rready),
        .S00_AXI_LITE_rresp(S00_AXI_LITE_rresp),
        .S00_AXI_LITE_rvalid(S00_AXI_LITE_rvalid),
        .S00_AXI_LITE_wdata(S00_AXI_LITE_wdata),
        .S00_AXI_LITE_wready(S00_AXI_LITE_wready),
        .S00_AXI_LITE_wstrb(S00_AXI_LITE_wstrb),
        .S00_AXI_LITE_wvalid(S00_AXI_LITE_wvalid));
endmodule
