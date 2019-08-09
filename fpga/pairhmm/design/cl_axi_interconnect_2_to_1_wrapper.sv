//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_axi_interconnect_2_to_1_wrapper.sv
// Description  : A wrapper to group signals in interfaces.
//
// Author       : Rick Wertenbroek
// Date         : 16.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    16.04.19           Creation
//-----------------------------------------------------------------------------

module cl_axi_interconnect_2_to_1_wrapper (
    input logic   aclk,
    input logic   aresetn,
    axi_if.slave  s00_axi,
    axi_if.slave  s01_axi,
    axi_if.master m00_axi
    );

    (* dont_touch = "true" *) cl_axi_interconnect_2_to_1_bis cl_axi_interconnect_wrapped
        (
        .ACLK(aclk),
        .ARESETN(aresetn),
        // Connection regexp (emacs) :
        // \.\([MS][0-9]+_AXI\)_\([^(),]*\)(.*) -> .\1_\2(\,(downcase \1).\2)

        .M00_AXI_araddr(m00_axi.araddr),
        .M00_AXI_arburst(m00_axi.arburst),
        .M00_AXI_arcache(),
        .M00_AXI_arid(m00_axi.arid[7:0]),
        .M00_AXI_arlen(m00_axi.arlen),
        .M00_AXI_arlock(),
        .M00_AXI_arprot(),
        .M00_AXI_arqos(),
        .M00_AXI_arready(m00_axi.arready),
        .M00_AXI_arregion(),
        .M00_AXI_arsize(m00_axi.arsize),
        .M00_AXI_arvalid(m00_axi.arvalid),
        .M00_AXI_awaddr(m00_axi.awaddr),
        .M00_AXI_awburst(m00_axi.awburst),
        .M00_AXI_awcache(),
        .M00_AXI_awid(m00_axi.awid[7:0]),
        .M00_AXI_awlen(m00_axi.awlen),
        .M00_AXI_awlock(),
        .M00_AXI_awprot(),
        .M00_AXI_awqos(),
        .M00_AXI_awready(m00_axi.awready),
        .M00_AXI_awregion(),
        .M00_AXI_awsize(m00_axi.awsize),
        .M00_AXI_awvalid(m00_axi.awvalid),
        .M00_AXI_bid(m00_axi.bid),
        .M00_AXI_bready(m00_axi.bready),
        .M00_AXI_bresp(m00_axi.bresp),
        .M00_AXI_bvalid(m00_axi.bvalid),
        .M00_AXI_rdata(m00_axi.rdata),
        .M00_AXI_rid(m00_axi.rid),
        .M00_AXI_rlast(m00_axi.rlast),
        .M00_AXI_rready(m00_axi.rready),
        .M00_AXI_rresp(m00_axi.rresp),
        .M00_AXI_rvalid(m00_axi.rvalid),
        .M00_AXI_wdata(m00_axi.wdata),
        .M00_AXI_wlast(m00_axi.wlast),
        .M00_AXI_wready(m00_axi.wready),
        .M00_AXI_wstrb(m00_axi.wstrb),
        .M00_AXI_wvalid(m00_axi.wvalid),

        .S00_AXI_araddr(s00_axi.araddr),
        .S00_AXI_arburst(s00_axi.arburst),
        .S00_AXI_arcache(4'b11),
        .S00_AXI_arid(s00_axi.arid[6:0]),
        .S00_AXI_arlen(s00_axi.arlen),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot(3'b10),
        .S00_AXI_arqos(4'b0),
        .S00_AXI_arready(s00_axi.arready),
        .S00_AXI_arregion(4'b0),
        .S00_AXI_arsize(s00_axi.arsize),
        .S00_AXI_arvalid(s00_axi.arvalid),
        .S00_AXI_awaddr(s00_axi.awaddr),
        .S00_AXI_awburst(s00_axi.awburst),
        .S00_AXI_awcache(4'b11),
        .S00_AXI_awid(s00_axi.awid[6:0]),
        .S00_AXI_awlen(s00_axi.awlen),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot(3'b10),
        .S00_AXI_awqos(4'b0),
        .S00_AXI_awready(s00_axi.awready),
        .S00_AXI_awregion(4'b0),
        .S00_AXI_awsize(s00_axi.awsize),
        .S00_AXI_awvalid(s00_axi.awvalid),
        .S00_AXI_bid(s00_axi.bid[6:0]),
        .S00_AXI_bready(s00_axi.bready),
        .S00_AXI_bresp(s00_axi.bresp),
        .S00_AXI_bvalid(s00_axi.bvalid),
        .S00_AXI_rdata(s00_axi.rdata),
        .S00_AXI_rid(s00_axi.rid[6:0]),
        .S00_AXI_rlast(s00_axi.rlast),
        .S00_AXI_rready(s00_axi.rready),
        .S00_AXI_rresp(s00_axi.rresp),
        .S00_AXI_rvalid(s00_axi.rvalid),
        .S00_AXI_wdata(s00_axi.wdata),
        .S00_AXI_wlast(s00_axi.wlast),
        .S00_AXI_wready(s00_axi.wready),
        .S00_AXI_wstrb(s00_axi.wstrb),
        .S00_AXI_wvalid(s00_axi.wvalid),

        .S01_AXI_araddr(s01_axi.araddr),
        .S01_AXI_arburst(s01_axi.arburst),
        .S01_AXI_arcache(4'b11),
        .S01_AXI_arid(s01_axi.arid[6:0]),
        .S01_AXI_arlen(s01_axi.arlen),
        .S01_AXI_arlock(1'b0),
        .S01_AXI_arprot(3'b10),
        .S01_AXI_arqos(4'b0),
        .S01_AXI_arready(s01_axi.arready),
        .S01_AXI_arregion(4'b0),
        .S01_AXI_arsize(s01_axi.arsize),
        .S01_AXI_arvalid(s01_axi.arvalid),
        .S01_AXI_awaddr(s01_axi.awaddr),
        .S01_AXI_awburst(s01_axi.awburst),
        .S01_AXI_awcache(4'b11),
        .S01_AXI_awid(s01_axi.awid[6:0]),
        .S01_AXI_awlen(s01_axi.awlen),
        .S01_AXI_awlock(1'b0),
        .S01_AXI_awprot(3'b10),
        .S01_AXI_awqos(4'b0),
        .S01_AXI_awready(s01_axi.awready),
        .S01_AXI_awregion(4'b0),
        .S01_AXI_awsize(s01_axi.awsize),
        .S01_AXI_awvalid(s01_axi.awvalid),
        .S01_AXI_bid(s01_axi.bid[6:0]),
        .S01_AXI_bready(s01_axi.bready),
        .S01_AXI_bresp(s01_axi.bresp),
        .S01_AXI_bvalid(s01_axi.bvalid),
        .S01_AXI_rdata(s01_axi.rdata),
        .S01_AXI_rid(s01_axi.rid[6:0]),
        .S01_AXI_rlast(s01_axi.rlast),
        .S01_AXI_rready(s01_axi.rready),
        .S01_AXI_rresp(s01_axi.rresp),
        .S01_AXI_rvalid(s01_axi.rvalid),
        .S01_AXI_wdata(s01_axi.wdata),
        .S01_AXI_wlast(s01_axi.wlast),
        .S01_AXI_wready(s01_axi.wready),
        .S01_AXI_wstrb(s01_axi.wstrb),
        .S01_AXI_wvalid(s01_axi.wvalid));

    assign s00_axi.bid[15:7]  = 'b0;
    assign s00_axi.rid[15:7]  = 'b0;
    assign s01_axi.bid[15:7]  = 'b0;
    assign s01_axi.rid[15:7]  = 'b0;
    assign m00_axi.arid[15:8] = 'b0;
    assign m00_axi.awid[15:8] = 'b0;

endmodule // cl_axi_interconnect_2_to_1_wrapper
