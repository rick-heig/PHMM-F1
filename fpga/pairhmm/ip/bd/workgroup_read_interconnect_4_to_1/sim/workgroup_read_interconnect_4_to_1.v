//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Wed Jul 10 09:50:03 2019
//Host        : A13PC04 running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target workgroup_read_interconnect_4_to_1.bd
//Design      : workgroup_read_interconnect_4_to_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module m00_couplers_imp_KUCT99
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arregion,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awregion,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [63:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [8:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [3:0]M_AXI_arregion;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [8:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [3:0]M_AXI_awregion;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [8:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [8:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [63:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [8:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [63:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [8:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [8:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [8:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire M_ARESETN_1;
  wire [63:0]m00_couplers_to_m00_regslice_ARADDR;
  wire [1:0]m00_couplers_to_m00_regslice_ARBURST;
  wire [3:0]m00_couplers_to_m00_regslice_ARCACHE;
  wire [8:0]m00_couplers_to_m00_regslice_ARID;
  wire [7:0]m00_couplers_to_m00_regslice_ARLEN;
  wire [0:0]m00_couplers_to_m00_regslice_ARLOCK;
  wire [2:0]m00_couplers_to_m00_regslice_ARPROT;
  wire [3:0]m00_couplers_to_m00_regslice_ARQOS;
  wire m00_couplers_to_m00_regslice_ARREADY;
  wire [3:0]m00_couplers_to_m00_regslice_ARREGION;
  wire [2:0]m00_couplers_to_m00_regslice_ARSIZE;
  wire m00_couplers_to_m00_regslice_ARVALID;
  wire [63:0]m00_couplers_to_m00_regslice_AWADDR;
  wire [1:0]m00_couplers_to_m00_regslice_AWBURST;
  wire [3:0]m00_couplers_to_m00_regslice_AWCACHE;
  wire [8:0]m00_couplers_to_m00_regslice_AWID;
  wire [7:0]m00_couplers_to_m00_regslice_AWLEN;
  wire [0:0]m00_couplers_to_m00_regslice_AWLOCK;
  wire [2:0]m00_couplers_to_m00_regslice_AWPROT;
  wire [3:0]m00_couplers_to_m00_regslice_AWQOS;
  wire m00_couplers_to_m00_regslice_AWREADY;
  wire [3:0]m00_couplers_to_m00_regslice_AWREGION;
  wire [2:0]m00_couplers_to_m00_regslice_AWSIZE;
  wire m00_couplers_to_m00_regslice_AWVALID;
  wire [8:0]m00_couplers_to_m00_regslice_BID;
  wire m00_couplers_to_m00_regslice_BREADY;
  wire [1:0]m00_couplers_to_m00_regslice_BRESP;
  wire m00_couplers_to_m00_regslice_BVALID;
  wire [511:0]m00_couplers_to_m00_regslice_RDATA;
  wire [8:0]m00_couplers_to_m00_regslice_RID;
  wire m00_couplers_to_m00_regslice_RLAST;
  wire m00_couplers_to_m00_regslice_RREADY;
  wire [1:0]m00_couplers_to_m00_regslice_RRESP;
  wire m00_couplers_to_m00_regslice_RVALID;
  wire [511:0]m00_couplers_to_m00_regslice_WDATA;
  wire m00_couplers_to_m00_regslice_WLAST;
  wire m00_couplers_to_m00_regslice_WREADY;
  wire [63:0]m00_couplers_to_m00_regslice_WSTRB;
  wire m00_couplers_to_m00_regslice_WVALID;
  wire [63:0]m00_regslice_to_m00_couplers_ARADDR;
  wire [1:0]m00_regslice_to_m00_couplers_ARBURST;
  wire [3:0]m00_regslice_to_m00_couplers_ARCACHE;
  wire [8:0]m00_regslice_to_m00_couplers_ARID;
  wire [7:0]m00_regslice_to_m00_couplers_ARLEN;
  wire [0:0]m00_regslice_to_m00_couplers_ARLOCK;
  wire [2:0]m00_regslice_to_m00_couplers_ARPROT;
  wire [3:0]m00_regslice_to_m00_couplers_ARQOS;
  wire m00_regslice_to_m00_couplers_ARREADY;
  wire [3:0]m00_regslice_to_m00_couplers_ARREGION;
  wire [2:0]m00_regslice_to_m00_couplers_ARSIZE;
  wire m00_regslice_to_m00_couplers_ARVALID;
  wire [63:0]m00_regslice_to_m00_couplers_AWADDR;
  wire [1:0]m00_regslice_to_m00_couplers_AWBURST;
  wire [3:0]m00_regslice_to_m00_couplers_AWCACHE;
  wire [8:0]m00_regslice_to_m00_couplers_AWID;
  wire [7:0]m00_regslice_to_m00_couplers_AWLEN;
  wire [0:0]m00_regslice_to_m00_couplers_AWLOCK;
  wire [2:0]m00_regslice_to_m00_couplers_AWPROT;
  wire [3:0]m00_regslice_to_m00_couplers_AWQOS;
  wire m00_regslice_to_m00_couplers_AWREADY;
  wire [3:0]m00_regslice_to_m00_couplers_AWREGION;
  wire [2:0]m00_regslice_to_m00_couplers_AWSIZE;
  wire m00_regslice_to_m00_couplers_AWVALID;
  wire [8:0]m00_regslice_to_m00_couplers_BID;
  wire m00_regslice_to_m00_couplers_BREADY;
  wire [1:0]m00_regslice_to_m00_couplers_BRESP;
  wire m00_regslice_to_m00_couplers_BVALID;
  wire [511:0]m00_regslice_to_m00_couplers_RDATA;
  wire [8:0]m00_regslice_to_m00_couplers_RID;
  wire m00_regslice_to_m00_couplers_RLAST;
  wire m00_regslice_to_m00_couplers_RREADY;
  wire [1:0]m00_regslice_to_m00_couplers_RRESP;
  wire m00_regslice_to_m00_couplers_RVALID;
  wire [511:0]m00_regslice_to_m00_couplers_WDATA;
  wire m00_regslice_to_m00_couplers_WLAST;
  wire m00_regslice_to_m00_couplers_WREADY;
  wire [63:0]m00_regslice_to_m00_couplers_WSTRB;
  wire m00_regslice_to_m00_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN;
  assign M_AXI_araddr[63:0] = m00_regslice_to_m00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = m00_regslice_to_m00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = m00_regslice_to_m00_couplers_ARCACHE;
  assign M_AXI_arid[8:0] = m00_regslice_to_m00_couplers_ARID;
  assign M_AXI_arlen[7:0] = m00_regslice_to_m00_couplers_ARLEN;
  assign M_AXI_arlock[0] = m00_regslice_to_m00_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = m00_regslice_to_m00_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = m00_regslice_to_m00_couplers_ARQOS;
  assign M_AXI_arregion[3:0] = m00_regslice_to_m00_couplers_ARREGION;
  assign M_AXI_arsize[2:0] = m00_regslice_to_m00_couplers_ARSIZE;
  assign M_AXI_arvalid = m00_regslice_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[63:0] = m00_regslice_to_m00_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = m00_regslice_to_m00_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = m00_regslice_to_m00_couplers_AWCACHE;
  assign M_AXI_awid[8:0] = m00_regslice_to_m00_couplers_AWID;
  assign M_AXI_awlen[7:0] = m00_regslice_to_m00_couplers_AWLEN;
  assign M_AXI_awlock[0] = m00_regslice_to_m00_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = m00_regslice_to_m00_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = m00_regslice_to_m00_couplers_AWQOS;
  assign M_AXI_awregion[3:0] = m00_regslice_to_m00_couplers_AWREGION;
  assign M_AXI_awsize[2:0] = m00_regslice_to_m00_couplers_AWSIZE;
  assign M_AXI_awvalid = m00_regslice_to_m00_couplers_AWVALID;
  assign M_AXI_bready = m00_regslice_to_m00_couplers_BREADY;
  assign M_AXI_rready = m00_regslice_to_m00_couplers_RREADY;
  assign M_AXI_wdata[511:0] = m00_regslice_to_m00_couplers_WDATA;
  assign M_AXI_wlast = m00_regslice_to_m00_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = m00_regslice_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid = m00_regslice_to_m00_couplers_WVALID;
  assign S_AXI_arready = m00_couplers_to_m00_regslice_ARREADY;
  assign S_AXI_awready = m00_couplers_to_m00_regslice_AWREADY;
  assign S_AXI_bid[8:0] = m00_couplers_to_m00_regslice_BID;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_regslice_BRESP;
  assign S_AXI_bvalid = m00_couplers_to_m00_regslice_BVALID;
  assign S_AXI_rdata[511:0] = m00_couplers_to_m00_regslice_RDATA;
  assign S_AXI_rid[8:0] = m00_couplers_to_m00_regslice_RID;
  assign S_AXI_rlast = m00_couplers_to_m00_regslice_RLAST;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_regslice_RRESP;
  assign S_AXI_rvalid = m00_couplers_to_m00_regslice_RVALID;
  assign S_AXI_wready = m00_couplers_to_m00_regslice_WREADY;
  assign m00_couplers_to_m00_regslice_ARADDR = S_AXI_araddr[63:0];
  assign m00_couplers_to_m00_regslice_ARBURST = S_AXI_arburst[1:0];
  assign m00_couplers_to_m00_regslice_ARCACHE = S_AXI_arcache[3:0];
  assign m00_couplers_to_m00_regslice_ARID = S_AXI_arid[8:0];
  assign m00_couplers_to_m00_regslice_ARLEN = S_AXI_arlen[7:0];
  assign m00_couplers_to_m00_regslice_ARLOCK = S_AXI_arlock[0];
  assign m00_couplers_to_m00_regslice_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_m00_regslice_ARQOS = S_AXI_arqos[3:0];
  assign m00_couplers_to_m00_regslice_ARREGION = S_AXI_arregion[3:0];
  assign m00_couplers_to_m00_regslice_ARSIZE = S_AXI_arsize[2:0];
  assign m00_couplers_to_m00_regslice_ARVALID = S_AXI_arvalid;
  assign m00_couplers_to_m00_regslice_AWADDR = S_AXI_awaddr[63:0];
  assign m00_couplers_to_m00_regslice_AWBURST = S_AXI_awburst[1:0];
  assign m00_couplers_to_m00_regslice_AWCACHE = S_AXI_awcache[3:0];
  assign m00_couplers_to_m00_regslice_AWID = S_AXI_awid[8:0];
  assign m00_couplers_to_m00_regslice_AWLEN = S_AXI_awlen[7:0];
  assign m00_couplers_to_m00_regslice_AWLOCK = S_AXI_awlock[0];
  assign m00_couplers_to_m00_regslice_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_m00_regslice_AWQOS = S_AXI_awqos[3:0];
  assign m00_couplers_to_m00_regslice_AWREGION = S_AXI_awregion[3:0];
  assign m00_couplers_to_m00_regslice_AWSIZE = S_AXI_awsize[2:0];
  assign m00_couplers_to_m00_regslice_AWVALID = S_AXI_awvalid;
  assign m00_couplers_to_m00_regslice_BREADY = S_AXI_bready;
  assign m00_couplers_to_m00_regslice_RREADY = S_AXI_rready;
  assign m00_couplers_to_m00_regslice_WDATA = S_AXI_wdata[511:0];
  assign m00_couplers_to_m00_regslice_WLAST = S_AXI_wlast;
  assign m00_couplers_to_m00_regslice_WSTRB = S_AXI_wstrb[63:0];
  assign m00_couplers_to_m00_regslice_WVALID = S_AXI_wvalid;
  assign m00_regslice_to_m00_couplers_ARREADY = M_AXI_arready;
  assign m00_regslice_to_m00_couplers_AWREADY = M_AXI_awready;
  assign m00_regslice_to_m00_couplers_BID = M_AXI_bid[8:0];
  assign m00_regslice_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_regslice_to_m00_couplers_BVALID = M_AXI_bvalid;
  assign m00_regslice_to_m00_couplers_RDATA = M_AXI_rdata[511:0];
  assign m00_regslice_to_m00_couplers_RID = M_AXI_rid[8:0];
  assign m00_regslice_to_m00_couplers_RLAST = M_AXI_rlast;
  assign m00_regslice_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_regslice_to_m00_couplers_RVALID = M_AXI_rvalid;
  assign m00_regslice_to_m00_couplers_WREADY = M_AXI_wready;
  workgroup_read_interconnect_4_to_1_m00_regslice_0 m00_regslice
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(m00_regslice_to_m00_couplers_ARADDR),
        .m_axi_arburst(m00_regslice_to_m00_couplers_ARBURST),
        .m_axi_arcache(m00_regslice_to_m00_couplers_ARCACHE),
        .m_axi_arid(m00_regslice_to_m00_couplers_ARID),
        .m_axi_arlen(m00_regslice_to_m00_couplers_ARLEN),
        .m_axi_arlock(m00_regslice_to_m00_couplers_ARLOCK),
        .m_axi_arprot(m00_regslice_to_m00_couplers_ARPROT),
        .m_axi_arqos(m00_regslice_to_m00_couplers_ARQOS),
        .m_axi_arready(m00_regslice_to_m00_couplers_ARREADY),
        .m_axi_arregion(m00_regslice_to_m00_couplers_ARREGION),
        .m_axi_arsize(m00_regslice_to_m00_couplers_ARSIZE),
        .m_axi_arvalid(m00_regslice_to_m00_couplers_ARVALID),
        .m_axi_awaddr(m00_regslice_to_m00_couplers_AWADDR),
        .m_axi_awburst(m00_regslice_to_m00_couplers_AWBURST),
        .m_axi_awcache(m00_regslice_to_m00_couplers_AWCACHE),
        .m_axi_awid(m00_regslice_to_m00_couplers_AWID),
        .m_axi_awlen(m00_regslice_to_m00_couplers_AWLEN),
        .m_axi_awlock(m00_regslice_to_m00_couplers_AWLOCK),
        .m_axi_awprot(m00_regslice_to_m00_couplers_AWPROT),
        .m_axi_awqos(m00_regslice_to_m00_couplers_AWQOS),
        .m_axi_awready(m00_regslice_to_m00_couplers_AWREADY),
        .m_axi_awregion(m00_regslice_to_m00_couplers_AWREGION),
        .m_axi_awsize(m00_regslice_to_m00_couplers_AWSIZE),
        .m_axi_awvalid(m00_regslice_to_m00_couplers_AWVALID),
        .m_axi_bid(m00_regslice_to_m00_couplers_BID),
        .m_axi_bready(m00_regslice_to_m00_couplers_BREADY),
        .m_axi_bresp(m00_regslice_to_m00_couplers_BRESP),
        .m_axi_bvalid(m00_regslice_to_m00_couplers_BVALID),
        .m_axi_rdata(m00_regslice_to_m00_couplers_RDATA),
        .m_axi_rid(m00_regslice_to_m00_couplers_RID),
        .m_axi_rlast(m00_regslice_to_m00_couplers_RLAST),
        .m_axi_rready(m00_regslice_to_m00_couplers_RREADY),
        .m_axi_rresp(m00_regslice_to_m00_couplers_RRESP),
        .m_axi_rvalid(m00_regslice_to_m00_couplers_RVALID),
        .m_axi_wdata(m00_regslice_to_m00_couplers_WDATA),
        .m_axi_wlast(m00_regslice_to_m00_couplers_WLAST),
        .m_axi_wready(m00_regslice_to_m00_couplers_WREADY),
        .m_axi_wstrb(m00_regslice_to_m00_couplers_WSTRB),
        .m_axi_wvalid(m00_regslice_to_m00_couplers_WVALID),
        .s_axi_araddr(m00_couplers_to_m00_regslice_ARADDR),
        .s_axi_arburst(m00_couplers_to_m00_regslice_ARBURST),
        .s_axi_arcache(m00_couplers_to_m00_regslice_ARCACHE),
        .s_axi_arid(m00_couplers_to_m00_regslice_ARID),
        .s_axi_arlen(m00_couplers_to_m00_regslice_ARLEN),
        .s_axi_arlock(m00_couplers_to_m00_regslice_ARLOCK),
        .s_axi_arprot(m00_couplers_to_m00_regslice_ARPROT),
        .s_axi_arqos(m00_couplers_to_m00_regslice_ARQOS),
        .s_axi_arready(m00_couplers_to_m00_regslice_ARREADY),
        .s_axi_arregion(m00_couplers_to_m00_regslice_ARREGION),
        .s_axi_arsize(m00_couplers_to_m00_regslice_ARSIZE),
        .s_axi_arvalid(m00_couplers_to_m00_regslice_ARVALID),
        .s_axi_awaddr(m00_couplers_to_m00_regslice_AWADDR),
        .s_axi_awburst(m00_couplers_to_m00_regslice_AWBURST),
        .s_axi_awcache(m00_couplers_to_m00_regslice_AWCACHE),
        .s_axi_awid(m00_couplers_to_m00_regslice_AWID),
        .s_axi_awlen(m00_couplers_to_m00_regslice_AWLEN),
        .s_axi_awlock(m00_couplers_to_m00_regslice_AWLOCK),
        .s_axi_awprot(m00_couplers_to_m00_regslice_AWPROT),
        .s_axi_awqos(m00_couplers_to_m00_regslice_AWQOS),
        .s_axi_awready(m00_couplers_to_m00_regslice_AWREADY),
        .s_axi_awregion(m00_couplers_to_m00_regslice_AWREGION),
        .s_axi_awsize(m00_couplers_to_m00_regslice_AWSIZE),
        .s_axi_awvalid(m00_couplers_to_m00_regslice_AWVALID),
        .s_axi_bid(m00_couplers_to_m00_regslice_BID),
        .s_axi_bready(m00_couplers_to_m00_regslice_BREADY),
        .s_axi_bresp(m00_couplers_to_m00_regslice_BRESP),
        .s_axi_bvalid(m00_couplers_to_m00_regslice_BVALID),
        .s_axi_rdata(m00_couplers_to_m00_regslice_RDATA),
        .s_axi_rid(m00_couplers_to_m00_regslice_RID),
        .s_axi_rlast(m00_couplers_to_m00_regslice_RLAST),
        .s_axi_rready(m00_couplers_to_m00_regslice_RREADY),
        .s_axi_rresp(m00_couplers_to_m00_regslice_RRESP),
        .s_axi_rvalid(m00_couplers_to_m00_regslice_RVALID),
        .s_axi_wdata(m00_couplers_to_m00_regslice_WDATA),
        .s_axi_wlast(m00_couplers_to_m00_regslice_WLAST),
        .s_axi_wready(m00_couplers_to_m00_regslice_WREADY),
        .s_axi_wstrb(m00_couplers_to_m00_regslice_WSTRB),
        .s_axi_wvalid(m00_couplers_to_m00_regslice_WVALID));
endmodule

module s00_couplers_imp_KAT6VS
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [63:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [6:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [6:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [8:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [8:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [63:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [6:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [63:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [6:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [6:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [6:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [63:0]s00_couplers_to_s00_regslice_ARADDR;
  wire [1:0]s00_couplers_to_s00_regslice_ARBURST;
  wire [3:0]s00_couplers_to_s00_regslice_ARCACHE;
  wire [6:0]s00_couplers_to_s00_regslice_ARID;
  wire [7:0]s00_couplers_to_s00_regslice_ARLEN;
  wire [0:0]s00_couplers_to_s00_regslice_ARLOCK;
  wire [2:0]s00_couplers_to_s00_regslice_ARPROT;
  wire [3:0]s00_couplers_to_s00_regslice_ARQOS;
  wire s00_couplers_to_s00_regslice_ARREADY;
  wire [3:0]s00_couplers_to_s00_regslice_ARREGION;
  wire [2:0]s00_couplers_to_s00_regslice_ARSIZE;
  wire s00_couplers_to_s00_regslice_ARVALID;
  wire [63:0]s00_couplers_to_s00_regslice_AWADDR;
  wire [1:0]s00_couplers_to_s00_regslice_AWBURST;
  wire [3:0]s00_couplers_to_s00_regslice_AWCACHE;
  wire [6:0]s00_couplers_to_s00_regslice_AWID;
  wire [7:0]s00_couplers_to_s00_regslice_AWLEN;
  wire [0:0]s00_couplers_to_s00_regslice_AWLOCK;
  wire [2:0]s00_couplers_to_s00_regslice_AWPROT;
  wire [3:0]s00_couplers_to_s00_regslice_AWQOS;
  wire s00_couplers_to_s00_regslice_AWREADY;
  wire [3:0]s00_couplers_to_s00_regslice_AWREGION;
  wire [2:0]s00_couplers_to_s00_regslice_AWSIZE;
  wire s00_couplers_to_s00_regslice_AWVALID;
  wire [6:0]s00_couplers_to_s00_regslice_BID;
  wire s00_couplers_to_s00_regslice_BREADY;
  wire [1:0]s00_couplers_to_s00_regslice_BRESP;
  wire s00_couplers_to_s00_regslice_BVALID;
  wire [511:0]s00_couplers_to_s00_regslice_RDATA;
  wire [6:0]s00_couplers_to_s00_regslice_RID;
  wire s00_couplers_to_s00_regslice_RLAST;
  wire s00_couplers_to_s00_regslice_RREADY;
  wire [1:0]s00_couplers_to_s00_regslice_RRESP;
  wire s00_couplers_to_s00_regslice_RVALID;
  wire [511:0]s00_couplers_to_s00_regslice_WDATA;
  wire s00_couplers_to_s00_regslice_WLAST;
  wire s00_couplers_to_s00_regslice_WREADY;
  wire [63:0]s00_couplers_to_s00_regslice_WSTRB;
  wire s00_couplers_to_s00_regslice_WVALID;
  wire [63:0]s00_regslice_to_s00_couplers_ARADDR;
  wire [1:0]s00_regslice_to_s00_couplers_ARBURST;
  wire [3:0]s00_regslice_to_s00_couplers_ARCACHE;
  wire [6:0]s00_regslice_to_s00_couplers_ARID;
  wire [7:0]s00_regslice_to_s00_couplers_ARLEN;
  wire [0:0]s00_regslice_to_s00_couplers_ARLOCK;
  wire [2:0]s00_regslice_to_s00_couplers_ARPROT;
  wire [3:0]s00_regslice_to_s00_couplers_ARQOS;
  wire s00_regslice_to_s00_couplers_ARREADY;
  wire [2:0]s00_regslice_to_s00_couplers_ARSIZE;
  wire s00_regslice_to_s00_couplers_ARVALID;
  wire [63:0]s00_regslice_to_s00_couplers_AWADDR;
  wire [1:0]s00_regslice_to_s00_couplers_AWBURST;
  wire [3:0]s00_regslice_to_s00_couplers_AWCACHE;
  wire [6:0]s00_regslice_to_s00_couplers_AWID;
  wire [7:0]s00_regslice_to_s00_couplers_AWLEN;
  wire [0:0]s00_regslice_to_s00_couplers_AWLOCK;
  wire [2:0]s00_regslice_to_s00_couplers_AWPROT;
  wire [3:0]s00_regslice_to_s00_couplers_AWQOS;
  wire s00_regslice_to_s00_couplers_AWREADY;
  wire [2:0]s00_regslice_to_s00_couplers_AWSIZE;
  wire s00_regslice_to_s00_couplers_AWVALID;
  wire [8:0]s00_regslice_to_s00_couplers_BID;
  wire s00_regslice_to_s00_couplers_BREADY;
  wire [1:0]s00_regslice_to_s00_couplers_BRESP;
  wire s00_regslice_to_s00_couplers_BVALID;
  wire [511:0]s00_regslice_to_s00_couplers_RDATA;
  wire [8:0]s00_regslice_to_s00_couplers_RID;
  wire s00_regslice_to_s00_couplers_RLAST;
  wire s00_regslice_to_s00_couplers_RREADY;
  wire [1:0]s00_regslice_to_s00_couplers_RRESP;
  wire s00_regslice_to_s00_couplers_RVALID;
  wire [511:0]s00_regslice_to_s00_couplers_WDATA;
  wire s00_regslice_to_s00_couplers_WLAST;
  wire s00_regslice_to_s00_couplers_WREADY;
  wire [63:0]s00_regslice_to_s00_couplers_WSTRB;
  wire s00_regslice_to_s00_couplers_WVALID;

  assign M_AXI_araddr[63:0] = s00_regslice_to_s00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s00_regslice_to_s00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s00_regslice_to_s00_couplers_ARCACHE;
  assign M_AXI_arid[6:0] = s00_regslice_to_s00_couplers_ARID;
  assign M_AXI_arlen[7:0] = s00_regslice_to_s00_couplers_ARLEN;
  assign M_AXI_arlock[0] = s00_regslice_to_s00_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s00_regslice_to_s00_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s00_regslice_to_s00_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s00_regslice_to_s00_couplers_ARSIZE;
  assign M_AXI_arvalid = s00_regslice_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[63:0] = s00_regslice_to_s00_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s00_regslice_to_s00_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s00_regslice_to_s00_couplers_AWCACHE;
  assign M_AXI_awid[6:0] = s00_regslice_to_s00_couplers_AWID;
  assign M_AXI_awlen[7:0] = s00_regslice_to_s00_couplers_AWLEN;
  assign M_AXI_awlock[0] = s00_regslice_to_s00_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s00_regslice_to_s00_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s00_regslice_to_s00_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s00_regslice_to_s00_couplers_AWSIZE;
  assign M_AXI_awvalid = s00_regslice_to_s00_couplers_AWVALID;
  assign M_AXI_bready = s00_regslice_to_s00_couplers_BREADY;
  assign M_AXI_rready = s00_regslice_to_s00_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s00_regslice_to_s00_couplers_WDATA;
  assign M_AXI_wlast = s00_regslice_to_s00_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s00_regslice_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = s00_regslice_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s00_couplers_to_s00_regslice_ARREADY;
  assign S_AXI_awready = s00_couplers_to_s00_regslice_AWREADY;
  assign S_AXI_bid[6:0] = s00_couplers_to_s00_regslice_BID;
  assign S_AXI_bresp[1:0] = s00_couplers_to_s00_regslice_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_s00_regslice_BVALID;
  assign S_AXI_rdata[511:0] = s00_couplers_to_s00_regslice_RDATA;
  assign S_AXI_rid[6:0] = s00_couplers_to_s00_regslice_RID;
  assign S_AXI_rlast = s00_couplers_to_s00_regslice_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_s00_regslice_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_s00_regslice_RVALID;
  assign S_AXI_wready = s00_couplers_to_s00_regslice_WREADY;
  assign s00_couplers_to_s00_regslice_ARADDR = S_AXI_araddr[63:0];
  assign s00_couplers_to_s00_regslice_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_s00_regslice_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_s00_regslice_ARID = S_AXI_arid[6:0];
  assign s00_couplers_to_s00_regslice_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_s00_regslice_ARLOCK = S_AXI_arlock[0];
  assign s00_couplers_to_s00_regslice_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_s00_regslice_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_s00_regslice_ARREGION = S_AXI_arregion[3:0];
  assign s00_couplers_to_s00_regslice_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_s00_regslice_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_s00_regslice_AWADDR = S_AXI_awaddr[63:0];
  assign s00_couplers_to_s00_regslice_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_s00_regslice_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_s00_regslice_AWID = S_AXI_awid[6:0];
  assign s00_couplers_to_s00_regslice_AWLEN = S_AXI_awlen[7:0];
  assign s00_couplers_to_s00_regslice_AWLOCK = S_AXI_awlock[0];
  assign s00_couplers_to_s00_regslice_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_s00_regslice_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_s00_regslice_AWREGION = S_AXI_awregion[3:0];
  assign s00_couplers_to_s00_regslice_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_s00_regslice_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_s00_regslice_BREADY = S_AXI_bready;
  assign s00_couplers_to_s00_regslice_RREADY = S_AXI_rready;
  assign s00_couplers_to_s00_regslice_WDATA = S_AXI_wdata[511:0];
  assign s00_couplers_to_s00_regslice_WLAST = S_AXI_wlast;
  assign s00_couplers_to_s00_regslice_WSTRB = S_AXI_wstrb[63:0];
  assign s00_couplers_to_s00_regslice_WVALID = S_AXI_wvalid;
  assign s00_regslice_to_s00_couplers_ARREADY = M_AXI_arready;
  assign s00_regslice_to_s00_couplers_AWREADY = M_AXI_awready;
  assign s00_regslice_to_s00_couplers_BID = M_AXI_bid[8:0];
  assign s00_regslice_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign s00_regslice_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign s00_regslice_to_s00_couplers_RDATA = M_AXI_rdata[511:0];
  assign s00_regslice_to_s00_couplers_RID = M_AXI_rid[8:0];
  assign s00_regslice_to_s00_couplers_RLAST = M_AXI_rlast;
  assign s00_regslice_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_regslice_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign s00_regslice_to_s00_couplers_WREADY = M_AXI_wready;
  workgroup_read_interconnect_4_to_1_s00_regslice_0 s00_regslice
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(s00_regslice_to_s00_couplers_ARADDR),
        .m_axi_arburst(s00_regslice_to_s00_couplers_ARBURST),
        .m_axi_arcache(s00_regslice_to_s00_couplers_ARCACHE),
        .m_axi_arid(s00_regslice_to_s00_couplers_ARID),
        .m_axi_arlen(s00_regslice_to_s00_couplers_ARLEN),
        .m_axi_arlock(s00_regslice_to_s00_couplers_ARLOCK),
        .m_axi_arprot(s00_regslice_to_s00_couplers_ARPROT),
        .m_axi_arqos(s00_regslice_to_s00_couplers_ARQOS),
        .m_axi_arready(s00_regslice_to_s00_couplers_ARREADY),
        .m_axi_arsize(s00_regslice_to_s00_couplers_ARSIZE),
        .m_axi_arvalid(s00_regslice_to_s00_couplers_ARVALID),
        .m_axi_awaddr(s00_regslice_to_s00_couplers_AWADDR),
        .m_axi_awburst(s00_regslice_to_s00_couplers_AWBURST),
        .m_axi_awcache(s00_regslice_to_s00_couplers_AWCACHE),
        .m_axi_awid(s00_regslice_to_s00_couplers_AWID),
        .m_axi_awlen(s00_regslice_to_s00_couplers_AWLEN),
        .m_axi_awlock(s00_regslice_to_s00_couplers_AWLOCK),
        .m_axi_awprot(s00_regslice_to_s00_couplers_AWPROT),
        .m_axi_awqos(s00_regslice_to_s00_couplers_AWQOS),
        .m_axi_awready(s00_regslice_to_s00_couplers_AWREADY),
        .m_axi_awsize(s00_regslice_to_s00_couplers_AWSIZE),
        .m_axi_awvalid(s00_regslice_to_s00_couplers_AWVALID),
        .m_axi_bid(s00_regslice_to_s00_couplers_BID[6:0]),
        .m_axi_bready(s00_regslice_to_s00_couplers_BREADY),
        .m_axi_bresp(s00_regslice_to_s00_couplers_BRESP),
        .m_axi_bvalid(s00_regslice_to_s00_couplers_BVALID),
        .m_axi_rdata(s00_regslice_to_s00_couplers_RDATA),
        .m_axi_rid(s00_regslice_to_s00_couplers_RID[6:0]),
        .m_axi_rlast(s00_regslice_to_s00_couplers_RLAST),
        .m_axi_rready(s00_regslice_to_s00_couplers_RREADY),
        .m_axi_rresp(s00_regslice_to_s00_couplers_RRESP),
        .m_axi_rvalid(s00_regslice_to_s00_couplers_RVALID),
        .m_axi_wdata(s00_regslice_to_s00_couplers_WDATA),
        .m_axi_wlast(s00_regslice_to_s00_couplers_WLAST),
        .m_axi_wready(s00_regslice_to_s00_couplers_WREADY),
        .m_axi_wstrb(s00_regslice_to_s00_couplers_WSTRB),
        .m_axi_wvalid(s00_regslice_to_s00_couplers_WVALID),
        .s_axi_araddr(s00_couplers_to_s00_regslice_ARADDR),
        .s_axi_arburst(s00_couplers_to_s00_regslice_ARBURST),
        .s_axi_arcache(s00_couplers_to_s00_regslice_ARCACHE),
        .s_axi_arid(s00_couplers_to_s00_regslice_ARID),
        .s_axi_arlen(s00_couplers_to_s00_regslice_ARLEN),
        .s_axi_arlock(s00_couplers_to_s00_regslice_ARLOCK),
        .s_axi_arprot(s00_couplers_to_s00_regslice_ARPROT),
        .s_axi_arqos(s00_couplers_to_s00_regslice_ARQOS),
        .s_axi_arready(s00_couplers_to_s00_regslice_ARREADY),
        .s_axi_arregion(s00_couplers_to_s00_regslice_ARREGION),
        .s_axi_arsize(s00_couplers_to_s00_regslice_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_s00_regslice_ARVALID),
        .s_axi_awaddr(s00_couplers_to_s00_regslice_AWADDR),
        .s_axi_awburst(s00_couplers_to_s00_regslice_AWBURST),
        .s_axi_awcache(s00_couplers_to_s00_regslice_AWCACHE),
        .s_axi_awid(s00_couplers_to_s00_regslice_AWID),
        .s_axi_awlen(s00_couplers_to_s00_regslice_AWLEN),
        .s_axi_awlock(s00_couplers_to_s00_regslice_AWLOCK),
        .s_axi_awprot(s00_couplers_to_s00_regslice_AWPROT),
        .s_axi_awqos(s00_couplers_to_s00_regslice_AWQOS),
        .s_axi_awready(s00_couplers_to_s00_regslice_AWREADY),
        .s_axi_awregion(s00_couplers_to_s00_regslice_AWREGION),
        .s_axi_awsize(s00_couplers_to_s00_regslice_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_s00_regslice_AWVALID),
        .s_axi_bid(s00_couplers_to_s00_regslice_BID),
        .s_axi_bready(s00_couplers_to_s00_regslice_BREADY),
        .s_axi_bresp(s00_couplers_to_s00_regslice_BRESP),
        .s_axi_bvalid(s00_couplers_to_s00_regslice_BVALID),
        .s_axi_rdata(s00_couplers_to_s00_regslice_RDATA),
        .s_axi_rid(s00_couplers_to_s00_regslice_RID),
        .s_axi_rlast(s00_couplers_to_s00_regslice_RLAST),
        .s_axi_rready(s00_couplers_to_s00_regslice_RREADY),
        .s_axi_rresp(s00_couplers_to_s00_regslice_RRESP),
        .s_axi_rvalid(s00_couplers_to_s00_regslice_RVALID),
        .s_axi_wdata(s00_couplers_to_s00_regslice_WDATA),
        .s_axi_wlast(s00_couplers_to_s00_regslice_WLAST),
        .s_axi_wready(s00_couplers_to_s00_regslice_WREADY),
        .s_axi_wstrb(s00_couplers_to_s00_regslice_WSTRB),
        .s_axi_wvalid(s00_couplers_to_s00_regslice_WVALID));
endmodule

module s01_couplers_imp_RGYEM2
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [63:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [6:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [6:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [8:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [8:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [63:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [6:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [63:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [6:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [6:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [6:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [63:0]s01_couplers_to_s01_regslice_ARADDR;
  wire [1:0]s01_couplers_to_s01_regslice_ARBURST;
  wire [3:0]s01_couplers_to_s01_regslice_ARCACHE;
  wire [6:0]s01_couplers_to_s01_regslice_ARID;
  wire [7:0]s01_couplers_to_s01_regslice_ARLEN;
  wire [0:0]s01_couplers_to_s01_regslice_ARLOCK;
  wire [2:0]s01_couplers_to_s01_regslice_ARPROT;
  wire [3:0]s01_couplers_to_s01_regslice_ARQOS;
  wire s01_couplers_to_s01_regslice_ARREADY;
  wire [3:0]s01_couplers_to_s01_regslice_ARREGION;
  wire [2:0]s01_couplers_to_s01_regslice_ARSIZE;
  wire s01_couplers_to_s01_regslice_ARVALID;
  wire [63:0]s01_couplers_to_s01_regslice_AWADDR;
  wire [1:0]s01_couplers_to_s01_regslice_AWBURST;
  wire [3:0]s01_couplers_to_s01_regslice_AWCACHE;
  wire [6:0]s01_couplers_to_s01_regslice_AWID;
  wire [7:0]s01_couplers_to_s01_regslice_AWLEN;
  wire [0:0]s01_couplers_to_s01_regslice_AWLOCK;
  wire [2:0]s01_couplers_to_s01_regslice_AWPROT;
  wire [3:0]s01_couplers_to_s01_regslice_AWQOS;
  wire s01_couplers_to_s01_regslice_AWREADY;
  wire [3:0]s01_couplers_to_s01_regslice_AWREGION;
  wire [2:0]s01_couplers_to_s01_regslice_AWSIZE;
  wire s01_couplers_to_s01_regslice_AWVALID;
  wire [6:0]s01_couplers_to_s01_regslice_BID;
  wire s01_couplers_to_s01_regslice_BREADY;
  wire [1:0]s01_couplers_to_s01_regslice_BRESP;
  wire s01_couplers_to_s01_regslice_BVALID;
  wire [511:0]s01_couplers_to_s01_regslice_RDATA;
  wire [6:0]s01_couplers_to_s01_regslice_RID;
  wire s01_couplers_to_s01_regslice_RLAST;
  wire s01_couplers_to_s01_regslice_RREADY;
  wire [1:0]s01_couplers_to_s01_regslice_RRESP;
  wire s01_couplers_to_s01_regslice_RVALID;
  wire [511:0]s01_couplers_to_s01_regslice_WDATA;
  wire s01_couplers_to_s01_regslice_WLAST;
  wire s01_couplers_to_s01_regslice_WREADY;
  wire [63:0]s01_couplers_to_s01_regslice_WSTRB;
  wire s01_couplers_to_s01_regslice_WVALID;
  wire [63:0]s01_regslice_to_s01_couplers_ARADDR;
  wire [1:0]s01_regslice_to_s01_couplers_ARBURST;
  wire [3:0]s01_regslice_to_s01_couplers_ARCACHE;
  wire [6:0]s01_regslice_to_s01_couplers_ARID;
  wire [7:0]s01_regslice_to_s01_couplers_ARLEN;
  wire [0:0]s01_regslice_to_s01_couplers_ARLOCK;
  wire [2:0]s01_regslice_to_s01_couplers_ARPROT;
  wire [3:0]s01_regslice_to_s01_couplers_ARQOS;
  wire s01_regslice_to_s01_couplers_ARREADY;
  wire [2:0]s01_regslice_to_s01_couplers_ARSIZE;
  wire s01_regslice_to_s01_couplers_ARVALID;
  wire [63:0]s01_regslice_to_s01_couplers_AWADDR;
  wire [1:0]s01_regslice_to_s01_couplers_AWBURST;
  wire [3:0]s01_regslice_to_s01_couplers_AWCACHE;
  wire [6:0]s01_regslice_to_s01_couplers_AWID;
  wire [7:0]s01_regslice_to_s01_couplers_AWLEN;
  wire [0:0]s01_regslice_to_s01_couplers_AWLOCK;
  wire [2:0]s01_regslice_to_s01_couplers_AWPROT;
  wire [3:0]s01_regslice_to_s01_couplers_AWQOS;
  wire s01_regslice_to_s01_couplers_AWREADY;
  wire [2:0]s01_regslice_to_s01_couplers_AWSIZE;
  wire s01_regslice_to_s01_couplers_AWVALID;
  wire [8:0]s01_regslice_to_s01_couplers_BID;
  wire s01_regslice_to_s01_couplers_BREADY;
  wire [1:0]s01_regslice_to_s01_couplers_BRESP;
  wire s01_regslice_to_s01_couplers_BVALID;
  wire [511:0]s01_regslice_to_s01_couplers_RDATA;
  wire [8:0]s01_regslice_to_s01_couplers_RID;
  wire s01_regslice_to_s01_couplers_RLAST;
  wire s01_regslice_to_s01_couplers_RREADY;
  wire [1:0]s01_regslice_to_s01_couplers_RRESP;
  wire s01_regslice_to_s01_couplers_RVALID;
  wire [511:0]s01_regslice_to_s01_couplers_WDATA;
  wire s01_regslice_to_s01_couplers_WLAST;
  wire s01_regslice_to_s01_couplers_WREADY;
  wire [63:0]s01_regslice_to_s01_couplers_WSTRB;
  wire s01_regslice_to_s01_couplers_WVALID;

  assign M_AXI_araddr[63:0] = s01_regslice_to_s01_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s01_regslice_to_s01_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s01_regslice_to_s01_couplers_ARCACHE;
  assign M_AXI_arid[6:0] = s01_regslice_to_s01_couplers_ARID;
  assign M_AXI_arlen[7:0] = s01_regslice_to_s01_couplers_ARLEN;
  assign M_AXI_arlock[0] = s01_regslice_to_s01_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s01_regslice_to_s01_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s01_regslice_to_s01_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s01_regslice_to_s01_couplers_ARSIZE;
  assign M_AXI_arvalid = s01_regslice_to_s01_couplers_ARVALID;
  assign M_AXI_awaddr[63:0] = s01_regslice_to_s01_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s01_regslice_to_s01_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s01_regslice_to_s01_couplers_AWCACHE;
  assign M_AXI_awid[6:0] = s01_regslice_to_s01_couplers_AWID;
  assign M_AXI_awlen[7:0] = s01_regslice_to_s01_couplers_AWLEN;
  assign M_AXI_awlock[0] = s01_regslice_to_s01_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s01_regslice_to_s01_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s01_regslice_to_s01_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s01_regslice_to_s01_couplers_AWSIZE;
  assign M_AXI_awvalid = s01_regslice_to_s01_couplers_AWVALID;
  assign M_AXI_bready = s01_regslice_to_s01_couplers_BREADY;
  assign M_AXI_rready = s01_regslice_to_s01_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s01_regslice_to_s01_couplers_WDATA;
  assign M_AXI_wlast = s01_regslice_to_s01_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s01_regslice_to_s01_couplers_WSTRB;
  assign M_AXI_wvalid = s01_regslice_to_s01_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s01_couplers_to_s01_regslice_ARREADY;
  assign S_AXI_awready = s01_couplers_to_s01_regslice_AWREADY;
  assign S_AXI_bid[6:0] = s01_couplers_to_s01_regslice_BID;
  assign S_AXI_bresp[1:0] = s01_couplers_to_s01_regslice_BRESP;
  assign S_AXI_bvalid = s01_couplers_to_s01_regslice_BVALID;
  assign S_AXI_rdata[511:0] = s01_couplers_to_s01_regslice_RDATA;
  assign S_AXI_rid[6:0] = s01_couplers_to_s01_regslice_RID;
  assign S_AXI_rlast = s01_couplers_to_s01_regslice_RLAST;
  assign S_AXI_rresp[1:0] = s01_couplers_to_s01_regslice_RRESP;
  assign S_AXI_rvalid = s01_couplers_to_s01_regslice_RVALID;
  assign S_AXI_wready = s01_couplers_to_s01_regslice_WREADY;
  assign s01_couplers_to_s01_regslice_ARADDR = S_AXI_araddr[63:0];
  assign s01_couplers_to_s01_regslice_ARBURST = S_AXI_arburst[1:0];
  assign s01_couplers_to_s01_regslice_ARCACHE = S_AXI_arcache[3:0];
  assign s01_couplers_to_s01_regslice_ARID = S_AXI_arid[6:0];
  assign s01_couplers_to_s01_regslice_ARLEN = S_AXI_arlen[7:0];
  assign s01_couplers_to_s01_regslice_ARLOCK = S_AXI_arlock[0];
  assign s01_couplers_to_s01_regslice_ARPROT = S_AXI_arprot[2:0];
  assign s01_couplers_to_s01_regslice_ARQOS = S_AXI_arqos[3:0];
  assign s01_couplers_to_s01_regslice_ARREGION = S_AXI_arregion[3:0];
  assign s01_couplers_to_s01_regslice_ARSIZE = S_AXI_arsize[2:0];
  assign s01_couplers_to_s01_regslice_ARVALID = S_AXI_arvalid;
  assign s01_couplers_to_s01_regslice_AWADDR = S_AXI_awaddr[63:0];
  assign s01_couplers_to_s01_regslice_AWBURST = S_AXI_awburst[1:0];
  assign s01_couplers_to_s01_regslice_AWCACHE = S_AXI_awcache[3:0];
  assign s01_couplers_to_s01_regslice_AWID = S_AXI_awid[6:0];
  assign s01_couplers_to_s01_regslice_AWLEN = S_AXI_awlen[7:0];
  assign s01_couplers_to_s01_regslice_AWLOCK = S_AXI_awlock[0];
  assign s01_couplers_to_s01_regslice_AWPROT = S_AXI_awprot[2:0];
  assign s01_couplers_to_s01_regslice_AWQOS = S_AXI_awqos[3:0];
  assign s01_couplers_to_s01_regslice_AWREGION = S_AXI_awregion[3:0];
  assign s01_couplers_to_s01_regslice_AWSIZE = S_AXI_awsize[2:0];
  assign s01_couplers_to_s01_regslice_AWVALID = S_AXI_awvalid;
  assign s01_couplers_to_s01_regslice_BREADY = S_AXI_bready;
  assign s01_couplers_to_s01_regslice_RREADY = S_AXI_rready;
  assign s01_couplers_to_s01_regslice_WDATA = S_AXI_wdata[511:0];
  assign s01_couplers_to_s01_regslice_WLAST = S_AXI_wlast;
  assign s01_couplers_to_s01_regslice_WSTRB = S_AXI_wstrb[63:0];
  assign s01_couplers_to_s01_regslice_WVALID = S_AXI_wvalid;
  assign s01_regslice_to_s01_couplers_ARREADY = M_AXI_arready;
  assign s01_regslice_to_s01_couplers_AWREADY = M_AXI_awready;
  assign s01_regslice_to_s01_couplers_BID = M_AXI_bid[8:0];
  assign s01_regslice_to_s01_couplers_BRESP = M_AXI_bresp[1:0];
  assign s01_regslice_to_s01_couplers_BVALID = M_AXI_bvalid;
  assign s01_regslice_to_s01_couplers_RDATA = M_AXI_rdata[511:0];
  assign s01_regslice_to_s01_couplers_RID = M_AXI_rid[8:0];
  assign s01_regslice_to_s01_couplers_RLAST = M_AXI_rlast;
  assign s01_regslice_to_s01_couplers_RRESP = M_AXI_rresp[1:0];
  assign s01_regslice_to_s01_couplers_RVALID = M_AXI_rvalid;
  assign s01_regslice_to_s01_couplers_WREADY = M_AXI_wready;
  workgroup_read_interconnect_4_to_1_s01_regslice_0 s01_regslice
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(s01_regslice_to_s01_couplers_ARADDR),
        .m_axi_arburst(s01_regslice_to_s01_couplers_ARBURST),
        .m_axi_arcache(s01_regslice_to_s01_couplers_ARCACHE),
        .m_axi_arid(s01_regslice_to_s01_couplers_ARID),
        .m_axi_arlen(s01_regslice_to_s01_couplers_ARLEN),
        .m_axi_arlock(s01_regslice_to_s01_couplers_ARLOCK),
        .m_axi_arprot(s01_regslice_to_s01_couplers_ARPROT),
        .m_axi_arqos(s01_regslice_to_s01_couplers_ARQOS),
        .m_axi_arready(s01_regslice_to_s01_couplers_ARREADY),
        .m_axi_arsize(s01_regslice_to_s01_couplers_ARSIZE),
        .m_axi_arvalid(s01_regslice_to_s01_couplers_ARVALID),
        .m_axi_awaddr(s01_regslice_to_s01_couplers_AWADDR),
        .m_axi_awburst(s01_regslice_to_s01_couplers_AWBURST),
        .m_axi_awcache(s01_regslice_to_s01_couplers_AWCACHE),
        .m_axi_awid(s01_regslice_to_s01_couplers_AWID),
        .m_axi_awlen(s01_regslice_to_s01_couplers_AWLEN),
        .m_axi_awlock(s01_regslice_to_s01_couplers_AWLOCK),
        .m_axi_awprot(s01_regslice_to_s01_couplers_AWPROT),
        .m_axi_awqos(s01_regslice_to_s01_couplers_AWQOS),
        .m_axi_awready(s01_regslice_to_s01_couplers_AWREADY),
        .m_axi_awsize(s01_regslice_to_s01_couplers_AWSIZE),
        .m_axi_awvalid(s01_regslice_to_s01_couplers_AWVALID),
        .m_axi_bid(s01_regslice_to_s01_couplers_BID[6:0]),
        .m_axi_bready(s01_regslice_to_s01_couplers_BREADY),
        .m_axi_bresp(s01_regslice_to_s01_couplers_BRESP),
        .m_axi_bvalid(s01_regslice_to_s01_couplers_BVALID),
        .m_axi_rdata(s01_regslice_to_s01_couplers_RDATA),
        .m_axi_rid(s01_regslice_to_s01_couplers_RID[6:0]),
        .m_axi_rlast(s01_regslice_to_s01_couplers_RLAST),
        .m_axi_rready(s01_regslice_to_s01_couplers_RREADY),
        .m_axi_rresp(s01_regslice_to_s01_couplers_RRESP),
        .m_axi_rvalid(s01_regslice_to_s01_couplers_RVALID),
        .m_axi_wdata(s01_regslice_to_s01_couplers_WDATA),
        .m_axi_wlast(s01_regslice_to_s01_couplers_WLAST),
        .m_axi_wready(s01_regslice_to_s01_couplers_WREADY),
        .m_axi_wstrb(s01_regslice_to_s01_couplers_WSTRB),
        .m_axi_wvalid(s01_regslice_to_s01_couplers_WVALID),
        .s_axi_araddr(s01_couplers_to_s01_regslice_ARADDR),
        .s_axi_arburst(s01_couplers_to_s01_regslice_ARBURST),
        .s_axi_arcache(s01_couplers_to_s01_regslice_ARCACHE),
        .s_axi_arid(s01_couplers_to_s01_regslice_ARID),
        .s_axi_arlen(s01_couplers_to_s01_regslice_ARLEN),
        .s_axi_arlock(s01_couplers_to_s01_regslice_ARLOCK),
        .s_axi_arprot(s01_couplers_to_s01_regslice_ARPROT),
        .s_axi_arqos(s01_couplers_to_s01_regslice_ARQOS),
        .s_axi_arready(s01_couplers_to_s01_regslice_ARREADY),
        .s_axi_arregion(s01_couplers_to_s01_regslice_ARREGION),
        .s_axi_arsize(s01_couplers_to_s01_regslice_ARSIZE),
        .s_axi_arvalid(s01_couplers_to_s01_regslice_ARVALID),
        .s_axi_awaddr(s01_couplers_to_s01_regslice_AWADDR),
        .s_axi_awburst(s01_couplers_to_s01_regslice_AWBURST),
        .s_axi_awcache(s01_couplers_to_s01_regslice_AWCACHE),
        .s_axi_awid(s01_couplers_to_s01_regslice_AWID),
        .s_axi_awlen(s01_couplers_to_s01_regslice_AWLEN),
        .s_axi_awlock(s01_couplers_to_s01_regslice_AWLOCK),
        .s_axi_awprot(s01_couplers_to_s01_regslice_AWPROT),
        .s_axi_awqos(s01_couplers_to_s01_regslice_AWQOS),
        .s_axi_awready(s01_couplers_to_s01_regslice_AWREADY),
        .s_axi_awregion(s01_couplers_to_s01_regslice_AWREGION),
        .s_axi_awsize(s01_couplers_to_s01_regslice_AWSIZE),
        .s_axi_awvalid(s01_couplers_to_s01_regslice_AWVALID),
        .s_axi_bid(s01_couplers_to_s01_regslice_BID),
        .s_axi_bready(s01_couplers_to_s01_regslice_BREADY),
        .s_axi_bresp(s01_couplers_to_s01_regslice_BRESP),
        .s_axi_bvalid(s01_couplers_to_s01_regslice_BVALID),
        .s_axi_rdata(s01_couplers_to_s01_regslice_RDATA),
        .s_axi_rid(s01_couplers_to_s01_regslice_RID),
        .s_axi_rlast(s01_couplers_to_s01_regslice_RLAST),
        .s_axi_rready(s01_couplers_to_s01_regslice_RREADY),
        .s_axi_rresp(s01_couplers_to_s01_regslice_RRESP),
        .s_axi_rvalid(s01_couplers_to_s01_regslice_RVALID),
        .s_axi_wdata(s01_couplers_to_s01_regslice_WDATA),
        .s_axi_wlast(s01_couplers_to_s01_regslice_WLAST),
        .s_axi_wready(s01_couplers_to_s01_regslice_WREADY),
        .s_axi_wstrb(s01_couplers_to_s01_regslice_WSTRB),
        .s_axi_wvalid(s01_couplers_to_s01_regslice_WVALID));
endmodule

module s02_couplers_imp_86EZTO
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [63:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [6:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [6:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [8:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [8:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [63:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [6:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [63:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [6:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [6:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [6:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [63:0]s02_couplers_to_s02_regslice_ARADDR;
  wire [1:0]s02_couplers_to_s02_regslice_ARBURST;
  wire [3:0]s02_couplers_to_s02_regslice_ARCACHE;
  wire [6:0]s02_couplers_to_s02_regslice_ARID;
  wire [7:0]s02_couplers_to_s02_regslice_ARLEN;
  wire [0:0]s02_couplers_to_s02_regslice_ARLOCK;
  wire [2:0]s02_couplers_to_s02_regslice_ARPROT;
  wire [3:0]s02_couplers_to_s02_regslice_ARQOS;
  wire s02_couplers_to_s02_regslice_ARREADY;
  wire [3:0]s02_couplers_to_s02_regslice_ARREGION;
  wire [2:0]s02_couplers_to_s02_regslice_ARSIZE;
  wire s02_couplers_to_s02_regslice_ARVALID;
  wire [63:0]s02_couplers_to_s02_regslice_AWADDR;
  wire [1:0]s02_couplers_to_s02_regslice_AWBURST;
  wire [3:0]s02_couplers_to_s02_regslice_AWCACHE;
  wire [6:0]s02_couplers_to_s02_regslice_AWID;
  wire [7:0]s02_couplers_to_s02_regslice_AWLEN;
  wire [0:0]s02_couplers_to_s02_regslice_AWLOCK;
  wire [2:0]s02_couplers_to_s02_regslice_AWPROT;
  wire [3:0]s02_couplers_to_s02_regslice_AWQOS;
  wire s02_couplers_to_s02_regslice_AWREADY;
  wire [3:0]s02_couplers_to_s02_regslice_AWREGION;
  wire [2:0]s02_couplers_to_s02_regslice_AWSIZE;
  wire s02_couplers_to_s02_regslice_AWVALID;
  wire [6:0]s02_couplers_to_s02_regslice_BID;
  wire s02_couplers_to_s02_regslice_BREADY;
  wire [1:0]s02_couplers_to_s02_regslice_BRESP;
  wire s02_couplers_to_s02_regslice_BVALID;
  wire [511:0]s02_couplers_to_s02_regslice_RDATA;
  wire [6:0]s02_couplers_to_s02_regslice_RID;
  wire s02_couplers_to_s02_regslice_RLAST;
  wire s02_couplers_to_s02_regslice_RREADY;
  wire [1:0]s02_couplers_to_s02_regslice_RRESP;
  wire s02_couplers_to_s02_regslice_RVALID;
  wire [511:0]s02_couplers_to_s02_regslice_WDATA;
  wire s02_couplers_to_s02_regslice_WLAST;
  wire s02_couplers_to_s02_regslice_WREADY;
  wire [63:0]s02_couplers_to_s02_regslice_WSTRB;
  wire s02_couplers_to_s02_regslice_WVALID;
  wire [63:0]s02_regslice_to_s02_couplers_ARADDR;
  wire [1:0]s02_regslice_to_s02_couplers_ARBURST;
  wire [3:0]s02_regslice_to_s02_couplers_ARCACHE;
  wire [6:0]s02_regslice_to_s02_couplers_ARID;
  wire [7:0]s02_regslice_to_s02_couplers_ARLEN;
  wire [0:0]s02_regslice_to_s02_couplers_ARLOCK;
  wire [2:0]s02_regslice_to_s02_couplers_ARPROT;
  wire [3:0]s02_regslice_to_s02_couplers_ARQOS;
  wire s02_regslice_to_s02_couplers_ARREADY;
  wire [2:0]s02_regslice_to_s02_couplers_ARSIZE;
  wire s02_regslice_to_s02_couplers_ARVALID;
  wire [63:0]s02_regslice_to_s02_couplers_AWADDR;
  wire [1:0]s02_regslice_to_s02_couplers_AWBURST;
  wire [3:0]s02_regslice_to_s02_couplers_AWCACHE;
  wire [6:0]s02_regslice_to_s02_couplers_AWID;
  wire [7:0]s02_regslice_to_s02_couplers_AWLEN;
  wire [0:0]s02_regslice_to_s02_couplers_AWLOCK;
  wire [2:0]s02_regslice_to_s02_couplers_AWPROT;
  wire [3:0]s02_regslice_to_s02_couplers_AWQOS;
  wire s02_regslice_to_s02_couplers_AWREADY;
  wire [2:0]s02_regslice_to_s02_couplers_AWSIZE;
  wire s02_regslice_to_s02_couplers_AWVALID;
  wire [8:0]s02_regslice_to_s02_couplers_BID;
  wire s02_regslice_to_s02_couplers_BREADY;
  wire [1:0]s02_regslice_to_s02_couplers_BRESP;
  wire s02_regslice_to_s02_couplers_BVALID;
  wire [511:0]s02_regslice_to_s02_couplers_RDATA;
  wire [8:0]s02_regslice_to_s02_couplers_RID;
  wire s02_regslice_to_s02_couplers_RLAST;
  wire s02_regslice_to_s02_couplers_RREADY;
  wire [1:0]s02_regslice_to_s02_couplers_RRESP;
  wire s02_regslice_to_s02_couplers_RVALID;
  wire [511:0]s02_regslice_to_s02_couplers_WDATA;
  wire s02_regslice_to_s02_couplers_WLAST;
  wire s02_regslice_to_s02_couplers_WREADY;
  wire [63:0]s02_regslice_to_s02_couplers_WSTRB;
  wire s02_regslice_to_s02_couplers_WVALID;

  assign M_AXI_araddr[63:0] = s02_regslice_to_s02_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s02_regslice_to_s02_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s02_regslice_to_s02_couplers_ARCACHE;
  assign M_AXI_arid[6:0] = s02_regslice_to_s02_couplers_ARID;
  assign M_AXI_arlen[7:0] = s02_regslice_to_s02_couplers_ARLEN;
  assign M_AXI_arlock[0] = s02_regslice_to_s02_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s02_regslice_to_s02_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s02_regslice_to_s02_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s02_regslice_to_s02_couplers_ARSIZE;
  assign M_AXI_arvalid = s02_regslice_to_s02_couplers_ARVALID;
  assign M_AXI_awaddr[63:0] = s02_regslice_to_s02_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s02_regslice_to_s02_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s02_regslice_to_s02_couplers_AWCACHE;
  assign M_AXI_awid[6:0] = s02_regslice_to_s02_couplers_AWID;
  assign M_AXI_awlen[7:0] = s02_regslice_to_s02_couplers_AWLEN;
  assign M_AXI_awlock[0] = s02_regslice_to_s02_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s02_regslice_to_s02_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s02_regslice_to_s02_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s02_regslice_to_s02_couplers_AWSIZE;
  assign M_AXI_awvalid = s02_regslice_to_s02_couplers_AWVALID;
  assign M_AXI_bready = s02_regslice_to_s02_couplers_BREADY;
  assign M_AXI_rready = s02_regslice_to_s02_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s02_regslice_to_s02_couplers_WDATA;
  assign M_AXI_wlast = s02_regslice_to_s02_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s02_regslice_to_s02_couplers_WSTRB;
  assign M_AXI_wvalid = s02_regslice_to_s02_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s02_couplers_to_s02_regslice_ARREADY;
  assign S_AXI_awready = s02_couplers_to_s02_regslice_AWREADY;
  assign S_AXI_bid[6:0] = s02_couplers_to_s02_regslice_BID;
  assign S_AXI_bresp[1:0] = s02_couplers_to_s02_regslice_BRESP;
  assign S_AXI_bvalid = s02_couplers_to_s02_regslice_BVALID;
  assign S_AXI_rdata[511:0] = s02_couplers_to_s02_regslice_RDATA;
  assign S_AXI_rid[6:0] = s02_couplers_to_s02_regslice_RID;
  assign S_AXI_rlast = s02_couplers_to_s02_regslice_RLAST;
  assign S_AXI_rresp[1:0] = s02_couplers_to_s02_regslice_RRESP;
  assign S_AXI_rvalid = s02_couplers_to_s02_regslice_RVALID;
  assign S_AXI_wready = s02_couplers_to_s02_regslice_WREADY;
  assign s02_couplers_to_s02_regslice_ARADDR = S_AXI_araddr[63:0];
  assign s02_couplers_to_s02_regslice_ARBURST = S_AXI_arburst[1:0];
  assign s02_couplers_to_s02_regslice_ARCACHE = S_AXI_arcache[3:0];
  assign s02_couplers_to_s02_regslice_ARID = S_AXI_arid[6:0];
  assign s02_couplers_to_s02_regslice_ARLEN = S_AXI_arlen[7:0];
  assign s02_couplers_to_s02_regslice_ARLOCK = S_AXI_arlock[0];
  assign s02_couplers_to_s02_regslice_ARPROT = S_AXI_arprot[2:0];
  assign s02_couplers_to_s02_regslice_ARQOS = S_AXI_arqos[3:0];
  assign s02_couplers_to_s02_regslice_ARREGION = S_AXI_arregion[3:0];
  assign s02_couplers_to_s02_regslice_ARSIZE = S_AXI_arsize[2:0];
  assign s02_couplers_to_s02_regslice_ARVALID = S_AXI_arvalid;
  assign s02_couplers_to_s02_regslice_AWADDR = S_AXI_awaddr[63:0];
  assign s02_couplers_to_s02_regslice_AWBURST = S_AXI_awburst[1:0];
  assign s02_couplers_to_s02_regslice_AWCACHE = S_AXI_awcache[3:0];
  assign s02_couplers_to_s02_regslice_AWID = S_AXI_awid[6:0];
  assign s02_couplers_to_s02_regslice_AWLEN = S_AXI_awlen[7:0];
  assign s02_couplers_to_s02_regslice_AWLOCK = S_AXI_awlock[0];
  assign s02_couplers_to_s02_regslice_AWPROT = S_AXI_awprot[2:0];
  assign s02_couplers_to_s02_regslice_AWQOS = S_AXI_awqos[3:0];
  assign s02_couplers_to_s02_regslice_AWREGION = S_AXI_awregion[3:0];
  assign s02_couplers_to_s02_regslice_AWSIZE = S_AXI_awsize[2:0];
  assign s02_couplers_to_s02_regslice_AWVALID = S_AXI_awvalid;
  assign s02_couplers_to_s02_regslice_BREADY = S_AXI_bready;
  assign s02_couplers_to_s02_regslice_RREADY = S_AXI_rready;
  assign s02_couplers_to_s02_regslice_WDATA = S_AXI_wdata[511:0];
  assign s02_couplers_to_s02_regslice_WLAST = S_AXI_wlast;
  assign s02_couplers_to_s02_regslice_WSTRB = S_AXI_wstrb[63:0];
  assign s02_couplers_to_s02_regslice_WVALID = S_AXI_wvalid;
  assign s02_regslice_to_s02_couplers_ARREADY = M_AXI_arready;
  assign s02_regslice_to_s02_couplers_AWREADY = M_AXI_awready;
  assign s02_regslice_to_s02_couplers_BID = M_AXI_bid[8:0];
  assign s02_regslice_to_s02_couplers_BRESP = M_AXI_bresp[1:0];
  assign s02_regslice_to_s02_couplers_BVALID = M_AXI_bvalid;
  assign s02_regslice_to_s02_couplers_RDATA = M_AXI_rdata[511:0];
  assign s02_regslice_to_s02_couplers_RID = M_AXI_rid[8:0];
  assign s02_regslice_to_s02_couplers_RLAST = M_AXI_rlast;
  assign s02_regslice_to_s02_couplers_RRESP = M_AXI_rresp[1:0];
  assign s02_regslice_to_s02_couplers_RVALID = M_AXI_rvalid;
  assign s02_regslice_to_s02_couplers_WREADY = M_AXI_wready;
  workgroup_read_interconnect_4_to_1_s02_regslice_0 s02_regslice
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(s02_regslice_to_s02_couplers_ARADDR),
        .m_axi_arburst(s02_regslice_to_s02_couplers_ARBURST),
        .m_axi_arcache(s02_regslice_to_s02_couplers_ARCACHE),
        .m_axi_arid(s02_regslice_to_s02_couplers_ARID),
        .m_axi_arlen(s02_regslice_to_s02_couplers_ARLEN),
        .m_axi_arlock(s02_regslice_to_s02_couplers_ARLOCK),
        .m_axi_arprot(s02_regslice_to_s02_couplers_ARPROT),
        .m_axi_arqos(s02_regslice_to_s02_couplers_ARQOS),
        .m_axi_arready(s02_regslice_to_s02_couplers_ARREADY),
        .m_axi_arsize(s02_regslice_to_s02_couplers_ARSIZE),
        .m_axi_arvalid(s02_regslice_to_s02_couplers_ARVALID),
        .m_axi_awaddr(s02_regslice_to_s02_couplers_AWADDR),
        .m_axi_awburst(s02_regslice_to_s02_couplers_AWBURST),
        .m_axi_awcache(s02_regslice_to_s02_couplers_AWCACHE),
        .m_axi_awid(s02_regslice_to_s02_couplers_AWID),
        .m_axi_awlen(s02_regslice_to_s02_couplers_AWLEN),
        .m_axi_awlock(s02_regslice_to_s02_couplers_AWLOCK),
        .m_axi_awprot(s02_regslice_to_s02_couplers_AWPROT),
        .m_axi_awqos(s02_regslice_to_s02_couplers_AWQOS),
        .m_axi_awready(s02_regslice_to_s02_couplers_AWREADY),
        .m_axi_awsize(s02_regslice_to_s02_couplers_AWSIZE),
        .m_axi_awvalid(s02_regslice_to_s02_couplers_AWVALID),
        .m_axi_bid(s02_regslice_to_s02_couplers_BID[6:0]),
        .m_axi_bready(s02_regslice_to_s02_couplers_BREADY),
        .m_axi_bresp(s02_regslice_to_s02_couplers_BRESP),
        .m_axi_bvalid(s02_regslice_to_s02_couplers_BVALID),
        .m_axi_rdata(s02_regslice_to_s02_couplers_RDATA),
        .m_axi_rid(s02_regslice_to_s02_couplers_RID[6:0]),
        .m_axi_rlast(s02_regslice_to_s02_couplers_RLAST),
        .m_axi_rready(s02_regslice_to_s02_couplers_RREADY),
        .m_axi_rresp(s02_regslice_to_s02_couplers_RRESP),
        .m_axi_rvalid(s02_regslice_to_s02_couplers_RVALID),
        .m_axi_wdata(s02_regslice_to_s02_couplers_WDATA),
        .m_axi_wlast(s02_regslice_to_s02_couplers_WLAST),
        .m_axi_wready(s02_regslice_to_s02_couplers_WREADY),
        .m_axi_wstrb(s02_regslice_to_s02_couplers_WSTRB),
        .m_axi_wvalid(s02_regslice_to_s02_couplers_WVALID),
        .s_axi_araddr(s02_couplers_to_s02_regslice_ARADDR),
        .s_axi_arburst(s02_couplers_to_s02_regslice_ARBURST),
        .s_axi_arcache(s02_couplers_to_s02_regslice_ARCACHE),
        .s_axi_arid(s02_couplers_to_s02_regslice_ARID),
        .s_axi_arlen(s02_couplers_to_s02_regslice_ARLEN),
        .s_axi_arlock(s02_couplers_to_s02_regslice_ARLOCK),
        .s_axi_arprot(s02_couplers_to_s02_regslice_ARPROT),
        .s_axi_arqos(s02_couplers_to_s02_regslice_ARQOS),
        .s_axi_arready(s02_couplers_to_s02_regslice_ARREADY),
        .s_axi_arregion(s02_couplers_to_s02_regslice_ARREGION),
        .s_axi_arsize(s02_couplers_to_s02_regslice_ARSIZE),
        .s_axi_arvalid(s02_couplers_to_s02_regslice_ARVALID),
        .s_axi_awaddr(s02_couplers_to_s02_regslice_AWADDR),
        .s_axi_awburst(s02_couplers_to_s02_regslice_AWBURST),
        .s_axi_awcache(s02_couplers_to_s02_regslice_AWCACHE),
        .s_axi_awid(s02_couplers_to_s02_regslice_AWID),
        .s_axi_awlen(s02_couplers_to_s02_regslice_AWLEN),
        .s_axi_awlock(s02_couplers_to_s02_regslice_AWLOCK),
        .s_axi_awprot(s02_couplers_to_s02_regslice_AWPROT),
        .s_axi_awqos(s02_couplers_to_s02_regslice_AWQOS),
        .s_axi_awready(s02_couplers_to_s02_regslice_AWREADY),
        .s_axi_awregion(s02_couplers_to_s02_regslice_AWREGION),
        .s_axi_awsize(s02_couplers_to_s02_regslice_AWSIZE),
        .s_axi_awvalid(s02_couplers_to_s02_regslice_AWVALID),
        .s_axi_bid(s02_couplers_to_s02_regslice_BID),
        .s_axi_bready(s02_couplers_to_s02_regslice_BREADY),
        .s_axi_bresp(s02_couplers_to_s02_regslice_BRESP),
        .s_axi_bvalid(s02_couplers_to_s02_regslice_BVALID),
        .s_axi_rdata(s02_couplers_to_s02_regslice_RDATA),
        .s_axi_rid(s02_couplers_to_s02_regslice_RID),
        .s_axi_rlast(s02_couplers_to_s02_regslice_RLAST),
        .s_axi_rready(s02_couplers_to_s02_regslice_RREADY),
        .s_axi_rresp(s02_couplers_to_s02_regslice_RRESP),
        .s_axi_rvalid(s02_couplers_to_s02_regslice_RVALID),
        .s_axi_wdata(s02_couplers_to_s02_regslice_WDATA),
        .s_axi_wlast(s02_couplers_to_s02_regslice_WLAST),
        .s_axi_wready(s02_couplers_to_s02_regslice_WREADY),
        .s_axi_wstrb(s02_couplers_to_s02_regslice_WSTRB),
        .s_axi_wvalid(s02_couplers_to_s02_regslice_WVALID));
endmodule

module s03_couplers_imp_FCKDRY
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [63:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [6:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [6:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [8:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [8:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [63:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [6:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [63:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [6:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [6:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [6:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [63:0]s03_couplers_to_s03_regslice_ARADDR;
  wire [1:0]s03_couplers_to_s03_regslice_ARBURST;
  wire [3:0]s03_couplers_to_s03_regslice_ARCACHE;
  wire [6:0]s03_couplers_to_s03_regslice_ARID;
  wire [7:0]s03_couplers_to_s03_regslice_ARLEN;
  wire [0:0]s03_couplers_to_s03_regslice_ARLOCK;
  wire [2:0]s03_couplers_to_s03_regslice_ARPROT;
  wire [3:0]s03_couplers_to_s03_regslice_ARQOS;
  wire s03_couplers_to_s03_regslice_ARREADY;
  wire [3:0]s03_couplers_to_s03_regslice_ARREGION;
  wire [2:0]s03_couplers_to_s03_regslice_ARSIZE;
  wire s03_couplers_to_s03_regslice_ARVALID;
  wire [63:0]s03_couplers_to_s03_regslice_AWADDR;
  wire [1:0]s03_couplers_to_s03_regslice_AWBURST;
  wire [3:0]s03_couplers_to_s03_regslice_AWCACHE;
  wire [6:0]s03_couplers_to_s03_regslice_AWID;
  wire [7:0]s03_couplers_to_s03_regslice_AWLEN;
  wire [0:0]s03_couplers_to_s03_regslice_AWLOCK;
  wire [2:0]s03_couplers_to_s03_regslice_AWPROT;
  wire [3:0]s03_couplers_to_s03_regslice_AWQOS;
  wire s03_couplers_to_s03_regslice_AWREADY;
  wire [3:0]s03_couplers_to_s03_regslice_AWREGION;
  wire [2:0]s03_couplers_to_s03_regslice_AWSIZE;
  wire s03_couplers_to_s03_regslice_AWVALID;
  wire [6:0]s03_couplers_to_s03_regslice_BID;
  wire s03_couplers_to_s03_regslice_BREADY;
  wire [1:0]s03_couplers_to_s03_regslice_BRESP;
  wire s03_couplers_to_s03_regslice_BVALID;
  wire [511:0]s03_couplers_to_s03_regslice_RDATA;
  wire [6:0]s03_couplers_to_s03_regslice_RID;
  wire s03_couplers_to_s03_regslice_RLAST;
  wire s03_couplers_to_s03_regslice_RREADY;
  wire [1:0]s03_couplers_to_s03_regslice_RRESP;
  wire s03_couplers_to_s03_regslice_RVALID;
  wire [511:0]s03_couplers_to_s03_regslice_WDATA;
  wire s03_couplers_to_s03_regslice_WLAST;
  wire s03_couplers_to_s03_regslice_WREADY;
  wire [63:0]s03_couplers_to_s03_regslice_WSTRB;
  wire s03_couplers_to_s03_regslice_WVALID;
  wire [63:0]s03_regslice_to_s03_couplers_ARADDR;
  wire [1:0]s03_regslice_to_s03_couplers_ARBURST;
  wire [3:0]s03_regslice_to_s03_couplers_ARCACHE;
  wire [6:0]s03_regslice_to_s03_couplers_ARID;
  wire [7:0]s03_regslice_to_s03_couplers_ARLEN;
  wire [0:0]s03_regslice_to_s03_couplers_ARLOCK;
  wire [2:0]s03_regslice_to_s03_couplers_ARPROT;
  wire [3:0]s03_regslice_to_s03_couplers_ARQOS;
  wire s03_regslice_to_s03_couplers_ARREADY;
  wire [2:0]s03_regslice_to_s03_couplers_ARSIZE;
  wire s03_regslice_to_s03_couplers_ARVALID;
  wire [63:0]s03_regslice_to_s03_couplers_AWADDR;
  wire [1:0]s03_regslice_to_s03_couplers_AWBURST;
  wire [3:0]s03_regslice_to_s03_couplers_AWCACHE;
  wire [6:0]s03_regslice_to_s03_couplers_AWID;
  wire [7:0]s03_regslice_to_s03_couplers_AWLEN;
  wire [0:0]s03_regslice_to_s03_couplers_AWLOCK;
  wire [2:0]s03_regslice_to_s03_couplers_AWPROT;
  wire [3:0]s03_regslice_to_s03_couplers_AWQOS;
  wire s03_regslice_to_s03_couplers_AWREADY;
  wire [2:0]s03_regslice_to_s03_couplers_AWSIZE;
  wire s03_regslice_to_s03_couplers_AWVALID;
  wire [8:0]s03_regslice_to_s03_couplers_BID;
  wire s03_regslice_to_s03_couplers_BREADY;
  wire [1:0]s03_regslice_to_s03_couplers_BRESP;
  wire s03_regslice_to_s03_couplers_BVALID;
  wire [511:0]s03_regslice_to_s03_couplers_RDATA;
  wire [8:0]s03_regslice_to_s03_couplers_RID;
  wire s03_regslice_to_s03_couplers_RLAST;
  wire s03_regslice_to_s03_couplers_RREADY;
  wire [1:0]s03_regslice_to_s03_couplers_RRESP;
  wire s03_regslice_to_s03_couplers_RVALID;
  wire [511:0]s03_regslice_to_s03_couplers_WDATA;
  wire s03_regslice_to_s03_couplers_WLAST;
  wire s03_regslice_to_s03_couplers_WREADY;
  wire [63:0]s03_regslice_to_s03_couplers_WSTRB;
  wire s03_regslice_to_s03_couplers_WVALID;

  assign M_AXI_araddr[63:0] = s03_regslice_to_s03_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s03_regslice_to_s03_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s03_regslice_to_s03_couplers_ARCACHE;
  assign M_AXI_arid[6:0] = s03_regslice_to_s03_couplers_ARID;
  assign M_AXI_arlen[7:0] = s03_regslice_to_s03_couplers_ARLEN;
  assign M_AXI_arlock[0] = s03_regslice_to_s03_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s03_regslice_to_s03_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s03_regslice_to_s03_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s03_regslice_to_s03_couplers_ARSIZE;
  assign M_AXI_arvalid = s03_regslice_to_s03_couplers_ARVALID;
  assign M_AXI_awaddr[63:0] = s03_regslice_to_s03_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s03_regslice_to_s03_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s03_regslice_to_s03_couplers_AWCACHE;
  assign M_AXI_awid[6:0] = s03_regslice_to_s03_couplers_AWID;
  assign M_AXI_awlen[7:0] = s03_regslice_to_s03_couplers_AWLEN;
  assign M_AXI_awlock[0] = s03_regslice_to_s03_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s03_regslice_to_s03_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s03_regslice_to_s03_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s03_regslice_to_s03_couplers_AWSIZE;
  assign M_AXI_awvalid = s03_regslice_to_s03_couplers_AWVALID;
  assign M_AXI_bready = s03_regslice_to_s03_couplers_BREADY;
  assign M_AXI_rready = s03_regslice_to_s03_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s03_regslice_to_s03_couplers_WDATA;
  assign M_AXI_wlast = s03_regslice_to_s03_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s03_regslice_to_s03_couplers_WSTRB;
  assign M_AXI_wvalid = s03_regslice_to_s03_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s03_couplers_to_s03_regslice_ARREADY;
  assign S_AXI_awready = s03_couplers_to_s03_regslice_AWREADY;
  assign S_AXI_bid[6:0] = s03_couplers_to_s03_regslice_BID;
  assign S_AXI_bresp[1:0] = s03_couplers_to_s03_regslice_BRESP;
  assign S_AXI_bvalid = s03_couplers_to_s03_regslice_BVALID;
  assign S_AXI_rdata[511:0] = s03_couplers_to_s03_regslice_RDATA;
  assign S_AXI_rid[6:0] = s03_couplers_to_s03_regslice_RID;
  assign S_AXI_rlast = s03_couplers_to_s03_regslice_RLAST;
  assign S_AXI_rresp[1:0] = s03_couplers_to_s03_regslice_RRESP;
  assign S_AXI_rvalid = s03_couplers_to_s03_regslice_RVALID;
  assign S_AXI_wready = s03_couplers_to_s03_regslice_WREADY;
  assign s03_couplers_to_s03_regslice_ARADDR = S_AXI_araddr[63:0];
  assign s03_couplers_to_s03_regslice_ARBURST = S_AXI_arburst[1:0];
  assign s03_couplers_to_s03_regslice_ARCACHE = S_AXI_arcache[3:0];
  assign s03_couplers_to_s03_regslice_ARID = S_AXI_arid[6:0];
  assign s03_couplers_to_s03_regslice_ARLEN = S_AXI_arlen[7:0];
  assign s03_couplers_to_s03_regslice_ARLOCK = S_AXI_arlock[0];
  assign s03_couplers_to_s03_regslice_ARPROT = S_AXI_arprot[2:0];
  assign s03_couplers_to_s03_regslice_ARQOS = S_AXI_arqos[3:0];
  assign s03_couplers_to_s03_regslice_ARREGION = S_AXI_arregion[3:0];
  assign s03_couplers_to_s03_regslice_ARSIZE = S_AXI_arsize[2:0];
  assign s03_couplers_to_s03_regslice_ARVALID = S_AXI_arvalid;
  assign s03_couplers_to_s03_regslice_AWADDR = S_AXI_awaddr[63:0];
  assign s03_couplers_to_s03_regslice_AWBURST = S_AXI_awburst[1:0];
  assign s03_couplers_to_s03_regslice_AWCACHE = S_AXI_awcache[3:0];
  assign s03_couplers_to_s03_regslice_AWID = S_AXI_awid[6:0];
  assign s03_couplers_to_s03_regslice_AWLEN = S_AXI_awlen[7:0];
  assign s03_couplers_to_s03_regslice_AWLOCK = S_AXI_awlock[0];
  assign s03_couplers_to_s03_regslice_AWPROT = S_AXI_awprot[2:0];
  assign s03_couplers_to_s03_regslice_AWQOS = S_AXI_awqos[3:0];
  assign s03_couplers_to_s03_regslice_AWREGION = S_AXI_awregion[3:0];
  assign s03_couplers_to_s03_regslice_AWSIZE = S_AXI_awsize[2:0];
  assign s03_couplers_to_s03_regslice_AWVALID = S_AXI_awvalid;
  assign s03_couplers_to_s03_regslice_BREADY = S_AXI_bready;
  assign s03_couplers_to_s03_regslice_RREADY = S_AXI_rready;
  assign s03_couplers_to_s03_regslice_WDATA = S_AXI_wdata[511:0];
  assign s03_couplers_to_s03_regslice_WLAST = S_AXI_wlast;
  assign s03_couplers_to_s03_regslice_WSTRB = S_AXI_wstrb[63:0];
  assign s03_couplers_to_s03_regslice_WVALID = S_AXI_wvalid;
  assign s03_regslice_to_s03_couplers_ARREADY = M_AXI_arready;
  assign s03_regslice_to_s03_couplers_AWREADY = M_AXI_awready;
  assign s03_regslice_to_s03_couplers_BID = M_AXI_bid[8:0];
  assign s03_regslice_to_s03_couplers_BRESP = M_AXI_bresp[1:0];
  assign s03_regslice_to_s03_couplers_BVALID = M_AXI_bvalid;
  assign s03_regslice_to_s03_couplers_RDATA = M_AXI_rdata[511:0];
  assign s03_regslice_to_s03_couplers_RID = M_AXI_rid[8:0];
  assign s03_regslice_to_s03_couplers_RLAST = M_AXI_rlast;
  assign s03_regslice_to_s03_couplers_RRESP = M_AXI_rresp[1:0];
  assign s03_regslice_to_s03_couplers_RVALID = M_AXI_rvalid;
  assign s03_regslice_to_s03_couplers_WREADY = M_AXI_wready;
  workgroup_read_interconnect_4_to_1_s03_regslice_0 s03_regslice
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(s03_regslice_to_s03_couplers_ARADDR),
        .m_axi_arburst(s03_regslice_to_s03_couplers_ARBURST),
        .m_axi_arcache(s03_regslice_to_s03_couplers_ARCACHE),
        .m_axi_arid(s03_regslice_to_s03_couplers_ARID),
        .m_axi_arlen(s03_regslice_to_s03_couplers_ARLEN),
        .m_axi_arlock(s03_regslice_to_s03_couplers_ARLOCK),
        .m_axi_arprot(s03_regslice_to_s03_couplers_ARPROT),
        .m_axi_arqos(s03_regslice_to_s03_couplers_ARQOS),
        .m_axi_arready(s03_regslice_to_s03_couplers_ARREADY),
        .m_axi_arsize(s03_regslice_to_s03_couplers_ARSIZE),
        .m_axi_arvalid(s03_regslice_to_s03_couplers_ARVALID),
        .m_axi_awaddr(s03_regslice_to_s03_couplers_AWADDR),
        .m_axi_awburst(s03_regslice_to_s03_couplers_AWBURST),
        .m_axi_awcache(s03_regslice_to_s03_couplers_AWCACHE),
        .m_axi_awid(s03_regslice_to_s03_couplers_AWID),
        .m_axi_awlen(s03_regslice_to_s03_couplers_AWLEN),
        .m_axi_awlock(s03_regslice_to_s03_couplers_AWLOCK),
        .m_axi_awprot(s03_regslice_to_s03_couplers_AWPROT),
        .m_axi_awqos(s03_regslice_to_s03_couplers_AWQOS),
        .m_axi_awready(s03_regslice_to_s03_couplers_AWREADY),
        .m_axi_awsize(s03_regslice_to_s03_couplers_AWSIZE),
        .m_axi_awvalid(s03_regslice_to_s03_couplers_AWVALID),
        .m_axi_bid(s03_regslice_to_s03_couplers_BID[6:0]),
        .m_axi_bready(s03_regslice_to_s03_couplers_BREADY),
        .m_axi_bresp(s03_regslice_to_s03_couplers_BRESP),
        .m_axi_bvalid(s03_regslice_to_s03_couplers_BVALID),
        .m_axi_rdata(s03_regslice_to_s03_couplers_RDATA),
        .m_axi_rid(s03_regslice_to_s03_couplers_RID[6:0]),
        .m_axi_rlast(s03_regslice_to_s03_couplers_RLAST),
        .m_axi_rready(s03_regslice_to_s03_couplers_RREADY),
        .m_axi_rresp(s03_regslice_to_s03_couplers_RRESP),
        .m_axi_rvalid(s03_regslice_to_s03_couplers_RVALID),
        .m_axi_wdata(s03_regslice_to_s03_couplers_WDATA),
        .m_axi_wlast(s03_regslice_to_s03_couplers_WLAST),
        .m_axi_wready(s03_regslice_to_s03_couplers_WREADY),
        .m_axi_wstrb(s03_regslice_to_s03_couplers_WSTRB),
        .m_axi_wvalid(s03_regslice_to_s03_couplers_WVALID),
        .s_axi_araddr(s03_couplers_to_s03_regslice_ARADDR),
        .s_axi_arburst(s03_couplers_to_s03_regslice_ARBURST),
        .s_axi_arcache(s03_couplers_to_s03_regslice_ARCACHE),
        .s_axi_arid(s03_couplers_to_s03_regslice_ARID),
        .s_axi_arlen(s03_couplers_to_s03_regslice_ARLEN),
        .s_axi_arlock(s03_couplers_to_s03_regslice_ARLOCK),
        .s_axi_arprot(s03_couplers_to_s03_regslice_ARPROT),
        .s_axi_arqos(s03_couplers_to_s03_regslice_ARQOS),
        .s_axi_arready(s03_couplers_to_s03_regslice_ARREADY),
        .s_axi_arregion(s03_couplers_to_s03_regslice_ARREGION),
        .s_axi_arsize(s03_couplers_to_s03_regslice_ARSIZE),
        .s_axi_arvalid(s03_couplers_to_s03_regslice_ARVALID),
        .s_axi_awaddr(s03_couplers_to_s03_regslice_AWADDR),
        .s_axi_awburst(s03_couplers_to_s03_regslice_AWBURST),
        .s_axi_awcache(s03_couplers_to_s03_regslice_AWCACHE),
        .s_axi_awid(s03_couplers_to_s03_regslice_AWID),
        .s_axi_awlen(s03_couplers_to_s03_regslice_AWLEN),
        .s_axi_awlock(s03_couplers_to_s03_regslice_AWLOCK),
        .s_axi_awprot(s03_couplers_to_s03_regslice_AWPROT),
        .s_axi_awqos(s03_couplers_to_s03_regslice_AWQOS),
        .s_axi_awready(s03_couplers_to_s03_regslice_AWREADY),
        .s_axi_awregion(s03_couplers_to_s03_regslice_AWREGION),
        .s_axi_awsize(s03_couplers_to_s03_regslice_AWSIZE),
        .s_axi_awvalid(s03_couplers_to_s03_regslice_AWVALID),
        .s_axi_bid(s03_couplers_to_s03_regslice_BID),
        .s_axi_bready(s03_couplers_to_s03_regslice_BREADY),
        .s_axi_bresp(s03_couplers_to_s03_regslice_BRESP),
        .s_axi_bvalid(s03_couplers_to_s03_regslice_BVALID),
        .s_axi_rdata(s03_couplers_to_s03_regslice_RDATA),
        .s_axi_rid(s03_couplers_to_s03_regslice_RID),
        .s_axi_rlast(s03_couplers_to_s03_regslice_RLAST),
        .s_axi_rready(s03_couplers_to_s03_regslice_RREADY),
        .s_axi_rresp(s03_couplers_to_s03_regslice_RRESP),
        .s_axi_rvalid(s03_couplers_to_s03_regslice_RVALID),
        .s_axi_wdata(s03_couplers_to_s03_regslice_WDATA),
        .s_axi_wlast(s03_couplers_to_s03_regslice_WLAST),
        .s_axi_wready(s03_couplers_to_s03_regslice_WREADY),
        .s_axi_wstrb(s03_couplers_to_s03_regslice_WSTRB),
        .s_axi_wvalid(s03_couplers_to_s03_regslice_WVALID));
endmodule

(* CORE_GENERATION_INFO = "workgroup_read_interconnect_4_to_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=workgroup_read_interconnect_4_to_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=12,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=6,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "workgroup_read_interconnect_4_to_1.hwdef" *) 
module workgroup_read_interconnect_4_to_1
   (ACLK,
    ARESETN,
    M00_AXI_araddr,
    M00_AXI_arburst,
    M00_AXI_arcache,
    M00_AXI_arid,
    M00_AXI_arlen,
    M00_AXI_arlock,
    M00_AXI_arprot,
    M00_AXI_arqos,
    M00_AXI_arready,
    M00_AXI_arregion,
    M00_AXI_arsize,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awburst,
    M00_AXI_awcache,
    M00_AXI_awid,
    M00_AXI_awlen,
    M00_AXI_awlock,
    M00_AXI_awprot,
    M00_AXI_awqos,
    M00_AXI_awready,
    M00_AXI_awregion,
    M00_AXI_awsize,
    M00_AXI_awvalid,
    M00_AXI_bid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rid,
    M00_AXI_rlast,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wlast,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arregion,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awregion,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    S01_AXI_araddr,
    S01_AXI_arburst,
    S01_AXI_arcache,
    S01_AXI_arid,
    S01_AXI_arlen,
    S01_AXI_arlock,
    S01_AXI_arprot,
    S01_AXI_arqos,
    S01_AXI_arready,
    S01_AXI_arregion,
    S01_AXI_arsize,
    S01_AXI_arvalid,
    S01_AXI_awaddr,
    S01_AXI_awburst,
    S01_AXI_awcache,
    S01_AXI_awid,
    S01_AXI_awlen,
    S01_AXI_awlock,
    S01_AXI_awprot,
    S01_AXI_awqos,
    S01_AXI_awready,
    S01_AXI_awregion,
    S01_AXI_awsize,
    S01_AXI_awvalid,
    S01_AXI_bid,
    S01_AXI_bready,
    S01_AXI_bresp,
    S01_AXI_bvalid,
    S01_AXI_rdata,
    S01_AXI_rid,
    S01_AXI_rlast,
    S01_AXI_rready,
    S01_AXI_rresp,
    S01_AXI_rvalid,
    S01_AXI_wdata,
    S01_AXI_wlast,
    S01_AXI_wready,
    S01_AXI_wstrb,
    S01_AXI_wvalid,
    S02_AXI_araddr,
    S02_AXI_arburst,
    S02_AXI_arcache,
    S02_AXI_arid,
    S02_AXI_arlen,
    S02_AXI_arlock,
    S02_AXI_arprot,
    S02_AXI_arqos,
    S02_AXI_arready,
    S02_AXI_arregion,
    S02_AXI_arsize,
    S02_AXI_arvalid,
    S02_AXI_awaddr,
    S02_AXI_awburst,
    S02_AXI_awcache,
    S02_AXI_awid,
    S02_AXI_awlen,
    S02_AXI_awlock,
    S02_AXI_awprot,
    S02_AXI_awqos,
    S02_AXI_awready,
    S02_AXI_awregion,
    S02_AXI_awsize,
    S02_AXI_awvalid,
    S02_AXI_bid,
    S02_AXI_bready,
    S02_AXI_bresp,
    S02_AXI_bvalid,
    S02_AXI_rdata,
    S02_AXI_rid,
    S02_AXI_rlast,
    S02_AXI_rready,
    S02_AXI_rresp,
    S02_AXI_rvalid,
    S02_AXI_wdata,
    S02_AXI_wlast,
    S02_AXI_wready,
    S02_AXI_wstrb,
    S02_AXI_wvalid,
    S03_AXI_araddr,
    S03_AXI_arburst,
    S03_AXI_arcache,
    S03_AXI_arid,
    S03_AXI_arlen,
    S03_AXI_arlock,
    S03_AXI_arprot,
    S03_AXI_arqos,
    S03_AXI_arready,
    S03_AXI_arregion,
    S03_AXI_arsize,
    S03_AXI_arvalid,
    S03_AXI_awaddr,
    S03_AXI_awburst,
    S03_AXI_awcache,
    S03_AXI_awid,
    S03_AXI_awlen,
    S03_AXI_awlock,
    S03_AXI_awprot,
    S03_AXI_awqos,
    S03_AXI_awready,
    S03_AXI_awregion,
    S03_AXI_awsize,
    S03_AXI_awvalid,
    S03_AXI_bid,
    S03_AXI_bready,
    S03_AXI_bresp,
    S03_AXI_bvalid,
    S03_AXI_rdata,
    S03_AXI_rid,
    S03_AXI_rlast,
    S03_AXI_rready,
    S03_AXI_rresp,
    S03_AXI_rvalid,
    S03_AXI_wdata,
    S03_AXI_wlast,
    S03_AXI_wready,
    S03_AXI_wstrb,
    S03_AXI_wvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF S00_AXI:M00_AXI:S01_AXI:S02_AXI:S03_AXI, ASSOCIATED_RESET ARESETN, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, FREQ_HZ 10000000, INSERT_VIP 0, PHASE 0.000" *) input ACLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input ARESETN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXI, ADDR_WIDTH 64, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, DATA_WIDTH 512, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 1, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 9, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 16, NUM_WRITE_THREADS 1, PHASE 0.000, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) output [63:0]M00_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [1:0]M00_AXI_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI ARID" *) output [8:0]M00_AXI_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [7:0]M00_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [0:0]M00_AXI_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [2:0]M00_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [2:0]M00_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [63:0]M00_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [1:0]M00_AXI_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI AWID" *) output [8:0]M00_AXI_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [7:0]M00_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [0:0]M00_AXI_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [2:0]M00_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [3:0]M00_AXI_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [2:0]M00_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI BID" *) input [8:0]M00_AXI_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input [1:0]M00_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input [511:0]M00_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI RID" *) input [8:0]M00_AXI_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input [1:0]M00_AXI_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [511:0]M00_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) input M00_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output [63:0]M00_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M00_AXI " *) output M00_AXI_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI, ADDR_WIDTH 64, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, DATA_WIDTH 512, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 1, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 7, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 32, NUM_READ_THREADS 16, NUM_WRITE_OUTSTANDING 32, NUM_WRITE_THREADS 16, PHASE 0.000, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [63:0]S00_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [1:0]S00_AXI_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [3:0]S00_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARID" *) input [6:0]S00_AXI_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [7:0]S00_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [0:0]S00_AXI_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [2:0]S00_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [3:0]S00_AXI_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREGION" *) input [3:0]S00_AXI_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [2:0]S00_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [63:0]S00_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [1:0]S00_AXI_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [3:0]S00_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWID" *) input [6:0]S00_AXI_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [7:0]S00_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [0:0]S00_AXI_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [2:0]S00_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [3:0]S00_AXI_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREGION" *) input [3:0]S00_AXI_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [2:0]S00_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BID" *) output [6:0]S00_AXI_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output [1:0]S00_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output [511:0]S00_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RID" *) output [6:0]S00_AXI_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output [1:0]S00_AXI_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [511:0]S00_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) output S00_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input [63:0]S00_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI " *) input S00_AXI_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXI, ADDR_WIDTH 64, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, DATA_WIDTH 512, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 1, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 7, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 32, NUM_READ_THREADS 16, NUM_WRITE_OUTSTANDING 32, NUM_WRITE_THREADS 16, PHASE 0.000, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [63:0]S01_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [1:0]S01_AXI_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARID" *) input [6:0]S01_AXI_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [7:0]S01_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [0:0]S01_AXI_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [2:0]S01_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [2:0]S01_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [63:0]S01_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [1:0]S01_AXI_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWID" *) input [6:0]S01_AXI_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [7:0]S01_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [0:0]S01_AXI_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [2:0]S01_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [3:0]S01_AXI_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [2:0]S01_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BID" *) output [6:0]S01_AXI_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output [1:0]S01_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output [511:0]S01_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RID" *) output [6:0]S01_AXI_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output [1:0]S01_AXI_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [511:0]S01_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) output S01_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input [63:0]S01_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI " *) input S01_AXI_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S02_AXI, ADDR_WIDTH 64, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, DATA_WIDTH 512, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 1, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 7, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 32, NUM_READ_THREADS 16, NUM_WRITE_OUTSTANDING 32, NUM_WRITE_THREADS 16, PHASE 0.000, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [63:0]S02_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [1:0]S02_AXI_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI ARID" *) input [6:0]S02_AXI_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [7:0]S02_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [0:0]S02_AXI_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [2:0]S02_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [2:0]S02_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [63:0]S02_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [1:0]S02_AXI_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI AWID" *) input [6:0]S02_AXI_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [7:0]S02_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [0:0]S02_AXI_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [2:0]S02_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [3:0]S02_AXI_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [2:0]S02_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI BID" *) output [6:0]S02_AXI_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output [1:0]S02_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output [511:0]S02_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI RID" *) output [6:0]S02_AXI_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output [1:0]S02_AXI_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [511:0]S02_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) output S02_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input [63:0]S02_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S02_AXI " *) input S02_AXI_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S03_AXI, ADDR_WIDTH 64, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN workgroup_read_interconnect_4_to_1_ACLK_0, DATA_WIDTH 512, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 1, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 7, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 32, NUM_READ_THREADS 16, NUM_WRITE_OUTSTANDING 32, NUM_WRITE_THREADS 16, PHASE 0.000, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [63:0]S03_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [1:0]S03_AXI_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI ARID" *) input [6:0]S03_AXI_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [7:0]S03_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [0:0]S03_AXI_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [2:0]S03_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [2:0]S03_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [63:0]S03_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [1:0]S03_AXI_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI AWID" *) input [6:0]S03_AXI_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [7:0]S03_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [0:0]S03_AXI_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [2:0]S03_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [3:0]S03_AXI_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [2:0]S03_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI BID" *) output [6:0]S03_AXI_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output [1:0]S03_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output [511:0]S03_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI RID" *) output [6:0]S03_AXI_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output [1:0]S03_AXI_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [511:0]S03_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) output S03_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input [63:0]S03_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S03_AXI " *) input S03_AXI_wvalid;

  wire ACLK_0_1;
  wire ARESETN_0_1;
  wire [63:0]S00_AXI_0_1_ARADDR;
  wire [1:0]S00_AXI_0_1_ARBURST;
  wire [3:0]S00_AXI_0_1_ARCACHE;
  wire [6:0]S00_AXI_0_1_ARID;
  wire [7:0]S00_AXI_0_1_ARLEN;
  wire [0:0]S00_AXI_0_1_ARLOCK;
  wire [2:0]S00_AXI_0_1_ARPROT;
  wire [3:0]S00_AXI_0_1_ARQOS;
  wire S00_AXI_0_1_ARREADY;
  wire [3:0]S00_AXI_0_1_ARREGION;
  wire [2:0]S00_AXI_0_1_ARSIZE;
  wire S00_AXI_0_1_ARVALID;
  wire [63:0]S00_AXI_0_1_AWADDR;
  wire [1:0]S00_AXI_0_1_AWBURST;
  wire [3:0]S00_AXI_0_1_AWCACHE;
  wire [6:0]S00_AXI_0_1_AWID;
  wire [7:0]S00_AXI_0_1_AWLEN;
  wire [0:0]S00_AXI_0_1_AWLOCK;
  wire [2:0]S00_AXI_0_1_AWPROT;
  wire [3:0]S00_AXI_0_1_AWQOS;
  wire S00_AXI_0_1_AWREADY;
  wire [3:0]S00_AXI_0_1_AWREGION;
  wire [2:0]S00_AXI_0_1_AWSIZE;
  wire S00_AXI_0_1_AWVALID;
  wire [6:0]S00_AXI_0_1_BID;
  wire S00_AXI_0_1_BREADY;
  wire [1:0]S00_AXI_0_1_BRESP;
  wire S00_AXI_0_1_BVALID;
  wire [511:0]S00_AXI_0_1_RDATA;
  wire [6:0]S00_AXI_0_1_RID;
  wire S00_AXI_0_1_RLAST;
  wire S00_AXI_0_1_RREADY;
  wire [1:0]S00_AXI_0_1_RRESP;
  wire S00_AXI_0_1_RVALID;
  wire [511:0]S00_AXI_0_1_WDATA;
  wire S00_AXI_0_1_WLAST;
  wire S00_AXI_0_1_WREADY;
  wire [63:0]S00_AXI_0_1_WSTRB;
  wire S00_AXI_0_1_WVALID;
  wire [63:0]S01_AXI_0_1_ARADDR;
  wire [1:0]S01_AXI_0_1_ARBURST;
  wire [3:0]S01_AXI_0_1_ARCACHE;
  wire [6:0]S01_AXI_0_1_ARID;
  wire [7:0]S01_AXI_0_1_ARLEN;
  wire [0:0]S01_AXI_0_1_ARLOCK;
  wire [2:0]S01_AXI_0_1_ARPROT;
  wire [3:0]S01_AXI_0_1_ARQOS;
  wire S01_AXI_0_1_ARREADY;
  wire [3:0]S01_AXI_0_1_ARREGION;
  wire [2:0]S01_AXI_0_1_ARSIZE;
  wire S01_AXI_0_1_ARVALID;
  wire [63:0]S01_AXI_0_1_AWADDR;
  wire [1:0]S01_AXI_0_1_AWBURST;
  wire [3:0]S01_AXI_0_1_AWCACHE;
  wire [6:0]S01_AXI_0_1_AWID;
  wire [7:0]S01_AXI_0_1_AWLEN;
  wire [0:0]S01_AXI_0_1_AWLOCK;
  wire [2:0]S01_AXI_0_1_AWPROT;
  wire [3:0]S01_AXI_0_1_AWQOS;
  wire S01_AXI_0_1_AWREADY;
  wire [3:0]S01_AXI_0_1_AWREGION;
  wire [2:0]S01_AXI_0_1_AWSIZE;
  wire S01_AXI_0_1_AWVALID;
  wire [6:0]S01_AXI_0_1_BID;
  wire S01_AXI_0_1_BREADY;
  wire [1:0]S01_AXI_0_1_BRESP;
  wire S01_AXI_0_1_BVALID;
  wire [511:0]S01_AXI_0_1_RDATA;
  wire [6:0]S01_AXI_0_1_RID;
  wire S01_AXI_0_1_RLAST;
  wire S01_AXI_0_1_RREADY;
  wire [1:0]S01_AXI_0_1_RRESP;
  wire S01_AXI_0_1_RVALID;
  wire [511:0]S01_AXI_0_1_WDATA;
  wire S01_AXI_0_1_WLAST;
  wire S01_AXI_0_1_WREADY;
  wire [63:0]S01_AXI_0_1_WSTRB;
  wire S01_AXI_0_1_WVALID;
  wire [63:0]S02_AXI_0_1_ARADDR;
  wire [1:0]S02_AXI_0_1_ARBURST;
  wire [3:0]S02_AXI_0_1_ARCACHE;
  wire [6:0]S02_AXI_0_1_ARID;
  wire [7:0]S02_AXI_0_1_ARLEN;
  wire [0:0]S02_AXI_0_1_ARLOCK;
  wire [2:0]S02_AXI_0_1_ARPROT;
  wire [3:0]S02_AXI_0_1_ARQOS;
  wire S02_AXI_0_1_ARREADY;
  wire [3:0]S02_AXI_0_1_ARREGION;
  wire [2:0]S02_AXI_0_1_ARSIZE;
  wire S02_AXI_0_1_ARVALID;
  wire [63:0]S02_AXI_0_1_AWADDR;
  wire [1:0]S02_AXI_0_1_AWBURST;
  wire [3:0]S02_AXI_0_1_AWCACHE;
  wire [6:0]S02_AXI_0_1_AWID;
  wire [7:0]S02_AXI_0_1_AWLEN;
  wire [0:0]S02_AXI_0_1_AWLOCK;
  wire [2:0]S02_AXI_0_1_AWPROT;
  wire [3:0]S02_AXI_0_1_AWQOS;
  wire S02_AXI_0_1_AWREADY;
  wire [3:0]S02_AXI_0_1_AWREGION;
  wire [2:0]S02_AXI_0_1_AWSIZE;
  wire S02_AXI_0_1_AWVALID;
  wire [6:0]S02_AXI_0_1_BID;
  wire S02_AXI_0_1_BREADY;
  wire [1:0]S02_AXI_0_1_BRESP;
  wire S02_AXI_0_1_BVALID;
  wire [511:0]S02_AXI_0_1_RDATA;
  wire [6:0]S02_AXI_0_1_RID;
  wire S02_AXI_0_1_RLAST;
  wire S02_AXI_0_1_RREADY;
  wire [1:0]S02_AXI_0_1_RRESP;
  wire S02_AXI_0_1_RVALID;
  wire [511:0]S02_AXI_0_1_WDATA;
  wire S02_AXI_0_1_WLAST;
  wire S02_AXI_0_1_WREADY;
  wire [63:0]S02_AXI_0_1_WSTRB;
  wire S02_AXI_0_1_WVALID;
  wire [63:0]S03_AXI_0_1_ARADDR;
  wire [1:0]S03_AXI_0_1_ARBURST;
  wire [3:0]S03_AXI_0_1_ARCACHE;
  wire [6:0]S03_AXI_0_1_ARID;
  wire [7:0]S03_AXI_0_1_ARLEN;
  wire [0:0]S03_AXI_0_1_ARLOCK;
  wire [2:0]S03_AXI_0_1_ARPROT;
  wire [3:0]S03_AXI_0_1_ARQOS;
  wire S03_AXI_0_1_ARREADY;
  wire [3:0]S03_AXI_0_1_ARREGION;
  wire [2:0]S03_AXI_0_1_ARSIZE;
  wire S03_AXI_0_1_ARVALID;
  wire [63:0]S03_AXI_0_1_AWADDR;
  wire [1:0]S03_AXI_0_1_AWBURST;
  wire [3:0]S03_AXI_0_1_AWCACHE;
  wire [6:0]S03_AXI_0_1_AWID;
  wire [7:0]S03_AXI_0_1_AWLEN;
  wire [0:0]S03_AXI_0_1_AWLOCK;
  wire [2:0]S03_AXI_0_1_AWPROT;
  wire [3:0]S03_AXI_0_1_AWQOS;
  wire S03_AXI_0_1_AWREADY;
  wire [3:0]S03_AXI_0_1_AWREGION;
  wire [2:0]S03_AXI_0_1_AWSIZE;
  wire S03_AXI_0_1_AWVALID;
  wire [6:0]S03_AXI_0_1_BID;
  wire S03_AXI_0_1_BREADY;
  wire [1:0]S03_AXI_0_1_BRESP;
  wire S03_AXI_0_1_BVALID;
  wire [511:0]S03_AXI_0_1_RDATA;
  wire [6:0]S03_AXI_0_1_RID;
  wire S03_AXI_0_1_RLAST;
  wire S03_AXI_0_1_RREADY;
  wire [1:0]S03_AXI_0_1_RRESP;
  wire S03_AXI_0_1_RVALID;
  wire [511:0]S03_AXI_0_1_WDATA;
  wire S03_AXI_0_1_WLAST;
  wire S03_AXI_0_1_WREADY;
  wire [63:0]S03_AXI_0_1_WSTRB;
  wire S03_AXI_0_1_WVALID;
  wire [63:0]axi_interconnect_M00_AXI_ARADDR;
  wire [1:0]axi_interconnect_M00_AXI_ARBURST;
  wire [3:0]axi_interconnect_M00_AXI_ARCACHE;
  wire [8:0]axi_interconnect_M00_AXI_ARID;
  wire [7:0]axi_interconnect_M00_AXI_ARLEN;
  wire [0:0]axi_interconnect_M00_AXI_ARLOCK;
  wire [2:0]axi_interconnect_M00_AXI_ARPROT;
  wire [3:0]axi_interconnect_M00_AXI_ARQOS;
  wire axi_interconnect_M00_AXI_ARREADY;
  wire [3:0]axi_interconnect_M00_AXI_ARREGION;
  wire [2:0]axi_interconnect_M00_AXI_ARSIZE;
  wire axi_interconnect_M00_AXI_ARVALID;
  wire [63:0]axi_interconnect_M00_AXI_AWADDR;
  wire [1:0]axi_interconnect_M00_AXI_AWBURST;
  wire [3:0]axi_interconnect_M00_AXI_AWCACHE;
  wire [8:0]axi_interconnect_M00_AXI_AWID;
  wire [7:0]axi_interconnect_M00_AXI_AWLEN;
  wire [0:0]axi_interconnect_M00_AXI_AWLOCK;
  wire [2:0]axi_interconnect_M00_AXI_AWPROT;
  wire [3:0]axi_interconnect_M00_AXI_AWQOS;
  wire axi_interconnect_M00_AXI_AWREADY;
  wire [3:0]axi_interconnect_M00_AXI_AWREGION;
  wire [2:0]axi_interconnect_M00_AXI_AWSIZE;
  wire axi_interconnect_M00_AXI_AWVALID;
  wire [8:0]axi_interconnect_M00_AXI_BID;
  wire axi_interconnect_M00_AXI_BREADY;
  wire [1:0]axi_interconnect_M00_AXI_BRESP;
  wire axi_interconnect_M00_AXI_BVALID;
  wire [511:0]axi_interconnect_M00_AXI_RDATA;
  wire [8:0]axi_interconnect_M00_AXI_RID;
  wire axi_interconnect_M00_AXI_RLAST;
  wire axi_interconnect_M00_AXI_RREADY;
  wire [1:0]axi_interconnect_M00_AXI_RRESP;
  wire axi_interconnect_M00_AXI_RVALID;
  wire [511:0]axi_interconnect_M00_AXI_WDATA;
  wire axi_interconnect_M00_AXI_WLAST;
  wire axi_interconnect_M00_AXI_WREADY;
  wire [63:0]axi_interconnect_M00_AXI_WSTRB;
  wire axi_interconnect_M00_AXI_WVALID;

  assign ACLK_0_1 = ACLK;
  assign ARESETN_0_1 = ARESETN;
  assign M00_AXI_araddr[63:0] = axi_interconnect_M00_AXI_ARADDR;
  assign M00_AXI_arburst[1:0] = axi_interconnect_M00_AXI_ARBURST;
  assign M00_AXI_arcache[3:0] = axi_interconnect_M00_AXI_ARCACHE;
  assign M00_AXI_arid[8:0] = axi_interconnect_M00_AXI_ARID;
  assign M00_AXI_arlen[7:0] = axi_interconnect_M00_AXI_ARLEN;
  assign M00_AXI_arlock[0] = axi_interconnect_M00_AXI_ARLOCK;
  assign M00_AXI_arprot[2:0] = axi_interconnect_M00_AXI_ARPROT;
  assign M00_AXI_arqos[3:0] = axi_interconnect_M00_AXI_ARQOS;
  assign M00_AXI_arregion[3:0] = axi_interconnect_M00_AXI_ARREGION;
  assign M00_AXI_arsize[2:0] = axi_interconnect_M00_AXI_ARSIZE;
  assign M00_AXI_arvalid = axi_interconnect_M00_AXI_ARVALID;
  assign M00_AXI_awaddr[63:0] = axi_interconnect_M00_AXI_AWADDR;
  assign M00_AXI_awburst[1:0] = axi_interconnect_M00_AXI_AWBURST;
  assign M00_AXI_awcache[3:0] = axi_interconnect_M00_AXI_AWCACHE;
  assign M00_AXI_awid[8:0] = axi_interconnect_M00_AXI_AWID;
  assign M00_AXI_awlen[7:0] = axi_interconnect_M00_AXI_AWLEN;
  assign M00_AXI_awlock[0] = axi_interconnect_M00_AXI_AWLOCK;
  assign M00_AXI_awprot[2:0] = axi_interconnect_M00_AXI_AWPROT;
  assign M00_AXI_awqos[3:0] = axi_interconnect_M00_AXI_AWQOS;
  assign M00_AXI_awregion[3:0] = axi_interconnect_M00_AXI_AWREGION;
  assign M00_AXI_awsize[2:0] = axi_interconnect_M00_AXI_AWSIZE;
  assign M00_AXI_awvalid = axi_interconnect_M00_AXI_AWVALID;
  assign M00_AXI_bready = axi_interconnect_M00_AXI_BREADY;
  assign M00_AXI_rready = axi_interconnect_M00_AXI_RREADY;
  assign M00_AXI_wdata[511:0] = axi_interconnect_M00_AXI_WDATA;
  assign M00_AXI_wlast = axi_interconnect_M00_AXI_WLAST;
  assign M00_AXI_wstrb[63:0] = axi_interconnect_M00_AXI_WSTRB;
  assign M00_AXI_wvalid = axi_interconnect_M00_AXI_WVALID;
  assign S00_AXI_0_1_ARADDR = S00_AXI_araddr[63:0];
  assign S00_AXI_0_1_ARBURST = S00_AXI_arburst[1:0];
  assign S00_AXI_0_1_ARCACHE = S00_AXI_arcache[3:0];
  assign S00_AXI_0_1_ARID = S00_AXI_arid[6:0];
  assign S00_AXI_0_1_ARLEN = S00_AXI_arlen[7:0];
  assign S00_AXI_0_1_ARLOCK = S00_AXI_arlock[0];
  assign S00_AXI_0_1_ARPROT = S00_AXI_arprot[2:0];
  assign S00_AXI_0_1_ARQOS = S00_AXI_arqos[3:0];
  assign S00_AXI_0_1_ARREGION = S00_AXI_arregion[3:0];
  assign S00_AXI_0_1_ARSIZE = S00_AXI_arsize[2:0];
  assign S00_AXI_0_1_ARVALID = S00_AXI_arvalid;
  assign S00_AXI_0_1_AWADDR = S00_AXI_awaddr[63:0];
  assign S00_AXI_0_1_AWBURST = S00_AXI_awburst[1:0];
  assign S00_AXI_0_1_AWCACHE = S00_AXI_awcache[3:0];
  assign S00_AXI_0_1_AWID = S00_AXI_awid[6:0];
  assign S00_AXI_0_1_AWLEN = S00_AXI_awlen[7:0];
  assign S00_AXI_0_1_AWLOCK = S00_AXI_awlock[0];
  assign S00_AXI_0_1_AWPROT = S00_AXI_awprot[2:0];
  assign S00_AXI_0_1_AWQOS = S00_AXI_awqos[3:0];
  assign S00_AXI_0_1_AWREGION = S00_AXI_awregion[3:0];
  assign S00_AXI_0_1_AWSIZE = S00_AXI_awsize[2:0];
  assign S00_AXI_0_1_AWVALID = S00_AXI_awvalid;
  assign S00_AXI_0_1_BREADY = S00_AXI_bready;
  assign S00_AXI_0_1_RREADY = S00_AXI_rready;
  assign S00_AXI_0_1_WDATA = S00_AXI_wdata[511:0];
  assign S00_AXI_0_1_WLAST = S00_AXI_wlast;
  assign S00_AXI_0_1_WSTRB = S00_AXI_wstrb[63:0];
  assign S00_AXI_0_1_WVALID = S00_AXI_wvalid;
  assign S00_AXI_arready = S00_AXI_0_1_ARREADY;
  assign S00_AXI_awready = S00_AXI_0_1_AWREADY;
  assign S00_AXI_bid[6:0] = S00_AXI_0_1_BID;
  assign S00_AXI_bresp[1:0] = S00_AXI_0_1_BRESP;
  assign S00_AXI_bvalid = S00_AXI_0_1_BVALID;
  assign S00_AXI_rdata[511:0] = S00_AXI_0_1_RDATA;
  assign S00_AXI_rid[6:0] = S00_AXI_0_1_RID;
  assign S00_AXI_rlast = S00_AXI_0_1_RLAST;
  assign S00_AXI_rresp[1:0] = S00_AXI_0_1_RRESP;
  assign S00_AXI_rvalid = S00_AXI_0_1_RVALID;
  assign S00_AXI_wready = S00_AXI_0_1_WREADY;
  assign S01_AXI_0_1_ARADDR = S01_AXI_araddr[63:0];
  assign S01_AXI_0_1_ARBURST = S01_AXI_arburst[1:0];
  assign S01_AXI_0_1_ARCACHE = S01_AXI_arcache[3:0];
  assign S01_AXI_0_1_ARID = S01_AXI_arid[6:0];
  assign S01_AXI_0_1_ARLEN = S01_AXI_arlen[7:0];
  assign S01_AXI_0_1_ARLOCK = S01_AXI_arlock[0];
  assign S01_AXI_0_1_ARPROT = S01_AXI_arprot[2:0];
  assign S01_AXI_0_1_ARQOS = S01_AXI_arqos[3:0];
  assign S01_AXI_0_1_ARREGION = S01_AXI_arregion[3:0];
  assign S01_AXI_0_1_ARSIZE = S01_AXI_arsize[2:0];
  assign S01_AXI_0_1_ARVALID = S01_AXI_arvalid;
  assign S01_AXI_0_1_AWADDR = S01_AXI_awaddr[63:0];
  assign S01_AXI_0_1_AWBURST = S01_AXI_awburst[1:0];
  assign S01_AXI_0_1_AWCACHE = S01_AXI_awcache[3:0];
  assign S01_AXI_0_1_AWID = S01_AXI_awid[6:0];
  assign S01_AXI_0_1_AWLEN = S01_AXI_awlen[7:0];
  assign S01_AXI_0_1_AWLOCK = S01_AXI_awlock[0];
  assign S01_AXI_0_1_AWPROT = S01_AXI_awprot[2:0];
  assign S01_AXI_0_1_AWQOS = S01_AXI_awqos[3:0];
  assign S01_AXI_0_1_AWREGION = S01_AXI_awregion[3:0];
  assign S01_AXI_0_1_AWSIZE = S01_AXI_awsize[2:0];
  assign S01_AXI_0_1_AWVALID = S01_AXI_awvalid;
  assign S01_AXI_0_1_BREADY = S01_AXI_bready;
  assign S01_AXI_0_1_RREADY = S01_AXI_rready;
  assign S01_AXI_0_1_WDATA = S01_AXI_wdata[511:0];
  assign S01_AXI_0_1_WLAST = S01_AXI_wlast;
  assign S01_AXI_0_1_WSTRB = S01_AXI_wstrb[63:0];
  assign S01_AXI_0_1_WVALID = S01_AXI_wvalid;
  assign S01_AXI_arready = S01_AXI_0_1_ARREADY;
  assign S01_AXI_awready = S01_AXI_0_1_AWREADY;
  assign S01_AXI_bid[6:0] = S01_AXI_0_1_BID;
  assign S01_AXI_bresp[1:0] = S01_AXI_0_1_BRESP;
  assign S01_AXI_bvalid = S01_AXI_0_1_BVALID;
  assign S01_AXI_rdata[511:0] = S01_AXI_0_1_RDATA;
  assign S01_AXI_rid[6:0] = S01_AXI_0_1_RID;
  assign S01_AXI_rlast = S01_AXI_0_1_RLAST;
  assign S01_AXI_rresp[1:0] = S01_AXI_0_1_RRESP;
  assign S01_AXI_rvalid = S01_AXI_0_1_RVALID;
  assign S01_AXI_wready = S01_AXI_0_1_WREADY;
  assign S02_AXI_0_1_ARADDR = S02_AXI_araddr[63:0];
  assign S02_AXI_0_1_ARBURST = S02_AXI_arburst[1:0];
  assign S02_AXI_0_1_ARCACHE = S02_AXI_arcache[3:0];
  assign S02_AXI_0_1_ARID = S02_AXI_arid[6:0];
  assign S02_AXI_0_1_ARLEN = S02_AXI_arlen[7:0];
  assign S02_AXI_0_1_ARLOCK = S02_AXI_arlock[0];
  assign S02_AXI_0_1_ARPROT = S02_AXI_arprot[2:0];
  assign S02_AXI_0_1_ARQOS = S02_AXI_arqos[3:0];
  assign S02_AXI_0_1_ARREGION = S02_AXI_arregion[3:0];
  assign S02_AXI_0_1_ARSIZE = S02_AXI_arsize[2:0];
  assign S02_AXI_0_1_ARVALID = S02_AXI_arvalid;
  assign S02_AXI_0_1_AWADDR = S02_AXI_awaddr[63:0];
  assign S02_AXI_0_1_AWBURST = S02_AXI_awburst[1:0];
  assign S02_AXI_0_1_AWCACHE = S02_AXI_awcache[3:0];
  assign S02_AXI_0_1_AWID = S02_AXI_awid[6:0];
  assign S02_AXI_0_1_AWLEN = S02_AXI_awlen[7:0];
  assign S02_AXI_0_1_AWLOCK = S02_AXI_awlock[0];
  assign S02_AXI_0_1_AWPROT = S02_AXI_awprot[2:0];
  assign S02_AXI_0_1_AWQOS = S02_AXI_awqos[3:0];
  assign S02_AXI_0_1_AWREGION = S02_AXI_awregion[3:0];
  assign S02_AXI_0_1_AWSIZE = S02_AXI_awsize[2:0];
  assign S02_AXI_0_1_AWVALID = S02_AXI_awvalid;
  assign S02_AXI_0_1_BREADY = S02_AXI_bready;
  assign S02_AXI_0_1_RREADY = S02_AXI_rready;
  assign S02_AXI_0_1_WDATA = S02_AXI_wdata[511:0];
  assign S02_AXI_0_1_WLAST = S02_AXI_wlast;
  assign S02_AXI_0_1_WSTRB = S02_AXI_wstrb[63:0];
  assign S02_AXI_0_1_WVALID = S02_AXI_wvalid;
  assign S02_AXI_arready = S02_AXI_0_1_ARREADY;
  assign S02_AXI_awready = S02_AXI_0_1_AWREADY;
  assign S02_AXI_bid[6:0] = S02_AXI_0_1_BID;
  assign S02_AXI_bresp[1:0] = S02_AXI_0_1_BRESP;
  assign S02_AXI_bvalid = S02_AXI_0_1_BVALID;
  assign S02_AXI_rdata[511:0] = S02_AXI_0_1_RDATA;
  assign S02_AXI_rid[6:0] = S02_AXI_0_1_RID;
  assign S02_AXI_rlast = S02_AXI_0_1_RLAST;
  assign S02_AXI_rresp[1:0] = S02_AXI_0_1_RRESP;
  assign S02_AXI_rvalid = S02_AXI_0_1_RVALID;
  assign S02_AXI_wready = S02_AXI_0_1_WREADY;
  assign S03_AXI_0_1_ARADDR = S03_AXI_araddr[63:0];
  assign S03_AXI_0_1_ARBURST = S03_AXI_arburst[1:0];
  assign S03_AXI_0_1_ARCACHE = S03_AXI_arcache[3:0];
  assign S03_AXI_0_1_ARID = S03_AXI_arid[6:0];
  assign S03_AXI_0_1_ARLEN = S03_AXI_arlen[7:0];
  assign S03_AXI_0_1_ARLOCK = S03_AXI_arlock[0];
  assign S03_AXI_0_1_ARPROT = S03_AXI_arprot[2:0];
  assign S03_AXI_0_1_ARQOS = S03_AXI_arqos[3:0];
  assign S03_AXI_0_1_ARREGION = S03_AXI_arregion[3:0];
  assign S03_AXI_0_1_ARSIZE = S03_AXI_arsize[2:0];
  assign S03_AXI_0_1_ARVALID = S03_AXI_arvalid;
  assign S03_AXI_0_1_AWADDR = S03_AXI_awaddr[63:0];
  assign S03_AXI_0_1_AWBURST = S03_AXI_awburst[1:0];
  assign S03_AXI_0_1_AWCACHE = S03_AXI_awcache[3:0];
  assign S03_AXI_0_1_AWID = S03_AXI_awid[6:0];
  assign S03_AXI_0_1_AWLEN = S03_AXI_awlen[7:0];
  assign S03_AXI_0_1_AWLOCK = S03_AXI_awlock[0];
  assign S03_AXI_0_1_AWPROT = S03_AXI_awprot[2:0];
  assign S03_AXI_0_1_AWQOS = S03_AXI_awqos[3:0];
  assign S03_AXI_0_1_AWREGION = S03_AXI_awregion[3:0];
  assign S03_AXI_0_1_AWSIZE = S03_AXI_awsize[2:0];
  assign S03_AXI_0_1_AWVALID = S03_AXI_awvalid;
  assign S03_AXI_0_1_BREADY = S03_AXI_bready;
  assign S03_AXI_0_1_RREADY = S03_AXI_rready;
  assign S03_AXI_0_1_WDATA = S03_AXI_wdata[511:0];
  assign S03_AXI_0_1_WLAST = S03_AXI_wlast;
  assign S03_AXI_0_1_WSTRB = S03_AXI_wstrb[63:0];
  assign S03_AXI_0_1_WVALID = S03_AXI_wvalid;
  assign S03_AXI_arready = S03_AXI_0_1_ARREADY;
  assign S03_AXI_awready = S03_AXI_0_1_AWREADY;
  assign S03_AXI_bid[6:0] = S03_AXI_0_1_BID;
  assign S03_AXI_bresp[1:0] = S03_AXI_0_1_BRESP;
  assign S03_AXI_bvalid = S03_AXI_0_1_BVALID;
  assign S03_AXI_rdata[511:0] = S03_AXI_0_1_RDATA;
  assign S03_AXI_rid[6:0] = S03_AXI_0_1_RID;
  assign S03_AXI_rlast = S03_AXI_0_1_RLAST;
  assign S03_AXI_rresp[1:0] = S03_AXI_0_1_RRESP;
  assign S03_AXI_rvalid = S03_AXI_0_1_RVALID;
  assign S03_AXI_wready = S03_AXI_0_1_WREADY;
  assign axi_interconnect_M00_AXI_ARREADY = M00_AXI_arready;
  assign axi_interconnect_M00_AXI_AWREADY = M00_AXI_awready;
  assign axi_interconnect_M00_AXI_BID = M00_AXI_bid[8:0];
  assign axi_interconnect_M00_AXI_BRESP = M00_AXI_bresp[1:0];
  assign axi_interconnect_M00_AXI_BVALID = M00_AXI_bvalid;
  assign axi_interconnect_M00_AXI_RDATA = M00_AXI_rdata[511:0];
  assign axi_interconnect_M00_AXI_RID = M00_AXI_rid[8:0];
  assign axi_interconnect_M00_AXI_RLAST = M00_AXI_rlast;
  assign axi_interconnect_M00_AXI_RRESP = M00_AXI_rresp[1:0];
  assign axi_interconnect_M00_AXI_RVALID = M00_AXI_rvalid;
  assign axi_interconnect_M00_AXI_WREADY = M00_AXI_wready;
  workgroup_read_interconnect_4_to_1_axi_interconnect_0_0 axi_interconnect
       (.ACLK(ACLK_0_1),
        .ARESETN(ARESETN_0_1),
        .M00_ACLK(ACLK_0_1),
        .M00_ARESETN(ARESETN_0_1),
        .M00_AXI_araddr(axi_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arburst(axi_interconnect_M00_AXI_ARBURST),
        .M00_AXI_arcache(axi_interconnect_M00_AXI_ARCACHE),
        .M00_AXI_arid(axi_interconnect_M00_AXI_ARID),
        .M00_AXI_arlen(axi_interconnect_M00_AXI_ARLEN),
        .M00_AXI_arlock(axi_interconnect_M00_AXI_ARLOCK),
        .M00_AXI_arprot(axi_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arqos(axi_interconnect_M00_AXI_ARQOS),
        .M00_AXI_arready(axi_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arregion(axi_interconnect_M00_AXI_ARREGION),
        .M00_AXI_arsize(axi_interconnect_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(axi_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awburst(axi_interconnect_M00_AXI_AWBURST),
        .M00_AXI_awcache(axi_interconnect_M00_AXI_AWCACHE),
        .M00_AXI_awid(axi_interconnect_M00_AXI_AWID),
        .M00_AXI_awlen(axi_interconnect_M00_AXI_AWLEN),
        .M00_AXI_awlock(axi_interconnect_M00_AXI_AWLOCK),
        .M00_AXI_awprot(axi_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awqos(axi_interconnect_M00_AXI_AWQOS),
        .M00_AXI_awready(axi_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awregion(axi_interconnect_M00_AXI_AWREGION),
        .M00_AXI_awsize(axi_interconnect_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(axi_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bid(axi_interconnect_M00_AXI_BID),
        .M00_AXI_bready(axi_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_interconnect_M00_AXI_RDATA),
        .M00_AXI_rid(axi_interconnect_M00_AXI_RID),
        .M00_AXI_rlast(axi_interconnect_M00_AXI_RLAST),
        .M00_AXI_rready(axi_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_interconnect_M00_AXI_WDATA),
        .M00_AXI_wlast(axi_interconnect_M00_AXI_WLAST),
        .M00_AXI_wready(axi_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_interconnect_M00_AXI_WVALID),
        .S00_ACLK(ACLK_0_1),
        .S00_ARESETN(ARESETN_0_1),
        .S00_AXI_araddr(S00_AXI_0_1_ARADDR),
        .S00_AXI_arburst(S00_AXI_0_1_ARBURST),
        .S00_AXI_arcache(S00_AXI_0_1_ARCACHE),
        .S00_AXI_arid(S00_AXI_0_1_ARID),
        .S00_AXI_arlen(S00_AXI_0_1_ARLEN),
        .S00_AXI_arlock(S00_AXI_0_1_ARLOCK),
        .S00_AXI_arprot(S00_AXI_0_1_ARPROT),
        .S00_AXI_arqos(S00_AXI_0_1_ARQOS),
        .S00_AXI_arready(S00_AXI_0_1_ARREADY),
        .S00_AXI_arregion(S00_AXI_0_1_ARREGION),
        .S00_AXI_arsize(S00_AXI_0_1_ARSIZE),
        .S00_AXI_arvalid(S00_AXI_0_1_ARVALID),
        .S00_AXI_awaddr(S00_AXI_0_1_AWADDR),
        .S00_AXI_awburst(S00_AXI_0_1_AWBURST),
        .S00_AXI_awcache(S00_AXI_0_1_AWCACHE),
        .S00_AXI_awid(S00_AXI_0_1_AWID),
        .S00_AXI_awlen(S00_AXI_0_1_AWLEN),
        .S00_AXI_awlock(S00_AXI_0_1_AWLOCK),
        .S00_AXI_awprot(S00_AXI_0_1_AWPROT),
        .S00_AXI_awqos(S00_AXI_0_1_AWQOS),
        .S00_AXI_awready(S00_AXI_0_1_AWREADY),
        .S00_AXI_awregion(S00_AXI_0_1_AWREGION),
        .S00_AXI_awsize(S00_AXI_0_1_AWSIZE),
        .S00_AXI_awvalid(S00_AXI_0_1_AWVALID),
        .S00_AXI_bid(S00_AXI_0_1_BID),
        .S00_AXI_bready(S00_AXI_0_1_BREADY),
        .S00_AXI_bresp(S00_AXI_0_1_BRESP),
        .S00_AXI_bvalid(S00_AXI_0_1_BVALID),
        .S00_AXI_rdata(S00_AXI_0_1_RDATA),
        .S00_AXI_rid(S00_AXI_0_1_RID),
        .S00_AXI_rlast(S00_AXI_0_1_RLAST),
        .S00_AXI_rready(S00_AXI_0_1_RREADY),
        .S00_AXI_rresp(S00_AXI_0_1_RRESP),
        .S00_AXI_rvalid(S00_AXI_0_1_RVALID),
        .S00_AXI_wdata(S00_AXI_0_1_WDATA),
        .S00_AXI_wlast(S00_AXI_0_1_WLAST),
        .S00_AXI_wready(S00_AXI_0_1_WREADY),
        .S00_AXI_wstrb(S00_AXI_0_1_WSTRB),
        .S00_AXI_wvalid(S00_AXI_0_1_WVALID),
        .S01_ACLK(ACLK_0_1),
        .S01_ARESETN(ARESETN_0_1),
        .S01_AXI_araddr(S01_AXI_0_1_ARADDR),
        .S01_AXI_arburst(S01_AXI_0_1_ARBURST),
        .S01_AXI_arcache(S01_AXI_0_1_ARCACHE),
        .S01_AXI_arid(S01_AXI_0_1_ARID),
        .S01_AXI_arlen(S01_AXI_0_1_ARLEN),
        .S01_AXI_arlock(S01_AXI_0_1_ARLOCK),
        .S01_AXI_arprot(S01_AXI_0_1_ARPROT),
        .S01_AXI_arqos(S01_AXI_0_1_ARQOS),
        .S01_AXI_arready(S01_AXI_0_1_ARREADY),
        .S01_AXI_arregion(S01_AXI_0_1_ARREGION),
        .S01_AXI_arsize(S01_AXI_0_1_ARSIZE),
        .S01_AXI_arvalid(S01_AXI_0_1_ARVALID),
        .S01_AXI_awaddr(S01_AXI_0_1_AWADDR),
        .S01_AXI_awburst(S01_AXI_0_1_AWBURST),
        .S01_AXI_awcache(S01_AXI_0_1_AWCACHE),
        .S01_AXI_awid(S01_AXI_0_1_AWID),
        .S01_AXI_awlen(S01_AXI_0_1_AWLEN),
        .S01_AXI_awlock(S01_AXI_0_1_AWLOCK),
        .S01_AXI_awprot(S01_AXI_0_1_AWPROT),
        .S01_AXI_awqos(S01_AXI_0_1_AWQOS),
        .S01_AXI_awready(S01_AXI_0_1_AWREADY),
        .S01_AXI_awregion(S01_AXI_0_1_AWREGION),
        .S01_AXI_awsize(S01_AXI_0_1_AWSIZE),
        .S01_AXI_awvalid(S01_AXI_0_1_AWVALID),
        .S01_AXI_bid(S01_AXI_0_1_BID),
        .S01_AXI_bready(S01_AXI_0_1_BREADY),
        .S01_AXI_bresp(S01_AXI_0_1_BRESP),
        .S01_AXI_bvalid(S01_AXI_0_1_BVALID),
        .S01_AXI_rdata(S01_AXI_0_1_RDATA),
        .S01_AXI_rid(S01_AXI_0_1_RID),
        .S01_AXI_rlast(S01_AXI_0_1_RLAST),
        .S01_AXI_rready(S01_AXI_0_1_RREADY),
        .S01_AXI_rresp(S01_AXI_0_1_RRESP),
        .S01_AXI_rvalid(S01_AXI_0_1_RVALID),
        .S01_AXI_wdata(S01_AXI_0_1_WDATA),
        .S01_AXI_wlast(S01_AXI_0_1_WLAST),
        .S01_AXI_wready(S01_AXI_0_1_WREADY),
        .S01_AXI_wstrb(S01_AXI_0_1_WSTRB),
        .S01_AXI_wvalid(S01_AXI_0_1_WVALID),
        .S02_ACLK(ACLK_0_1),
        .S02_ARESETN(ARESETN_0_1),
        .S02_AXI_araddr(S02_AXI_0_1_ARADDR),
        .S02_AXI_arburst(S02_AXI_0_1_ARBURST),
        .S02_AXI_arcache(S02_AXI_0_1_ARCACHE),
        .S02_AXI_arid(S02_AXI_0_1_ARID),
        .S02_AXI_arlen(S02_AXI_0_1_ARLEN),
        .S02_AXI_arlock(S02_AXI_0_1_ARLOCK),
        .S02_AXI_arprot(S02_AXI_0_1_ARPROT),
        .S02_AXI_arqos(S02_AXI_0_1_ARQOS),
        .S02_AXI_arready(S02_AXI_0_1_ARREADY),
        .S02_AXI_arregion(S02_AXI_0_1_ARREGION),
        .S02_AXI_arsize(S02_AXI_0_1_ARSIZE),
        .S02_AXI_arvalid(S02_AXI_0_1_ARVALID),
        .S02_AXI_awaddr(S02_AXI_0_1_AWADDR),
        .S02_AXI_awburst(S02_AXI_0_1_AWBURST),
        .S02_AXI_awcache(S02_AXI_0_1_AWCACHE),
        .S02_AXI_awid(S02_AXI_0_1_AWID),
        .S02_AXI_awlen(S02_AXI_0_1_AWLEN),
        .S02_AXI_awlock(S02_AXI_0_1_AWLOCK),
        .S02_AXI_awprot(S02_AXI_0_1_AWPROT),
        .S02_AXI_awqos(S02_AXI_0_1_AWQOS),
        .S02_AXI_awready(S02_AXI_0_1_AWREADY),
        .S02_AXI_awregion(S02_AXI_0_1_AWREGION),
        .S02_AXI_awsize(S02_AXI_0_1_AWSIZE),
        .S02_AXI_awvalid(S02_AXI_0_1_AWVALID),
        .S02_AXI_bid(S02_AXI_0_1_BID),
        .S02_AXI_bready(S02_AXI_0_1_BREADY),
        .S02_AXI_bresp(S02_AXI_0_1_BRESP),
        .S02_AXI_bvalid(S02_AXI_0_1_BVALID),
        .S02_AXI_rdata(S02_AXI_0_1_RDATA),
        .S02_AXI_rid(S02_AXI_0_1_RID),
        .S02_AXI_rlast(S02_AXI_0_1_RLAST),
        .S02_AXI_rready(S02_AXI_0_1_RREADY),
        .S02_AXI_rresp(S02_AXI_0_1_RRESP),
        .S02_AXI_rvalid(S02_AXI_0_1_RVALID),
        .S02_AXI_wdata(S02_AXI_0_1_WDATA),
        .S02_AXI_wlast(S02_AXI_0_1_WLAST),
        .S02_AXI_wready(S02_AXI_0_1_WREADY),
        .S02_AXI_wstrb(S02_AXI_0_1_WSTRB),
        .S02_AXI_wvalid(S02_AXI_0_1_WVALID),
        .S03_ACLK(ACLK_0_1),
        .S03_ARESETN(ARESETN_0_1),
        .S03_AXI_araddr(S03_AXI_0_1_ARADDR),
        .S03_AXI_arburst(S03_AXI_0_1_ARBURST),
        .S03_AXI_arcache(S03_AXI_0_1_ARCACHE),
        .S03_AXI_arid(S03_AXI_0_1_ARID),
        .S03_AXI_arlen(S03_AXI_0_1_ARLEN),
        .S03_AXI_arlock(S03_AXI_0_1_ARLOCK),
        .S03_AXI_arprot(S03_AXI_0_1_ARPROT),
        .S03_AXI_arqos(S03_AXI_0_1_ARQOS),
        .S03_AXI_arready(S03_AXI_0_1_ARREADY),
        .S03_AXI_arregion(S03_AXI_0_1_ARREGION),
        .S03_AXI_arsize(S03_AXI_0_1_ARSIZE),
        .S03_AXI_arvalid(S03_AXI_0_1_ARVALID),
        .S03_AXI_awaddr(S03_AXI_0_1_AWADDR),
        .S03_AXI_awburst(S03_AXI_0_1_AWBURST),
        .S03_AXI_awcache(S03_AXI_0_1_AWCACHE),
        .S03_AXI_awid(S03_AXI_0_1_AWID),
        .S03_AXI_awlen(S03_AXI_0_1_AWLEN),
        .S03_AXI_awlock(S03_AXI_0_1_AWLOCK),
        .S03_AXI_awprot(S03_AXI_0_1_AWPROT),
        .S03_AXI_awqos(S03_AXI_0_1_AWQOS),
        .S03_AXI_awready(S03_AXI_0_1_AWREADY),
        .S03_AXI_awregion(S03_AXI_0_1_AWREGION),
        .S03_AXI_awsize(S03_AXI_0_1_AWSIZE),
        .S03_AXI_awvalid(S03_AXI_0_1_AWVALID),
        .S03_AXI_bid(S03_AXI_0_1_BID),
        .S03_AXI_bready(S03_AXI_0_1_BREADY),
        .S03_AXI_bresp(S03_AXI_0_1_BRESP),
        .S03_AXI_bvalid(S03_AXI_0_1_BVALID),
        .S03_AXI_rdata(S03_AXI_0_1_RDATA),
        .S03_AXI_rid(S03_AXI_0_1_RID),
        .S03_AXI_rlast(S03_AXI_0_1_RLAST),
        .S03_AXI_rready(S03_AXI_0_1_RREADY),
        .S03_AXI_rresp(S03_AXI_0_1_RRESP),
        .S03_AXI_rvalid(S03_AXI_0_1_RVALID),
        .S03_AXI_wdata(S03_AXI_0_1_WDATA),
        .S03_AXI_wlast(S03_AXI_0_1_WLAST),
        .S03_AXI_wready(S03_AXI_0_1_WREADY),
        .S03_AXI_wstrb(S03_AXI_0_1_WSTRB),
        .S03_AXI_wvalid(S03_AXI_0_1_WVALID));
endmodule

module workgroup_read_interconnect_4_to_1_axi_interconnect_0_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arburst,
    M00_AXI_arcache,
    M00_AXI_arid,
    M00_AXI_arlen,
    M00_AXI_arlock,
    M00_AXI_arprot,
    M00_AXI_arqos,
    M00_AXI_arready,
    M00_AXI_arregion,
    M00_AXI_arsize,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awburst,
    M00_AXI_awcache,
    M00_AXI_awid,
    M00_AXI_awlen,
    M00_AXI_awlock,
    M00_AXI_awprot,
    M00_AXI_awqos,
    M00_AXI_awready,
    M00_AXI_awregion,
    M00_AXI_awsize,
    M00_AXI_awvalid,
    M00_AXI_bid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rid,
    M00_AXI_rlast,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wlast,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arregion,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awregion,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    S01_ACLK,
    S01_ARESETN,
    S01_AXI_araddr,
    S01_AXI_arburst,
    S01_AXI_arcache,
    S01_AXI_arid,
    S01_AXI_arlen,
    S01_AXI_arlock,
    S01_AXI_arprot,
    S01_AXI_arqos,
    S01_AXI_arready,
    S01_AXI_arregion,
    S01_AXI_arsize,
    S01_AXI_arvalid,
    S01_AXI_awaddr,
    S01_AXI_awburst,
    S01_AXI_awcache,
    S01_AXI_awid,
    S01_AXI_awlen,
    S01_AXI_awlock,
    S01_AXI_awprot,
    S01_AXI_awqos,
    S01_AXI_awready,
    S01_AXI_awregion,
    S01_AXI_awsize,
    S01_AXI_awvalid,
    S01_AXI_bid,
    S01_AXI_bready,
    S01_AXI_bresp,
    S01_AXI_bvalid,
    S01_AXI_rdata,
    S01_AXI_rid,
    S01_AXI_rlast,
    S01_AXI_rready,
    S01_AXI_rresp,
    S01_AXI_rvalid,
    S01_AXI_wdata,
    S01_AXI_wlast,
    S01_AXI_wready,
    S01_AXI_wstrb,
    S01_AXI_wvalid,
    S02_ACLK,
    S02_ARESETN,
    S02_AXI_araddr,
    S02_AXI_arburst,
    S02_AXI_arcache,
    S02_AXI_arid,
    S02_AXI_arlen,
    S02_AXI_arlock,
    S02_AXI_arprot,
    S02_AXI_arqos,
    S02_AXI_arready,
    S02_AXI_arregion,
    S02_AXI_arsize,
    S02_AXI_arvalid,
    S02_AXI_awaddr,
    S02_AXI_awburst,
    S02_AXI_awcache,
    S02_AXI_awid,
    S02_AXI_awlen,
    S02_AXI_awlock,
    S02_AXI_awprot,
    S02_AXI_awqos,
    S02_AXI_awready,
    S02_AXI_awregion,
    S02_AXI_awsize,
    S02_AXI_awvalid,
    S02_AXI_bid,
    S02_AXI_bready,
    S02_AXI_bresp,
    S02_AXI_bvalid,
    S02_AXI_rdata,
    S02_AXI_rid,
    S02_AXI_rlast,
    S02_AXI_rready,
    S02_AXI_rresp,
    S02_AXI_rvalid,
    S02_AXI_wdata,
    S02_AXI_wlast,
    S02_AXI_wready,
    S02_AXI_wstrb,
    S02_AXI_wvalid,
    S03_ACLK,
    S03_ARESETN,
    S03_AXI_araddr,
    S03_AXI_arburst,
    S03_AXI_arcache,
    S03_AXI_arid,
    S03_AXI_arlen,
    S03_AXI_arlock,
    S03_AXI_arprot,
    S03_AXI_arqos,
    S03_AXI_arready,
    S03_AXI_arregion,
    S03_AXI_arsize,
    S03_AXI_arvalid,
    S03_AXI_awaddr,
    S03_AXI_awburst,
    S03_AXI_awcache,
    S03_AXI_awid,
    S03_AXI_awlen,
    S03_AXI_awlock,
    S03_AXI_awprot,
    S03_AXI_awqos,
    S03_AXI_awready,
    S03_AXI_awregion,
    S03_AXI_awsize,
    S03_AXI_awvalid,
    S03_AXI_bid,
    S03_AXI_bready,
    S03_AXI_bresp,
    S03_AXI_bvalid,
    S03_AXI_rdata,
    S03_AXI_rid,
    S03_AXI_rlast,
    S03_AXI_rready,
    S03_AXI_rresp,
    S03_AXI_rvalid,
    S03_AXI_wdata,
    S03_AXI_wlast,
    S03_AXI_wready,
    S03_AXI_wstrb,
    S03_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [63:0]M00_AXI_araddr;
  output [1:0]M00_AXI_arburst;
  output [3:0]M00_AXI_arcache;
  output [8:0]M00_AXI_arid;
  output [7:0]M00_AXI_arlen;
  output [0:0]M00_AXI_arlock;
  output [2:0]M00_AXI_arprot;
  output [3:0]M00_AXI_arqos;
  input M00_AXI_arready;
  output [3:0]M00_AXI_arregion;
  output [2:0]M00_AXI_arsize;
  output M00_AXI_arvalid;
  output [63:0]M00_AXI_awaddr;
  output [1:0]M00_AXI_awburst;
  output [3:0]M00_AXI_awcache;
  output [8:0]M00_AXI_awid;
  output [7:0]M00_AXI_awlen;
  output [0:0]M00_AXI_awlock;
  output [2:0]M00_AXI_awprot;
  output [3:0]M00_AXI_awqos;
  input M00_AXI_awready;
  output [3:0]M00_AXI_awregion;
  output [2:0]M00_AXI_awsize;
  output M00_AXI_awvalid;
  input [8:0]M00_AXI_bid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [511:0]M00_AXI_rdata;
  input [8:0]M00_AXI_rid;
  input M00_AXI_rlast;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [511:0]M00_AXI_wdata;
  output M00_AXI_wlast;
  input M00_AXI_wready;
  output [63:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [63:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [6:0]S00_AXI_arid;
  input [7:0]S00_AXI_arlen;
  input [0:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [3:0]S00_AXI_arregion;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [63:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [6:0]S00_AXI_awid;
  input [7:0]S00_AXI_awlen;
  input [0:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [3:0]S00_AXI_awregion;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  output [6:0]S00_AXI_bid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [511:0]S00_AXI_rdata;
  output [6:0]S00_AXI_rid;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [511:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [63:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;
  input S01_ACLK;
  input S01_ARESETN;
  input [63:0]S01_AXI_araddr;
  input [1:0]S01_AXI_arburst;
  input [3:0]S01_AXI_arcache;
  input [6:0]S01_AXI_arid;
  input [7:0]S01_AXI_arlen;
  input [0:0]S01_AXI_arlock;
  input [2:0]S01_AXI_arprot;
  input [3:0]S01_AXI_arqos;
  output S01_AXI_arready;
  input [3:0]S01_AXI_arregion;
  input [2:0]S01_AXI_arsize;
  input S01_AXI_arvalid;
  input [63:0]S01_AXI_awaddr;
  input [1:0]S01_AXI_awburst;
  input [3:0]S01_AXI_awcache;
  input [6:0]S01_AXI_awid;
  input [7:0]S01_AXI_awlen;
  input [0:0]S01_AXI_awlock;
  input [2:0]S01_AXI_awprot;
  input [3:0]S01_AXI_awqos;
  output S01_AXI_awready;
  input [3:0]S01_AXI_awregion;
  input [2:0]S01_AXI_awsize;
  input S01_AXI_awvalid;
  output [6:0]S01_AXI_bid;
  input S01_AXI_bready;
  output [1:0]S01_AXI_bresp;
  output S01_AXI_bvalid;
  output [511:0]S01_AXI_rdata;
  output [6:0]S01_AXI_rid;
  output S01_AXI_rlast;
  input S01_AXI_rready;
  output [1:0]S01_AXI_rresp;
  output S01_AXI_rvalid;
  input [511:0]S01_AXI_wdata;
  input S01_AXI_wlast;
  output S01_AXI_wready;
  input [63:0]S01_AXI_wstrb;
  input S01_AXI_wvalid;
  input S02_ACLK;
  input S02_ARESETN;
  input [63:0]S02_AXI_araddr;
  input [1:0]S02_AXI_arburst;
  input [3:0]S02_AXI_arcache;
  input [6:0]S02_AXI_arid;
  input [7:0]S02_AXI_arlen;
  input [0:0]S02_AXI_arlock;
  input [2:0]S02_AXI_arprot;
  input [3:0]S02_AXI_arqos;
  output S02_AXI_arready;
  input [3:0]S02_AXI_arregion;
  input [2:0]S02_AXI_arsize;
  input S02_AXI_arvalid;
  input [63:0]S02_AXI_awaddr;
  input [1:0]S02_AXI_awburst;
  input [3:0]S02_AXI_awcache;
  input [6:0]S02_AXI_awid;
  input [7:0]S02_AXI_awlen;
  input [0:0]S02_AXI_awlock;
  input [2:0]S02_AXI_awprot;
  input [3:0]S02_AXI_awqos;
  output S02_AXI_awready;
  input [3:0]S02_AXI_awregion;
  input [2:0]S02_AXI_awsize;
  input S02_AXI_awvalid;
  output [6:0]S02_AXI_bid;
  input S02_AXI_bready;
  output [1:0]S02_AXI_bresp;
  output S02_AXI_bvalid;
  output [511:0]S02_AXI_rdata;
  output [6:0]S02_AXI_rid;
  output S02_AXI_rlast;
  input S02_AXI_rready;
  output [1:0]S02_AXI_rresp;
  output S02_AXI_rvalid;
  input [511:0]S02_AXI_wdata;
  input S02_AXI_wlast;
  output S02_AXI_wready;
  input [63:0]S02_AXI_wstrb;
  input S02_AXI_wvalid;
  input S03_ACLK;
  input S03_ARESETN;
  input [63:0]S03_AXI_araddr;
  input [1:0]S03_AXI_arburst;
  input [3:0]S03_AXI_arcache;
  input [6:0]S03_AXI_arid;
  input [7:0]S03_AXI_arlen;
  input [0:0]S03_AXI_arlock;
  input [2:0]S03_AXI_arprot;
  input [3:0]S03_AXI_arqos;
  output S03_AXI_arready;
  input [3:0]S03_AXI_arregion;
  input [2:0]S03_AXI_arsize;
  input S03_AXI_arvalid;
  input [63:0]S03_AXI_awaddr;
  input [1:0]S03_AXI_awburst;
  input [3:0]S03_AXI_awcache;
  input [6:0]S03_AXI_awid;
  input [7:0]S03_AXI_awlen;
  input [0:0]S03_AXI_awlock;
  input [2:0]S03_AXI_awprot;
  input [3:0]S03_AXI_awqos;
  output S03_AXI_awready;
  input [3:0]S03_AXI_awregion;
  input [2:0]S03_AXI_awsize;
  input S03_AXI_awvalid;
  output [6:0]S03_AXI_bid;
  input S03_AXI_bready;
  output [1:0]S03_AXI_bresp;
  output S03_AXI_bvalid;
  output [511:0]S03_AXI_rdata;
  output [6:0]S03_AXI_rid;
  output S03_AXI_rlast;
  input S03_AXI_rready;
  output [1:0]S03_AXI_rresp;
  output S03_AXI_rvalid;
  input [511:0]S03_AXI_wdata;
  input S03_AXI_wlast;
  output S03_AXI_wready;
  input [63:0]S03_AXI_wstrb;
  input S03_AXI_wvalid;

  wire axi_interconnect_ACLK_net;
  wire axi_interconnect_ARESETN_net;
  wire [63:0]axi_interconnect_to_s00_couplers_ARADDR;
  wire [1:0]axi_interconnect_to_s00_couplers_ARBURST;
  wire [3:0]axi_interconnect_to_s00_couplers_ARCACHE;
  wire [6:0]axi_interconnect_to_s00_couplers_ARID;
  wire [7:0]axi_interconnect_to_s00_couplers_ARLEN;
  wire [0:0]axi_interconnect_to_s00_couplers_ARLOCK;
  wire [2:0]axi_interconnect_to_s00_couplers_ARPROT;
  wire [3:0]axi_interconnect_to_s00_couplers_ARQOS;
  wire axi_interconnect_to_s00_couplers_ARREADY;
  wire [3:0]axi_interconnect_to_s00_couplers_ARREGION;
  wire [2:0]axi_interconnect_to_s00_couplers_ARSIZE;
  wire axi_interconnect_to_s00_couplers_ARVALID;
  wire [63:0]axi_interconnect_to_s00_couplers_AWADDR;
  wire [1:0]axi_interconnect_to_s00_couplers_AWBURST;
  wire [3:0]axi_interconnect_to_s00_couplers_AWCACHE;
  wire [6:0]axi_interconnect_to_s00_couplers_AWID;
  wire [7:0]axi_interconnect_to_s00_couplers_AWLEN;
  wire [0:0]axi_interconnect_to_s00_couplers_AWLOCK;
  wire [2:0]axi_interconnect_to_s00_couplers_AWPROT;
  wire [3:0]axi_interconnect_to_s00_couplers_AWQOS;
  wire axi_interconnect_to_s00_couplers_AWREADY;
  wire [3:0]axi_interconnect_to_s00_couplers_AWREGION;
  wire [2:0]axi_interconnect_to_s00_couplers_AWSIZE;
  wire axi_interconnect_to_s00_couplers_AWVALID;
  wire [6:0]axi_interconnect_to_s00_couplers_BID;
  wire axi_interconnect_to_s00_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_BRESP;
  wire axi_interconnect_to_s00_couplers_BVALID;
  wire [511:0]axi_interconnect_to_s00_couplers_RDATA;
  wire [6:0]axi_interconnect_to_s00_couplers_RID;
  wire axi_interconnect_to_s00_couplers_RLAST;
  wire axi_interconnect_to_s00_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_RRESP;
  wire axi_interconnect_to_s00_couplers_RVALID;
  wire [511:0]axi_interconnect_to_s00_couplers_WDATA;
  wire axi_interconnect_to_s00_couplers_WLAST;
  wire axi_interconnect_to_s00_couplers_WREADY;
  wire [63:0]axi_interconnect_to_s00_couplers_WSTRB;
  wire axi_interconnect_to_s00_couplers_WVALID;
  wire [63:0]axi_interconnect_to_s01_couplers_ARADDR;
  wire [1:0]axi_interconnect_to_s01_couplers_ARBURST;
  wire [3:0]axi_interconnect_to_s01_couplers_ARCACHE;
  wire [6:0]axi_interconnect_to_s01_couplers_ARID;
  wire [7:0]axi_interconnect_to_s01_couplers_ARLEN;
  wire [0:0]axi_interconnect_to_s01_couplers_ARLOCK;
  wire [2:0]axi_interconnect_to_s01_couplers_ARPROT;
  wire [3:0]axi_interconnect_to_s01_couplers_ARQOS;
  wire axi_interconnect_to_s01_couplers_ARREADY;
  wire [3:0]axi_interconnect_to_s01_couplers_ARREGION;
  wire [2:0]axi_interconnect_to_s01_couplers_ARSIZE;
  wire axi_interconnect_to_s01_couplers_ARVALID;
  wire [63:0]axi_interconnect_to_s01_couplers_AWADDR;
  wire [1:0]axi_interconnect_to_s01_couplers_AWBURST;
  wire [3:0]axi_interconnect_to_s01_couplers_AWCACHE;
  wire [6:0]axi_interconnect_to_s01_couplers_AWID;
  wire [7:0]axi_interconnect_to_s01_couplers_AWLEN;
  wire [0:0]axi_interconnect_to_s01_couplers_AWLOCK;
  wire [2:0]axi_interconnect_to_s01_couplers_AWPROT;
  wire [3:0]axi_interconnect_to_s01_couplers_AWQOS;
  wire axi_interconnect_to_s01_couplers_AWREADY;
  wire [3:0]axi_interconnect_to_s01_couplers_AWREGION;
  wire [2:0]axi_interconnect_to_s01_couplers_AWSIZE;
  wire axi_interconnect_to_s01_couplers_AWVALID;
  wire [6:0]axi_interconnect_to_s01_couplers_BID;
  wire axi_interconnect_to_s01_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s01_couplers_BRESP;
  wire axi_interconnect_to_s01_couplers_BVALID;
  wire [511:0]axi_interconnect_to_s01_couplers_RDATA;
  wire [6:0]axi_interconnect_to_s01_couplers_RID;
  wire axi_interconnect_to_s01_couplers_RLAST;
  wire axi_interconnect_to_s01_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s01_couplers_RRESP;
  wire axi_interconnect_to_s01_couplers_RVALID;
  wire [511:0]axi_interconnect_to_s01_couplers_WDATA;
  wire axi_interconnect_to_s01_couplers_WLAST;
  wire axi_interconnect_to_s01_couplers_WREADY;
  wire [63:0]axi_interconnect_to_s01_couplers_WSTRB;
  wire axi_interconnect_to_s01_couplers_WVALID;
  wire [63:0]axi_interconnect_to_s02_couplers_ARADDR;
  wire [1:0]axi_interconnect_to_s02_couplers_ARBURST;
  wire [3:0]axi_interconnect_to_s02_couplers_ARCACHE;
  wire [6:0]axi_interconnect_to_s02_couplers_ARID;
  wire [7:0]axi_interconnect_to_s02_couplers_ARLEN;
  wire [0:0]axi_interconnect_to_s02_couplers_ARLOCK;
  wire [2:0]axi_interconnect_to_s02_couplers_ARPROT;
  wire [3:0]axi_interconnect_to_s02_couplers_ARQOS;
  wire axi_interconnect_to_s02_couplers_ARREADY;
  wire [3:0]axi_interconnect_to_s02_couplers_ARREGION;
  wire [2:0]axi_interconnect_to_s02_couplers_ARSIZE;
  wire axi_interconnect_to_s02_couplers_ARVALID;
  wire [63:0]axi_interconnect_to_s02_couplers_AWADDR;
  wire [1:0]axi_interconnect_to_s02_couplers_AWBURST;
  wire [3:0]axi_interconnect_to_s02_couplers_AWCACHE;
  wire [6:0]axi_interconnect_to_s02_couplers_AWID;
  wire [7:0]axi_interconnect_to_s02_couplers_AWLEN;
  wire [0:0]axi_interconnect_to_s02_couplers_AWLOCK;
  wire [2:0]axi_interconnect_to_s02_couplers_AWPROT;
  wire [3:0]axi_interconnect_to_s02_couplers_AWQOS;
  wire axi_interconnect_to_s02_couplers_AWREADY;
  wire [3:0]axi_interconnect_to_s02_couplers_AWREGION;
  wire [2:0]axi_interconnect_to_s02_couplers_AWSIZE;
  wire axi_interconnect_to_s02_couplers_AWVALID;
  wire [6:0]axi_interconnect_to_s02_couplers_BID;
  wire axi_interconnect_to_s02_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s02_couplers_BRESP;
  wire axi_interconnect_to_s02_couplers_BVALID;
  wire [511:0]axi_interconnect_to_s02_couplers_RDATA;
  wire [6:0]axi_interconnect_to_s02_couplers_RID;
  wire axi_interconnect_to_s02_couplers_RLAST;
  wire axi_interconnect_to_s02_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s02_couplers_RRESP;
  wire axi_interconnect_to_s02_couplers_RVALID;
  wire [511:0]axi_interconnect_to_s02_couplers_WDATA;
  wire axi_interconnect_to_s02_couplers_WLAST;
  wire axi_interconnect_to_s02_couplers_WREADY;
  wire [63:0]axi_interconnect_to_s02_couplers_WSTRB;
  wire axi_interconnect_to_s02_couplers_WVALID;
  wire [63:0]axi_interconnect_to_s03_couplers_ARADDR;
  wire [1:0]axi_interconnect_to_s03_couplers_ARBURST;
  wire [3:0]axi_interconnect_to_s03_couplers_ARCACHE;
  wire [6:0]axi_interconnect_to_s03_couplers_ARID;
  wire [7:0]axi_interconnect_to_s03_couplers_ARLEN;
  wire [0:0]axi_interconnect_to_s03_couplers_ARLOCK;
  wire [2:0]axi_interconnect_to_s03_couplers_ARPROT;
  wire [3:0]axi_interconnect_to_s03_couplers_ARQOS;
  wire axi_interconnect_to_s03_couplers_ARREADY;
  wire [3:0]axi_interconnect_to_s03_couplers_ARREGION;
  wire [2:0]axi_interconnect_to_s03_couplers_ARSIZE;
  wire axi_interconnect_to_s03_couplers_ARVALID;
  wire [63:0]axi_interconnect_to_s03_couplers_AWADDR;
  wire [1:0]axi_interconnect_to_s03_couplers_AWBURST;
  wire [3:0]axi_interconnect_to_s03_couplers_AWCACHE;
  wire [6:0]axi_interconnect_to_s03_couplers_AWID;
  wire [7:0]axi_interconnect_to_s03_couplers_AWLEN;
  wire [0:0]axi_interconnect_to_s03_couplers_AWLOCK;
  wire [2:0]axi_interconnect_to_s03_couplers_AWPROT;
  wire [3:0]axi_interconnect_to_s03_couplers_AWQOS;
  wire axi_interconnect_to_s03_couplers_AWREADY;
  wire [3:0]axi_interconnect_to_s03_couplers_AWREGION;
  wire [2:0]axi_interconnect_to_s03_couplers_AWSIZE;
  wire axi_interconnect_to_s03_couplers_AWVALID;
  wire [6:0]axi_interconnect_to_s03_couplers_BID;
  wire axi_interconnect_to_s03_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s03_couplers_BRESP;
  wire axi_interconnect_to_s03_couplers_BVALID;
  wire [511:0]axi_interconnect_to_s03_couplers_RDATA;
  wire [6:0]axi_interconnect_to_s03_couplers_RID;
  wire axi_interconnect_to_s03_couplers_RLAST;
  wire axi_interconnect_to_s03_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s03_couplers_RRESP;
  wire axi_interconnect_to_s03_couplers_RVALID;
  wire [511:0]axi_interconnect_to_s03_couplers_WDATA;
  wire axi_interconnect_to_s03_couplers_WLAST;
  wire axi_interconnect_to_s03_couplers_WREADY;
  wire [63:0]axi_interconnect_to_s03_couplers_WSTRB;
  wire axi_interconnect_to_s03_couplers_WVALID;
  wire [63:0]m00_couplers_to_axi_interconnect_ARADDR;
  wire [1:0]m00_couplers_to_axi_interconnect_ARBURST;
  wire [3:0]m00_couplers_to_axi_interconnect_ARCACHE;
  wire [8:0]m00_couplers_to_axi_interconnect_ARID;
  wire [7:0]m00_couplers_to_axi_interconnect_ARLEN;
  wire [0:0]m00_couplers_to_axi_interconnect_ARLOCK;
  wire [2:0]m00_couplers_to_axi_interconnect_ARPROT;
  wire [3:0]m00_couplers_to_axi_interconnect_ARQOS;
  wire m00_couplers_to_axi_interconnect_ARREADY;
  wire [3:0]m00_couplers_to_axi_interconnect_ARREGION;
  wire [2:0]m00_couplers_to_axi_interconnect_ARSIZE;
  wire m00_couplers_to_axi_interconnect_ARVALID;
  wire [63:0]m00_couplers_to_axi_interconnect_AWADDR;
  wire [1:0]m00_couplers_to_axi_interconnect_AWBURST;
  wire [3:0]m00_couplers_to_axi_interconnect_AWCACHE;
  wire [8:0]m00_couplers_to_axi_interconnect_AWID;
  wire [7:0]m00_couplers_to_axi_interconnect_AWLEN;
  wire [0:0]m00_couplers_to_axi_interconnect_AWLOCK;
  wire [2:0]m00_couplers_to_axi_interconnect_AWPROT;
  wire [3:0]m00_couplers_to_axi_interconnect_AWQOS;
  wire m00_couplers_to_axi_interconnect_AWREADY;
  wire [3:0]m00_couplers_to_axi_interconnect_AWREGION;
  wire [2:0]m00_couplers_to_axi_interconnect_AWSIZE;
  wire m00_couplers_to_axi_interconnect_AWVALID;
  wire [8:0]m00_couplers_to_axi_interconnect_BID;
  wire m00_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_BRESP;
  wire m00_couplers_to_axi_interconnect_BVALID;
  wire [511:0]m00_couplers_to_axi_interconnect_RDATA;
  wire [8:0]m00_couplers_to_axi_interconnect_RID;
  wire m00_couplers_to_axi_interconnect_RLAST;
  wire m00_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_RRESP;
  wire m00_couplers_to_axi_interconnect_RVALID;
  wire [511:0]m00_couplers_to_axi_interconnect_WDATA;
  wire m00_couplers_to_axi_interconnect_WLAST;
  wire m00_couplers_to_axi_interconnect_WREADY;
  wire [63:0]m00_couplers_to_axi_interconnect_WSTRB;
  wire m00_couplers_to_axi_interconnect_WVALID;
  wire [63:0]s00_couplers_to_xbar_ARADDR;
  wire [1:0]s00_couplers_to_xbar_ARBURST;
  wire [3:0]s00_couplers_to_xbar_ARCACHE;
  wire [6:0]s00_couplers_to_xbar_ARID;
  wire [7:0]s00_couplers_to_xbar_ARLEN;
  wire [0:0]s00_couplers_to_xbar_ARLOCK;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [3:0]s00_couplers_to_xbar_ARQOS;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire [2:0]s00_couplers_to_xbar_ARSIZE;
  wire s00_couplers_to_xbar_ARVALID;
  wire [63:0]s00_couplers_to_xbar_AWADDR;
  wire [1:0]s00_couplers_to_xbar_AWBURST;
  wire [3:0]s00_couplers_to_xbar_AWCACHE;
  wire [6:0]s00_couplers_to_xbar_AWID;
  wire [7:0]s00_couplers_to_xbar_AWLEN;
  wire [0:0]s00_couplers_to_xbar_AWLOCK;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [3:0]s00_couplers_to_xbar_AWQOS;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire [2:0]s00_couplers_to_xbar_AWSIZE;
  wire s00_couplers_to_xbar_AWVALID;
  wire [8:0]s00_couplers_to_xbar_BID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [511:0]s00_couplers_to_xbar_RDATA;
  wire [8:0]s00_couplers_to_xbar_RID;
  wire [0:0]s00_couplers_to_xbar_RLAST;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [511:0]s00_couplers_to_xbar_WDATA;
  wire s00_couplers_to_xbar_WLAST;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [63:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [63:0]s01_couplers_to_xbar_ARADDR;
  wire [1:0]s01_couplers_to_xbar_ARBURST;
  wire [3:0]s01_couplers_to_xbar_ARCACHE;
  wire [6:0]s01_couplers_to_xbar_ARID;
  wire [7:0]s01_couplers_to_xbar_ARLEN;
  wire [0:0]s01_couplers_to_xbar_ARLOCK;
  wire [2:0]s01_couplers_to_xbar_ARPROT;
  wire [3:0]s01_couplers_to_xbar_ARQOS;
  wire [1:1]s01_couplers_to_xbar_ARREADY;
  wire [2:0]s01_couplers_to_xbar_ARSIZE;
  wire s01_couplers_to_xbar_ARVALID;
  wire [63:0]s01_couplers_to_xbar_AWADDR;
  wire [1:0]s01_couplers_to_xbar_AWBURST;
  wire [3:0]s01_couplers_to_xbar_AWCACHE;
  wire [6:0]s01_couplers_to_xbar_AWID;
  wire [7:0]s01_couplers_to_xbar_AWLEN;
  wire [0:0]s01_couplers_to_xbar_AWLOCK;
  wire [2:0]s01_couplers_to_xbar_AWPROT;
  wire [3:0]s01_couplers_to_xbar_AWQOS;
  wire [1:1]s01_couplers_to_xbar_AWREADY;
  wire [2:0]s01_couplers_to_xbar_AWSIZE;
  wire s01_couplers_to_xbar_AWVALID;
  wire [17:9]s01_couplers_to_xbar_BID;
  wire s01_couplers_to_xbar_BREADY;
  wire [3:2]s01_couplers_to_xbar_BRESP;
  wire [1:1]s01_couplers_to_xbar_BVALID;
  wire [1023:512]s01_couplers_to_xbar_RDATA;
  wire [17:9]s01_couplers_to_xbar_RID;
  wire [1:1]s01_couplers_to_xbar_RLAST;
  wire s01_couplers_to_xbar_RREADY;
  wire [3:2]s01_couplers_to_xbar_RRESP;
  wire [1:1]s01_couplers_to_xbar_RVALID;
  wire [511:0]s01_couplers_to_xbar_WDATA;
  wire s01_couplers_to_xbar_WLAST;
  wire [1:1]s01_couplers_to_xbar_WREADY;
  wire [63:0]s01_couplers_to_xbar_WSTRB;
  wire s01_couplers_to_xbar_WVALID;
  wire [63:0]s02_couplers_to_xbar_ARADDR;
  wire [1:0]s02_couplers_to_xbar_ARBURST;
  wire [3:0]s02_couplers_to_xbar_ARCACHE;
  wire [6:0]s02_couplers_to_xbar_ARID;
  wire [7:0]s02_couplers_to_xbar_ARLEN;
  wire [0:0]s02_couplers_to_xbar_ARLOCK;
  wire [2:0]s02_couplers_to_xbar_ARPROT;
  wire [3:0]s02_couplers_to_xbar_ARQOS;
  wire [2:2]s02_couplers_to_xbar_ARREADY;
  wire [2:0]s02_couplers_to_xbar_ARSIZE;
  wire s02_couplers_to_xbar_ARVALID;
  wire [63:0]s02_couplers_to_xbar_AWADDR;
  wire [1:0]s02_couplers_to_xbar_AWBURST;
  wire [3:0]s02_couplers_to_xbar_AWCACHE;
  wire [6:0]s02_couplers_to_xbar_AWID;
  wire [7:0]s02_couplers_to_xbar_AWLEN;
  wire [0:0]s02_couplers_to_xbar_AWLOCK;
  wire [2:0]s02_couplers_to_xbar_AWPROT;
  wire [3:0]s02_couplers_to_xbar_AWQOS;
  wire [2:2]s02_couplers_to_xbar_AWREADY;
  wire [2:0]s02_couplers_to_xbar_AWSIZE;
  wire s02_couplers_to_xbar_AWVALID;
  wire [26:18]s02_couplers_to_xbar_BID;
  wire s02_couplers_to_xbar_BREADY;
  wire [5:4]s02_couplers_to_xbar_BRESP;
  wire [2:2]s02_couplers_to_xbar_BVALID;
  wire [1535:1024]s02_couplers_to_xbar_RDATA;
  wire [26:18]s02_couplers_to_xbar_RID;
  wire [2:2]s02_couplers_to_xbar_RLAST;
  wire s02_couplers_to_xbar_RREADY;
  wire [5:4]s02_couplers_to_xbar_RRESP;
  wire [2:2]s02_couplers_to_xbar_RVALID;
  wire [511:0]s02_couplers_to_xbar_WDATA;
  wire s02_couplers_to_xbar_WLAST;
  wire [2:2]s02_couplers_to_xbar_WREADY;
  wire [63:0]s02_couplers_to_xbar_WSTRB;
  wire s02_couplers_to_xbar_WVALID;
  wire [63:0]s03_couplers_to_xbar_ARADDR;
  wire [1:0]s03_couplers_to_xbar_ARBURST;
  wire [3:0]s03_couplers_to_xbar_ARCACHE;
  wire [6:0]s03_couplers_to_xbar_ARID;
  wire [7:0]s03_couplers_to_xbar_ARLEN;
  wire [0:0]s03_couplers_to_xbar_ARLOCK;
  wire [2:0]s03_couplers_to_xbar_ARPROT;
  wire [3:0]s03_couplers_to_xbar_ARQOS;
  wire [3:3]s03_couplers_to_xbar_ARREADY;
  wire [2:0]s03_couplers_to_xbar_ARSIZE;
  wire s03_couplers_to_xbar_ARVALID;
  wire [63:0]s03_couplers_to_xbar_AWADDR;
  wire [1:0]s03_couplers_to_xbar_AWBURST;
  wire [3:0]s03_couplers_to_xbar_AWCACHE;
  wire [6:0]s03_couplers_to_xbar_AWID;
  wire [7:0]s03_couplers_to_xbar_AWLEN;
  wire [0:0]s03_couplers_to_xbar_AWLOCK;
  wire [2:0]s03_couplers_to_xbar_AWPROT;
  wire [3:0]s03_couplers_to_xbar_AWQOS;
  wire [3:3]s03_couplers_to_xbar_AWREADY;
  wire [2:0]s03_couplers_to_xbar_AWSIZE;
  wire s03_couplers_to_xbar_AWVALID;
  wire [35:27]s03_couplers_to_xbar_BID;
  wire s03_couplers_to_xbar_BREADY;
  wire [7:6]s03_couplers_to_xbar_BRESP;
  wire [3:3]s03_couplers_to_xbar_BVALID;
  wire [2047:1536]s03_couplers_to_xbar_RDATA;
  wire [35:27]s03_couplers_to_xbar_RID;
  wire [3:3]s03_couplers_to_xbar_RLAST;
  wire s03_couplers_to_xbar_RREADY;
  wire [7:6]s03_couplers_to_xbar_RRESP;
  wire [3:3]s03_couplers_to_xbar_RVALID;
  wire [511:0]s03_couplers_to_xbar_WDATA;
  wire s03_couplers_to_xbar_WLAST;
  wire [3:3]s03_couplers_to_xbar_WREADY;
  wire [63:0]s03_couplers_to_xbar_WSTRB;
  wire s03_couplers_to_xbar_WVALID;
  wire [63:0]xbar_to_m00_couplers_ARADDR;
  wire [1:0]xbar_to_m00_couplers_ARBURST;
  wire [3:0]xbar_to_m00_couplers_ARCACHE;
  wire [8:0]xbar_to_m00_couplers_ARID;
  wire [7:0]xbar_to_m00_couplers_ARLEN;
  wire [0:0]xbar_to_m00_couplers_ARLOCK;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire [3:0]xbar_to_m00_couplers_ARQOS;
  wire xbar_to_m00_couplers_ARREADY;
  wire [3:0]xbar_to_m00_couplers_ARREGION;
  wire [2:0]xbar_to_m00_couplers_ARSIZE;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [63:0]xbar_to_m00_couplers_AWADDR;
  wire [1:0]xbar_to_m00_couplers_AWBURST;
  wire [3:0]xbar_to_m00_couplers_AWCACHE;
  wire [8:0]xbar_to_m00_couplers_AWID;
  wire [7:0]xbar_to_m00_couplers_AWLEN;
  wire [0:0]xbar_to_m00_couplers_AWLOCK;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire [3:0]xbar_to_m00_couplers_AWQOS;
  wire xbar_to_m00_couplers_AWREADY;
  wire [3:0]xbar_to_m00_couplers_AWREGION;
  wire [2:0]xbar_to_m00_couplers_AWSIZE;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [8:0]xbar_to_m00_couplers_BID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire xbar_to_m00_couplers_BVALID;
  wire [511:0]xbar_to_m00_couplers_RDATA;
  wire [8:0]xbar_to_m00_couplers_RID;
  wire xbar_to_m00_couplers_RLAST;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire xbar_to_m00_couplers_RVALID;
  wire [511:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WLAST;
  wire xbar_to_m00_couplers_WREADY;
  wire [63:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;

  assign M00_AXI_araddr[63:0] = m00_couplers_to_axi_interconnect_ARADDR;
  assign M00_AXI_arburst[1:0] = m00_couplers_to_axi_interconnect_ARBURST;
  assign M00_AXI_arcache[3:0] = m00_couplers_to_axi_interconnect_ARCACHE;
  assign M00_AXI_arid[8:0] = m00_couplers_to_axi_interconnect_ARID;
  assign M00_AXI_arlen[7:0] = m00_couplers_to_axi_interconnect_ARLEN;
  assign M00_AXI_arlock[0] = m00_couplers_to_axi_interconnect_ARLOCK;
  assign M00_AXI_arprot[2:0] = m00_couplers_to_axi_interconnect_ARPROT;
  assign M00_AXI_arqos[3:0] = m00_couplers_to_axi_interconnect_ARQOS;
  assign M00_AXI_arregion[3:0] = m00_couplers_to_axi_interconnect_ARREGION;
  assign M00_AXI_arsize[2:0] = m00_couplers_to_axi_interconnect_ARSIZE;
  assign M00_AXI_arvalid = m00_couplers_to_axi_interconnect_ARVALID;
  assign M00_AXI_awaddr[63:0] = m00_couplers_to_axi_interconnect_AWADDR;
  assign M00_AXI_awburst[1:0] = m00_couplers_to_axi_interconnect_AWBURST;
  assign M00_AXI_awcache[3:0] = m00_couplers_to_axi_interconnect_AWCACHE;
  assign M00_AXI_awid[8:0] = m00_couplers_to_axi_interconnect_AWID;
  assign M00_AXI_awlen[7:0] = m00_couplers_to_axi_interconnect_AWLEN;
  assign M00_AXI_awlock[0] = m00_couplers_to_axi_interconnect_AWLOCK;
  assign M00_AXI_awprot[2:0] = m00_couplers_to_axi_interconnect_AWPROT;
  assign M00_AXI_awqos[3:0] = m00_couplers_to_axi_interconnect_AWQOS;
  assign M00_AXI_awregion[3:0] = m00_couplers_to_axi_interconnect_AWREGION;
  assign M00_AXI_awsize[2:0] = m00_couplers_to_axi_interconnect_AWSIZE;
  assign M00_AXI_awvalid = m00_couplers_to_axi_interconnect_AWVALID;
  assign M00_AXI_bready = m00_couplers_to_axi_interconnect_BREADY;
  assign M00_AXI_rready = m00_couplers_to_axi_interconnect_RREADY;
  assign M00_AXI_wdata[511:0] = m00_couplers_to_axi_interconnect_WDATA;
  assign M00_AXI_wlast = m00_couplers_to_axi_interconnect_WLAST;
  assign M00_AXI_wstrb[63:0] = m00_couplers_to_axi_interconnect_WSTRB;
  assign M00_AXI_wvalid = m00_couplers_to_axi_interconnect_WVALID;
  assign S00_AXI_arready = axi_interconnect_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_interconnect_to_s00_couplers_AWREADY;
  assign S00_AXI_bid[6:0] = axi_interconnect_to_s00_couplers_BID;
  assign S00_AXI_bresp[1:0] = axi_interconnect_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_interconnect_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[511:0] = axi_interconnect_to_s00_couplers_RDATA;
  assign S00_AXI_rid[6:0] = axi_interconnect_to_s00_couplers_RID;
  assign S00_AXI_rlast = axi_interconnect_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = axi_interconnect_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_interconnect_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_interconnect_to_s00_couplers_WREADY;
  assign S01_AXI_arready = axi_interconnect_to_s01_couplers_ARREADY;
  assign S01_AXI_awready = axi_interconnect_to_s01_couplers_AWREADY;
  assign S01_AXI_bid[6:0] = axi_interconnect_to_s01_couplers_BID;
  assign S01_AXI_bresp[1:0] = axi_interconnect_to_s01_couplers_BRESP;
  assign S01_AXI_bvalid = axi_interconnect_to_s01_couplers_BVALID;
  assign S01_AXI_rdata[511:0] = axi_interconnect_to_s01_couplers_RDATA;
  assign S01_AXI_rid[6:0] = axi_interconnect_to_s01_couplers_RID;
  assign S01_AXI_rlast = axi_interconnect_to_s01_couplers_RLAST;
  assign S01_AXI_rresp[1:0] = axi_interconnect_to_s01_couplers_RRESP;
  assign S01_AXI_rvalid = axi_interconnect_to_s01_couplers_RVALID;
  assign S01_AXI_wready = axi_interconnect_to_s01_couplers_WREADY;
  assign S02_AXI_arready = axi_interconnect_to_s02_couplers_ARREADY;
  assign S02_AXI_awready = axi_interconnect_to_s02_couplers_AWREADY;
  assign S02_AXI_bid[6:0] = axi_interconnect_to_s02_couplers_BID;
  assign S02_AXI_bresp[1:0] = axi_interconnect_to_s02_couplers_BRESP;
  assign S02_AXI_bvalid = axi_interconnect_to_s02_couplers_BVALID;
  assign S02_AXI_rdata[511:0] = axi_interconnect_to_s02_couplers_RDATA;
  assign S02_AXI_rid[6:0] = axi_interconnect_to_s02_couplers_RID;
  assign S02_AXI_rlast = axi_interconnect_to_s02_couplers_RLAST;
  assign S02_AXI_rresp[1:0] = axi_interconnect_to_s02_couplers_RRESP;
  assign S02_AXI_rvalid = axi_interconnect_to_s02_couplers_RVALID;
  assign S02_AXI_wready = axi_interconnect_to_s02_couplers_WREADY;
  assign S03_AXI_arready = axi_interconnect_to_s03_couplers_ARREADY;
  assign S03_AXI_awready = axi_interconnect_to_s03_couplers_AWREADY;
  assign S03_AXI_bid[6:0] = axi_interconnect_to_s03_couplers_BID;
  assign S03_AXI_bresp[1:0] = axi_interconnect_to_s03_couplers_BRESP;
  assign S03_AXI_bvalid = axi_interconnect_to_s03_couplers_BVALID;
  assign S03_AXI_rdata[511:0] = axi_interconnect_to_s03_couplers_RDATA;
  assign S03_AXI_rid[6:0] = axi_interconnect_to_s03_couplers_RID;
  assign S03_AXI_rlast = axi_interconnect_to_s03_couplers_RLAST;
  assign S03_AXI_rresp[1:0] = axi_interconnect_to_s03_couplers_RRESP;
  assign S03_AXI_rvalid = axi_interconnect_to_s03_couplers_RVALID;
  assign S03_AXI_wready = axi_interconnect_to_s03_couplers_WREADY;
  assign axi_interconnect_ACLK_net = ACLK;
  assign axi_interconnect_ARESETN_net = ARESETN;
  assign axi_interconnect_to_s00_couplers_ARADDR = S00_AXI_araddr[63:0];
  assign axi_interconnect_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign axi_interconnect_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign axi_interconnect_to_s00_couplers_ARID = S00_AXI_arid[6:0];
  assign axi_interconnect_to_s00_couplers_ARLEN = S00_AXI_arlen[7:0];
  assign axi_interconnect_to_s00_couplers_ARLOCK = S00_AXI_arlock[0];
  assign axi_interconnect_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign axi_interconnect_to_s00_couplers_ARREGION = S00_AXI_arregion[3:0];
  assign axi_interconnect_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign axi_interconnect_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_interconnect_to_s00_couplers_AWADDR = S00_AXI_awaddr[63:0];
  assign axi_interconnect_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign axi_interconnect_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign axi_interconnect_to_s00_couplers_AWID = S00_AXI_awid[6:0];
  assign axi_interconnect_to_s00_couplers_AWLEN = S00_AXI_awlen[7:0];
  assign axi_interconnect_to_s00_couplers_AWLOCK = S00_AXI_awlock[0];
  assign axi_interconnect_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign axi_interconnect_to_s00_couplers_AWREGION = S00_AXI_awregion[3:0];
  assign axi_interconnect_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign axi_interconnect_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_interconnect_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_interconnect_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_interconnect_to_s00_couplers_WDATA = S00_AXI_wdata[511:0];
  assign axi_interconnect_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign axi_interconnect_to_s00_couplers_WSTRB = S00_AXI_wstrb[63:0];
  assign axi_interconnect_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign axi_interconnect_to_s01_couplers_ARADDR = S01_AXI_araddr[63:0];
  assign axi_interconnect_to_s01_couplers_ARBURST = S01_AXI_arburst[1:0];
  assign axi_interconnect_to_s01_couplers_ARCACHE = S01_AXI_arcache[3:0];
  assign axi_interconnect_to_s01_couplers_ARID = S01_AXI_arid[6:0];
  assign axi_interconnect_to_s01_couplers_ARLEN = S01_AXI_arlen[7:0];
  assign axi_interconnect_to_s01_couplers_ARLOCK = S01_AXI_arlock[0];
  assign axi_interconnect_to_s01_couplers_ARPROT = S01_AXI_arprot[2:0];
  assign axi_interconnect_to_s01_couplers_ARQOS = S01_AXI_arqos[3:0];
  assign axi_interconnect_to_s01_couplers_ARREGION = S01_AXI_arregion[3:0];
  assign axi_interconnect_to_s01_couplers_ARSIZE = S01_AXI_arsize[2:0];
  assign axi_interconnect_to_s01_couplers_ARVALID = S01_AXI_arvalid;
  assign axi_interconnect_to_s01_couplers_AWADDR = S01_AXI_awaddr[63:0];
  assign axi_interconnect_to_s01_couplers_AWBURST = S01_AXI_awburst[1:0];
  assign axi_interconnect_to_s01_couplers_AWCACHE = S01_AXI_awcache[3:0];
  assign axi_interconnect_to_s01_couplers_AWID = S01_AXI_awid[6:0];
  assign axi_interconnect_to_s01_couplers_AWLEN = S01_AXI_awlen[7:0];
  assign axi_interconnect_to_s01_couplers_AWLOCK = S01_AXI_awlock[0];
  assign axi_interconnect_to_s01_couplers_AWPROT = S01_AXI_awprot[2:0];
  assign axi_interconnect_to_s01_couplers_AWQOS = S01_AXI_awqos[3:0];
  assign axi_interconnect_to_s01_couplers_AWREGION = S01_AXI_awregion[3:0];
  assign axi_interconnect_to_s01_couplers_AWSIZE = S01_AXI_awsize[2:0];
  assign axi_interconnect_to_s01_couplers_AWVALID = S01_AXI_awvalid;
  assign axi_interconnect_to_s01_couplers_BREADY = S01_AXI_bready;
  assign axi_interconnect_to_s01_couplers_RREADY = S01_AXI_rready;
  assign axi_interconnect_to_s01_couplers_WDATA = S01_AXI_wdata[511:0];
  assign axi_interconnect_to_s01_couplers_WLAST = S01_AXI_wlast;
  assign axi_interconnect_to_s01_couplers_WSTRB = S01_AXI_wstrb[63:0];
  assign axi_interconnect_to_s01_couplers_WVALID = S01_AXI_wvalid;
  assign axi_interconnect_to_s02_couplers_ARADDR = S02_AXI_araddr[63:0];
  assign axi_interconnect_to_s02_couplers_ARBURST = S02_AXI_arburst[1:0];
  assign axi_interconnect_to_s02_couplers_ARCACHE = S02_AXI_arcache[3:0];
  assign axi_interconnect_to_s02_couplers_ARID = S02_AXI_arid[6:0];
  assign axi_interconnect_to_s02_couplers_ARLEN = S02_AXI_arlen[7:0];
  assign axi_interconnect_to_s02_couplers_ARLOCK = S02_AXI_arlock[0];
  assign axi_interconnect_to_s02_couplers_ARPROT = S02_AXI_arprot[2:0];
  assign axi_interconnect_to_s02_couplers_ARQOS = S02_AXI_arqos[3:0];
  assign axi_interconnect_to_s02_couplers_ARREGION = S02_AXI_arregion[3:0];
  assign axi_interconnect_to_s02_couplers_ARSIZE = S02_AXI_arsize[2:0];
  assign axi_interconnect_to_s02_couplers_ARVALID = S02_AXI_arvalid;
  assign axi_interconnect_to_s02_couplers_AWADDR = S02_AXI_awaddr[63:0];
  assign axi_interconnect_to_s02_couplers_AWBURST = S02_AXI_awburst[1:0];
  assign axi_interconnect_to_s02_couplers_AWCACHE = S02_AXI_awcache[3:0];
  assign axi_interconnect_to_s02_couplers_AWID = S02_AXI_awid[6:0];
  assign axi_interconnect_to_s02_couplers_AWLEN = S02_AXI_awlen[7:0];
  assign axi_interconnect_to_s02_couplers_AWLOCK = S02_AXI_awlock[0];
  assign axi_interconnect_to_s02_couplers_AWPROT = S02_AXI_awprot[2:0];
  assign axi_interconnect_to_s02_couplers_AWQOS = S02_AXI_awqos[3:0];
  assign axi_interconnect_to_s02_couplers_AWREGION = S02_AXI_awregion[3:0];
  assign axi_interconnect_to_s02_couplers_AWSIZE = S02_AXI_awsize[2:0];
  assign axi_interconnect_to_s02_couplers_AWVALID = S02_AXI_awvalid;
  assign axi_interconnect_to_s02_couplers_BREADY = S02_AXI_bready;
  assign axi_interconnect_to_s02_couplers_RREADY = S02_AXI_rready;
  assign axi_interconnect_to_s02_couplers_WDATA = S02_AXI_wdata[511:0];
  assign axi_interconnect_to_s02_couplers_WLAST = S02_AXI_wlast;
  assign axi_interconnect_to_s02_couplers_WSTRB = S02_AXI_wstrb[63:0];
  assign axi_interconnect_to_s02_couplers_WVALID = S02_AXI_wvalid;
  assign axi_interconnect_to_s03_couplers_ARADDR = S03_AXI_araddr[63:0];
  assign axi_interconnect_to_s03_couplers_ARBURST = S03_AXI_arburst[1:0];
  assign axi_interconnect_to_s03_couplers_ARCACHE = S03_AXI_arcache[3:0];
  assign axi_interconnect_to_s03_couplers_ARID = S03_AXI_arid[6:0];
  assign axi_interconnect_to_s03_couplers_ARLEN = S03_AXI_arlen[7:0];
  assign axi_interconnect_to_s03_couplers_ARLOCK = S03_AXI_arlock[0];
  assign axi_interconnect_to_s03_couplers_ARPROT = S03_AXI_arprot[2:0];
  assign axi_interconnect_to_s03_couplers_ARQOS = S03_AXI_arqos[3:0];
  assign axi_interconnect_to_s03_couplers_ARREGION = S03_AXI_arregion[3:0];
  assign axi_interconnect_to_s03_couplers_ARSIZE = S03_AXI_arsize[2:0];
  assign axi_interconnect_to_s03_couplers_ARVALID = S03_AXI_arvalid;
  assign axi_interconnect_to_s03_couplers_AWADDR = S03_AXI_awaddr[63:0];
  assign axi_interconnect_to_s03_couplers_AWBURST = S03_AXI_awburst[1:0];
  assign axi_interconnect_to_s03_couplers_AWCACHE = S03_AXI_awcache[3:0];
  assign axi_interconnect_to_s03_couplers_AWID = S03_AXI_awid[6:0];
  assign axi_interconnect_to_s03_couplers_AWLEN = S03_AXI_awlen[7:0];
  assign axi_interconnect_to_s03_couplers_AWLOCK = S03_AXI_awlock[0];
  assign axi_interconnect_to_s03_couplers_AWPROT = S03_AXI_awprot[2:0];
  assign axi_interconnect_to_s03_couplers_AWQOS = S03_AXI_awqos[3:0];
  assign axi_interconnect_to_s03_couplers_AWREGION = S03_AXI_awregion[3:0];
  assign axi_interconnect_to_s03_couplers_AWSIZE = S03_AXI_awsize[2:0];
  assign axi_interconnect_to_s03_couplers_AWVALID = S03_AXI_awvalid;
  assign axi_interconnect_to_s03_couplers_BREADY = S03_AXI_bready;
  assign axi_interconnect_to_s03_couplers_RREADY = S03_AXI_rready;
  assign axi_interconnect_to_s03_couplers_WDATA = S03_AXI_wdata[511:0];
  assign axi_interconnect_to_s03_couplers_WLAST = S03_AXI_wlast;
  assign axi_interconnect_to_s03_couplers_WSTRB = S03_AXI_wstrb[63:0];
  assign axi_interconnect_to_s03_couplers_WVALID = S03_AXI_wvalid;
  assign m00_couplers_to_axi_interconnect_ARREADY = M00_AXI_arready;
  assign m00_couplers_to_axi_interconnect_AWREADY = M00_AXI_awready;
  assign m00_couplers_to_axi_interconnect_BID = M00_AXI_bid[8:0];
  assign m00_couplers_to_axi_interconnect_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_interconnect_BVALID = M00_AXI_bvalid;
  assign m00_couplers_to_axi_interconnect_RDATA = M00_AXI_rdata[511:0];
  assign m00_couplers_to_axi_interconnect_RID = M00_AXI_rid[8:0];
  assign m00_couplers_to_axi_interconnect_RLAST = M00_AXI_rlast;
  assign m00_couplers_to_axi_interconnect_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_interconnect_RVALID = M00_AXI_rvalid;
  assign m00_couplers_to_axi_interconnect_WREADY = M00_AXI_wready;
  m00_couplers_imp_KUCT99 m00_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(m00_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arburst(m00_couplers_to_axi_interconnect_ARBURST),
        .M_AXI_arcache(m00_couplers_to_axi_interconnect_ARCACHE),
        .M_AXI_arid(m00_couplers_to_axi_interconnect_ARID),
        .M_AXI_arlen(m00_couplers_to_axi_interconnect_ARLEN),
        .M_AXI_arlock(m00_couplers_to_axi_interconnect_ARLOCK),
        .M_AXI_arprot(m00_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arqos(m00_couplers_to_axi_interconnect_ARQOS),
        .M_AXI_arready(m00_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arregion(m00_couplers_to_axi_interconnect_ARREGION),
        .M_AXI_arsize(m00_couplers_to_axi_interconnect_ARSIZE),
        .M_AXI_arvalid(m00_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awburst(m00_couplers_to_axi_interconnect_AWBURST),
        .M_AXI_awcache(m00_couplers_to_axi_interconnect_AWCACHE),
        .M_AXI_awid(m00_couplers_to_axi_interconnect_AWID),
        .M_AXI_awlen(m00_couplers_to_axi_interconnect_AWLEN),
        .M_AXI_awlock(m00_couplers_to_axi_interconnect_AWLOCK),
        .M_AXI_awprot(m00_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awqos(m00_couplers_to_axi_interconnect_AWQOS),
        .M_AXI_awready(m00_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awregion(m00_couplers_to_axi_interconnect_AWREGION),
        .M_AXI_awsize(m00_couplers_to_axi_interconnect_AWSIZE),
        .M_AXI_awvalid(m00_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bid(m00_couplers_to_axi_interconnect_BID),
        .M_AXI_bready(m00_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rid(m00_couplers_to_axi_interconnect_RID),
        .M_AXI_rlast(m00_couplers_to_axi_interconnect_RLAST),
        .M_AXI_rready(m00_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wlast(m00_couplers_to_axi_interconnect_WLAST),
        .M_AXI_wready(m00_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m00_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m00_couplers_ARCACHE),
        .S_AXI_arid(xbar_to_m00_couplers_ARID),
        .S_AXI_arlen(xbar_to_m00_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m00_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m00_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m00_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m00_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m00_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m00_couplers_AWCACHE),
        .S_AXI_awid(xbar_to_m00_couplers_AWID),
        .S_AXI_awlen(xbar_to_m00_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m00_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m00_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m00_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m00_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bid(xbar_to_m00_couplers_BID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rid(xbar_to_m00_couplers_RID),
        .S_AXI_rlast(xbar_to_m00_couplers_RLAST),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m00_couplers_WLAST),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  s00_couplers_imp_KAT6VS s00_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s00_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s00_couplers_to_xbar_ARCACHE),
        .M_AXI_arid(s00_couplers_to_xbar_ARID),
        .M_AXI_arlen(s00_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s00_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s00_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s00_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s00_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s00_couplers_to_xbar_AWCACHE),
        .M_AXI_awid(s00_couplers_to_xbar_AWID),
        .M_AXI_awlen(s00_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s00_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s00_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s00_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bid(s00_couplers_to_xbar_BID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rid(s00_couplers_to_xbar_RID),
        .M_AXI_rlast(s00_couplers_to_xbar_RLAST),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s00_couplers_to_xbar_WLAST),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_to_s00_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_to_s00_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_to_s00_couplers_ARCACHE),
        .S_AXI_arid(axi_interconnect_to_s00_couplers_ARID),
        .S_AXI_arlen(axi_interconnect_to_s00_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_to_s00_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_to_s00_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_to_s00_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_to_s00_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s00_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_to_s00_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_to_s00_couplers_AWCACHE),
        .S_AXI_awid(axi_interconnect_to_s00_couplers_AWID),
        .S_AXI_awlen(axi_interconnect_to_s00_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_to_s00_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_to_s00_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_to_s00_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_to_s00_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_to_s00_couplers_AWVALID),
        .S_AXI_bid(axi_interconnect_to_s00_couplers_BID),
        .S_AXI_bready(axi_interconnect_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s00_couplers_RDATA),
        .S_AXI_rid(axi_interconnect_to_s00_couplers_RID),
        .S_AXI_rlast(axi_interconnect_to_s00_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s00_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_to_s00_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s00_couplers_WVALID));
  s01_couplers_imp_RGYEM2 s01_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s01_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s01_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s01_couplers_to_xbar_ARCACHE),
        .M_AXI_arid(s01_couplers_to_xbar_ARID),
        .M_AXI_arlen(s01_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s01_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s01_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s01_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s01_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s01_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s01_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s01_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s01_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s01_couplers_to_xbar_AWCACHE),
        .M_AXI_awid(s01_couplers_to_xbar_AWID),
        .M_AXI_awlen(s01_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s01_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s01_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s01_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s01_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s01_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s01_couplers_to_xbar_AWVALID),
        .M_AXI_bid(s01_couplers_to_xbar_BID),
        .M_AXI_bready(s01_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s01_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s01_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s01_couplers_to_xbar_RDATA),
        .M_AXI_rid(s01_couplers_to_xbar_RID),
        .M_AXI_rlast(s01_couplers_to_xbar_RLAST),
        .M_AXI_rready(s01_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s01_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s01_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s01_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s01_couplers_to_xbar_WLAST),
        .M_AXI_wready(s01_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s01_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s01_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_to_s01_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_to_s01_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_to_s01_couplers_ARCACHE),
        .S_AXI_arid(axi_interconnect_to_s01_couplers_ARID),
        .S_AXI_arlen(axi_interconnect_to_s01_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_to_s01_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_to_s01_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_to_s01_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_to_s01_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_to_s01_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_to_s01_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_to_s01_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s01_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_to_s01_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_to_s01_couplers_AWCACHE),
        .S_AXI_awid(axi_interconnect_to_s01_couplers_AWID),
        .S_AXI_awlen(axi_interconnect_to_s01_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_to_s01_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_to_s01_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_to_s01_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_to_s01_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_to_s01_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_to_s01_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_to_s01_couplers_AWVALID),
        .S_AXI_bid(axi_interconnect_to_s01_couplers_BID),
        .S_AXI_bready(axi_interconnect_to_s01_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s01_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s01_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s01_couplers_RDATA),
        .S_AXI_rid(axi_interconnect_to_s01_couplers_RID),
        .S_AXI_rlast(axi_interconnect_to_s01_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_to_s01_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s01_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s01_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s01_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_to_s01_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_to_s01_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s01_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s01_couplers_WVALID));
  s02_couplers_imp_86EZTO s02_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s02_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s02_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s02_couplers_to_xbar_ARCACHE),
        .M_AXI_arid(s02_couplers_to_xbar_ARID),
        .M_AXI_arlen(s02_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s02_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s02_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s02_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s02_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s02_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s02_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s02_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s02_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s02_couplers_to_xbar_AWCACHE),
        .M_AXI_awid(s02_couplers_to_xbar_AWID),
        .M_AXI_awlen(s02_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s02_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s02_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s02_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s02_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s02_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s02_couplers_to_xbar_AWVALID),
        .M_AXI_bid(s02_couplers_to_xbar_BID),
        .M_AXI_bready(s02_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s02_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s02_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s02_couplers_to_xbar_RDATA),
        .M_AXI_rid(s02_couplers_to_xbar_RID),
        .M_AXI_rlast(s02_couplers_to_xbar_RLAST),
        .M_AXI_rready(s02_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s02_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s02_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s02_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s02_couplers_to_xbar_WLAST),
        .M_AXI_wready(s02_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s02_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s02_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_to_s02_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_to_s02_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_to_s02_couplers_ARCACHE),
        .S_AXI_arid(axi_interconnect_to_s02_couplers_ARID),
        .S_AXI_arlen(axi_interconnect_to_s02_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_to_s02_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_to_s02_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_to_s02_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_to_s02_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_to_s02_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_to_s02_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_to_s02_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s02_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_to_s02_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_to_s02_couplers_AWCACHE),
        .S_AXI_awid(axi_interconnect_to_s02_couplers_AWID),
        .S_AXI_awlen(axi_interconnect_to_s02_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_to_s02_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_to_s02_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_to_s02_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_to_s02_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_to_s02_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_to_s02_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_to_s02_couplers_AWVALID),
        .S_AXI_bid(axi_interconnect_to_s02_couplers_BID),
        .S_AXI_bready(axi_interconnect_to_s02_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s02_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s02_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s02_couplers_RDATA),
        .S_AXI_rid(axi_interconnect_to_s02_couplers_RID),
        .S_AXI_rlast(axi_interconnect_to_s02_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_to_s02_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s02_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s02_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s02_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_to_s02_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_to_s02_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s02_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s02_couplers_WVALID));
  s03_couplers_imp_FCKDRY s03_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s03_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s03_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s03_couplers_to_xbar_ARCACHE),
        .M_AXI_arid(s03_couplers_to_xbar_ARID),
        .M_AXI_arlen(s03_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s03_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s03_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s03_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s03_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s03_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s03_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s03_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s03_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s03_couplers_to_xbar_AWCACHE),
        .M_AXI_awid(s03_couplers_to_xbar_AWID),
        .M_AXI_awlen(s03_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s03_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s03_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s03_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s03_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s03_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s03_couplers_to_xbar_AWVALID),
        .M_AXI_bid(s03_couplers_to_xbar_BID),
        .M_AXI_bready(s03_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s03_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s03_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s03_couplers_to_xbar_RDATA),
        .M_AXI_rid(s03_couplers_to_xbar_RID),
        .M_AXI_rlast(s03_couplers_to_xbar_RLAST),
        .M_AXI_rready(s03_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s03_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s03_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s03_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s03_couplers_to_xbar_WLAST),
        .M_AXI_wready(s03_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s03_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s03_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_to_s03_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_to_s03_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_to_s03_couplers_ARCACHE),
        .S_AXI_arid(axi_interconnect_to_s03_couplers_ARID),
        .S_AXI_arlen(axi_interconnect_to_s03_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_to_s03_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_to_s03_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_to_s03_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_to_s03_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_to_s03_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_to_s03_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_to_s03_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s03_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_to_s03_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_to_s03_couplers_AWCACHE),
        .S_AXI_awid(axi_interconnect_to_s03_couplers_AWID),
        .S_AXI_awlen(axi_interconnect_to_s03_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_to_s03_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_to_s03_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_to_s03_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_to_s03_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_to_s03_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_to_s03_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_to_s03_couplers_AWVALID),
        .S_AXI_bid(axi_interconnect_to_s03_couplers_BID),
        .S_AXI_bready(axi_interconnect_to_s03_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s03_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s03_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s03_couplers_RDATA),
        .S_AXI_rid(axi_interconnect_to_s03_couplers_RID),
        .S_AXI_rlast(axi_interconnect_to_s03_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_to_s03_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s03_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s03_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s03_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_to_s03_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_to_s03_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s03_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s03_couplers_WVALID));
  workgroup_read_interconnect_4_to_1_xbar_0 xbar
       (.aclk(axi_interconnect_ACLK_net),
        .aresetn(axi_interconnect_ARESETN_net),
        .m_axi_araddr(xbar_to_m00_couplers_ARADDR),
        .m_axi_arburst(xbar_to_m00_couplers_ARBURST),
        .m_axi_arcache(xbar_to_m00_couplers_ARCACHE),
        .m_axi_arid(xbar_to_m00_couplers_ARID),
        .m_axi_arlen(xbar_to_m00_couplers_ARLEN),
        .m_axi_arlock(xbar_to_m00_couplers_ARLOCK),
        .m_axi_arprot(xbar_to_m00_couplers_ARPROT),
        .m_axi_arqos(xbar_to_m00_couplers_ARQOS),
        .m_axi_arready(xbar_to_m00_couplers_ARREADY),
        .m_axi_arregion(xbar_to_m00_couplers_ARREGION),
        .m_axi_arsize(xbar_to_m00_couplers_ARSIZE),
        .m_axi_arvalid(xbar_to_m00_couplers_ARVALID),
        .m_axi_awaddr(xbar_to_m00_couplers_AWADDR),
        .m_axi_awburst(xbar_to_m00_couplers_AWBURST),
        .m_axi_awcache(xbar_to_m00_couplers_AWCACHE),
        .m_axi_awid(xbar_to_m00_couplers_AWID),
        .m_axi_awlen(xbar_to_m00_couplers_AWLEN),
        .m_axi_awlock(xbar_to_m00_couplers_AWLOCK),
        .m_axi_awprot(xbar_to_m00_couplers_AWPROT),
        .m_axi_awqos(xbar_to_m00_couplers_AWQOS),
        .m_axi_awready(xbar_to_m00_couplers_AWREADY),
        .m_axi_awregion(xbar_to_m00_couplers_AWREGION),
        .m_axi_awsize(xbar_to_m00_couplers_AWSIZE),
        .m_axi_awvalid(xbar_to_m00_couplers_AWVALID),
        .m_axi_bid(xbar_to_m00_couplers_BID),
        .m_axi_bready(xbar_to_m00_couplers_BREADY),
        .m_axi_bresp(xbar_to_m00_couplers_BRESP),
        .m_axi_bvalid(xbar_to_m00_couplers_BVALID),
        .m_axi_rdata(xbar_to_m00_couplers_RDATA),
        .m_axi_rid(xbar_to_m00_couplers_RID),
        .m_axi_rlast(xbar_to_m00_couplers_RLAST),
        .m_axi_rready(xbar_to_m00_couplers_RREADY),
        .m_axi_rresp(xbar_to_m00_couplers_RRESP),
        .m_axi_rvalid(xbar_to_m00_couplers_RVALID),
        .m_axi_wdata(xbar_to_m00_couplers_WDATA),
        .m_axi_wlast(xbar_to_m00_couplers_WLAST),
        .m_axi_wready(xbar_to_m00_couplers_WREADY),
        .m_axi_wstrb(xbar_to_m00_couplers_WSTRB),
        .m_axi_wvalid(xbar_to_m00_couplers_WVALID),
        .s_axi_araddr({s03_couplers_to_xbar_ARADDR,s02_couplers_to_xbar_ARADDR,s01_couplers_to_xbar_ARADDR,s00_couplers_to_xbar_ARADDR}),
        .s_axi_arburst({s03_couplers_to_xbar_ARBURST,s02_couplers_to_xbar_ARBURST,s01_couplers_to_xbar_ARBURST,s00_couplers_to_xbar_ARBURST}),
        .s_axi_arcache({s03_couplers_to_xbar_ARCACHE,s02_couplers_to_xbar_ARCACHE,s01_couplers_to_xbar_ARCACHE,s00_couplers_to_xbar_ARCACHE}),
        .s_axi_arid({1'b0,1'b0,s03_couplers_to_xbar_ARID,1'b0,1'b0,s02_couplers_to_xbar_ARID,1'b0,1'b0,s01_couplers_to_xbar_ARID,1'b0,1'b0,s00_couplers_to_xbar_ARID}),
        .s_axi_arlen({s03_couplers_to_xbar_ARLEN,s02_couplers_to_xbar_ARLEN,s01_couplers_to_xbar_ARLEN,s00_couplers_to_xbar_ARLEN}),
        .s_axi_arlock({s03_couplers_to_xbar_ARLOCK,s02_couplers_to_xbar_ARLOCK,s01_couplers_to_xbar_ARLOCK,s00_couplers_to_xbar_ARLOCK}),
        .s_axi_arprot({s03_couplers_to_xbar_ARPROT,s02_couplers_to_xbar_ARPROT,s01_couplers_to_xbar_ARPROT,s00_couplers_to_xbar_ARPROT}),
        .s_axi_arqos({s03_couplers_to_xbar_ARQOS,s02_couplers_to_xbar_ARQOS,s01_couplers_to_xbar_ARQOS,s00_couplers_to_xbar_ARQOS}),
        .s_axi_arready({s03_couplers_to_xbar_ARREADY,s02_couplers_to_xbar_ARREADY,s01_couplers_to_xbar_ARREADY,s00_couplers_to_xbar_ARREADY}),
        .s_axi_arsize({s03_couplers_to_xbar_ARSIZE,s02_couplers_to_xbar_ARSIZE,s01_couplers_to_xbar_ARSIZE,s00_couplers_to_xbar_ARSIZE}),
        .s_axi_arvalid({s03_couplers_to_xbar_ARVALID,s02_couplers_to_xbar_ARVALID,s01_couplers_to_xbar_ARVALID,s00_couplers_to_xbar_ARVALID}),
        .s_axi_awaddr({s03_couplers_to_xbar_AWADDR,s02_couplers_to_xbar_AWADDR,s01_couplers_to_xbar_AWADDR,s00_couplers_to_xbar_AWADDR}),
        .s_axi_awburst({s03_couplers_to_xbar_AWBURST,s02_couplers_to_xbar_AWBURST,s01_couplers_to_xbar_AWBURST,s00_couplers_to_xbar_AWBURST}),
        .s_axi_awcache({s03_couplers_to_xbar_AWCACHE,s02_couplers_to_xbar_AWCACHE,s01_couplers_to_xbar_AWCACHE,s00_couplers_to_xbar_AWCACHE}),
        .s_axi_awid({1'b0,1'b0,s03_couplers_to_xbar_AWID,1'b0,1'b0,s02_couplers_to_xbar_AWID,1'b0,1'b0,s01_couplers_to_xbar_AWID,1'b0,1'b0,s00_couplers_to_xbar_AWID}),
        .s_axi_awlen({s03_couplers_to_xbar_AWLEN,s02_couplers_to_xbar_AWLEN,s01_couplers_to_xbar_AWLEN,s00_couplers_to_xbar_AWLEN}),
        .s_axi_awlock({s03_couplers_to_xbar_AWLOCK,s02_couplers_to_xbar_AWLOCK,s01_couplers_to_xbar_AWLOCK,s00_couplers_to_xbar_AWLOCK}),
        .s_axi_awprot({s03_couplers_to_xbar_AWPROT,s02_couplers_to_xbar_AWPROT,s01_couplers_to_xbar_AWPROT,s00_couplers_to_xbar_AWPROT}),
        .s_axi_awqos({s03_couplers_to_xbar_AWQOS,s02_couplers_to_xbar_AWQOS,s01_couplers_to_xbar_AWQOS,s00_couplers_to_xbar_AWQOS}),
        .s_axi_awready({s03_couplers_to_xbar_AWREADY,s02_couplers_to_xbar_AWREADY,s01_couplers_to_xbar_AWREADY,s00_couplers_to_xbar_AWREADY}),
        .s_axi_awsize({s03_couplers_to_xbar_AWSIZE,s02_couplers_to_xbar_AWSIZE,s01_couplers_to_xbar_AWSIZE,s00_couplers_to_xbar_AWSIZE}),
        .s_axi_awvalid({s03_couplers_to_xbar_AWVALID,s02_couplers_to_xbar_AWVALID,s01_couplers_to_xbar_AWVALID,s00_couplers_to_xbar_AWVALID}),
        .s_axi_bid({s03_couplers_to_xbar_BID,s02_couplers_to_xbar_BID,s01_couplers_to_xbar_BID,s00_couplers_to_xbar_BID}),
        .s_axi_bready({s03_couplers_to_xbar_BREADY,s02_couplers_to_xbar_BREADY,s01_couplers_to_xbar_BREADY,s00_couplers_to_xbar_BREADY}),
        .s_axi_bresp({s03_couplers_to_xbar_BRESP,s02_couplers_to_xbar_BRESP,s01_couplers_to_xbar_BRESP,s00_couplers_to_xbar_BRESP}),
        .s_axi_bvalid({s03_couplers_to_xbar_BVALID,s02_couplers_to_xbar_BVALID,s01_couplers_to_xbar_BVALID,s00_couplers_to_xbar_BVALID}),
        .s_axi_rdata({s03_couplers_to_xbar_RDATA,s02_couplers_to_xbar_RDATA,s01_couplers_to_xbar_RDATA,s00_couplers_to_xbar_RDATA}),
        .s_axi_rid({s03_couplers_to_xbar_RID,s02_couplers_to_xbar_RID,s01_couplers_to_xbar_RID,s00_couplers_to_xbar_RID}),
        .s_axi_rlast({s03_couplers_to_xbar_RLAST,s02_couplers_to_xbar_RLAST,s01_couplers_to_xbar_RLAST,s00_couplers_to_xbar_RLAST}),
        .s_axi_rready({s03_couplers_to_xbar_RREADY,s02_couplers_to_xbar_RREADY,s01_couplers_to_xbar_RREADY,s00_couplers_to_xbar_RREADY}),
        .s_axi_rresp({s03_couplers_to_xbar_RRESP,s02_couplers_to_xbar_RRESP,s01_couplers_to_xbar_RRESP,s00_couplers_to_xbar_RRESP}),
        .s_axi_rvalid({s03_couplers_to_xbar_RVALID,s02_couplers_to_xbar_RVALID,s01_couplers_to_xbar_RVALID,s00_couplers_to_xbar_RVALID}),
        .s_axi_wdata({s03_couplers_to_xbar_WDATA,s02_couplers_to_xbar_WDATA,s01_couplers_to_xbar_WDATA,s00_couplers_to_xbar_WDATA}),
        .s_axi_wlast({s03_couplers_to_xbar_WLAST,s02_couplers_to_xbar_WLAST,s01_couplers_to_xbar_WLAST,s00_couplers_to_xbar_WLAST}),
        .s_axi_wready({s03_couplers_to_xbar_WREADY,s02_couplers_to_xbar_WREADY,s01_couplers_to_xbar_WREADY,s00_couplers_to_xbar_WREADY}),
        .s_axi_wstrb({s03_couplers_to_xbar_WSTRB,s02_couplers_to_xbar_WSTRB,s01_couplers_to_xbar_WSTRB,s00_couplers_to_xbar_WSTRB}),
        .s_axi_wvalid({s03_couplers_to_xbar_WVALID,s02_couplers_to_xbar_WVALID,s01_couplers_to_xbar_WVALID,s00_couplers_to_xbar_WVALID}));
endmodule
