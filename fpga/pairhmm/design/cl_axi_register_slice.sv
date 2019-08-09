//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_axi_register_slice.sv
// Description  : This is a wrapper module made to avoid the suffering of
//                having to connect a ton of signals.
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

module cl_axi_register_slice (
    input logic   aclk,
    input logic   aresetn,
    axi_if.slave  s_axi,
    axi_if.master m_axi
    );

    // AXI4 Register Slice for dma_pcis interface
    axi_register_slice PCI_AXL_REG_SLC (
        .aclk          (aclk),
        .aresetn       (aresetn),
        .s_axi_awid    (s_axi.awid),
        .s_axi_awaddr  (s_axi.awaddr),
        .s_axi_awlen   (s_axi.awlen),
        .s_axi_awvalid (s_axi.awvalid),
        .s_axi_awsize  (s_axi.awsize),
        .s_axi_awready (s_axi.awready),
        .s_axi_wdata   (s_axi.wdata),
        .s_axi_wstrb   (s_axi.wstrb),
        .s_axi_wlast   (s_axi.wlast),
        .s_axi_wvalid  (s_axi.wvalid),
        .s_axi_wready  (s_axi.wready),
        .s_axi_bid     (s_axi.bid),
        .s_axi_bresp   (s_axi.bresp),
        .s_axi_bvalid  (s_axi.bvalid),
        .s_axi_bready  (s_axi.bready),
        .s_axi_arid    (s_axi.arid),
        .s_axi_araddr  (s_axi.araddr),
        .s_axi_arlen   (s_axi.arlen),
        .s_axi_arvalid (s_axi.arvalid),
        .s_axi_arsize  (s_axi.arsize),
        .s_axi_arready (s_axi.arready),
        .s_axi_rid     (s_axi.rid),
        .s_axi_rdata   (s_axi.rdata),
        .s_axi_rresp   (s_axi.rresp),
        .s_axi_rlast   (s_axi.rlast),
        .s_axi_rvalid  (s_axi.rvalid),
        .s_axi_rready  (s_axi.rready),

        .m_axi_awid    (m_axi.awid),
        .m_axi_awaddr  (m_axi.awaddr),
        .m_axi_awlen   (m_axi.awlen),
        .m_axi_awvalid (m_axi.awvalid),
        .m_axi_awsize  (m_axi.awsize),
        .m_axi_awready (m_axi.awready),
        .m_axi_wdata   (m_axi.wdata),
        .m_axi_wstrb   (m_axi.wstrb),
        .m_axi_wvalid  (m_axi.wvalid),
        .m_axi_wlast   (m_axi.wlast),
        .m_axi_wready  (m_axi.wready),
        .m_axi_bresp   (m_axi.bresp),
        .m_axi_bvalid  (m_axi.bvalid),
        .m_axi_bid     (m_axi.bid),
        .m_axi_bready  (m_axi.bready),
        .m_axi_arid    (m_axi.arid),
        .m_axi_araddr  (m_axi.araddr),
        .m_axi_arlen   (m_axi.arlen),
        .m_axi_arsize  (m_axi.arsize),
        .m_axi_arvalid (m_axi.arvalid),
        .m_axi_arready (m_axi.arready),
        .m_axi_rid     (m_axi.rid),
        .m_axi_rdata   (m_axi.rdata),
        .m_axi_rresp   (m_axi.rresp),
        .m_axi_rlast   (m_axi.rlast),
        .m_axi_rvalid  (m_axi.rvalid),
        .m_axi_rready  (m_axi.rready)
        );

endmodule // cl_axi_register_slice
