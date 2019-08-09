//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_axi_lite_interconnect_1_to_4_wrapper.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 01.07.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    01.07.19           Creation
//-----------------------------------------------------------------------------

module cl_axi_lite_interconnect_1_to_4_wrapper (
    input logic        aclk,
    input logic        aresetn,
    axi_lite_if.slave  s00_axi_lite,
    axi_lite_if.master m00_axi_lite,
    axi_lite_if.master m01_axi_lite,
    axi_lite_if.master m02_axi_lite,
    axi_lite_if.master m03_axi_lite);

    (* dont_touch = "true" *) ocl_interconnect ocl_interconnect_wrapped
       (.ACLK(aclk),
        .ARESETN(aresetn),
        // Connection regexp (emacs) :
        // \.\([MS][0-9]+_AXI_LITE\)_\([^(),]*\)([^)]*) -> .\1_\2(\,(downcase \1).\2)

        .M00_AXI_LITE_araddr(m00_axi_lite.araddr),
        .M00_AXI_LITE_arprot(),
        .M00_AXI_LITE_arready(m00_axi_lite.arready),
        .M00_AXI_LITE_arvalid(m00_axi_lite.arvalid),
        .M00_AXI_LITE_awaddr(m00_axi_lite.awaddr),
        .M00_AXI_LITE_awprot(),
        .M00_AXI_LITE_awready(m00_axi_lite.awready),
        .M00_AXI_LITE_awvalid(m00_axi_lite.awvalid),
        .M00_AXI_LITE_bready(m00_axi_lite.bready),
        .M00_AXI_LITE_bresp(m00_axi_lite.bresp),
        .M00_AXI_LITE_bvalid(m00_axi_lite.bvalid),
        .M00_AXI_LITE_rdata(m00_axi_lite.rdata),
        .M00_AXI_LITE_rready(m00_axi_lite.rready),
        .M00_AXI_LITE_rresp(m00_axi_lite.rresp),
        .M00_AXI_LITE_rvalid(m00_axi_lite.rvalid),
        .M00_AXI_LITE_wdata(m00_axi_lite.wdata),
        .M00_AXI_LITE_wready(m00_axi_lite.wready),
        .M00_AXI_LITE_wstrb(m00_axi_lite.wstrb),

        .M00_AXI_LITE_wvalid(m00_axi_lite.wvalid),
        .M01_AXI_LITE_araddr(m01_axi_lite.araddr),
        .M01_AXI_LITE_arprot(),
        .M01_AXI_LITE_arready(m01_axi_lite.arready),
        .M01_AXI_LITE_arvalid(m01_axi_lite.arvalid),
        .M01_AXI_LITE_awaddr(m01_axi_lite.awaddr),
        .M01_AXI_LITE_awprot(),
        .M01_AXI_LITE_awready(m01_axi_lite.awready),
        .M01_AXI_LITE_awvalid(m01_axi_lite.awvalid),
        .M01_AXI_LITE_bready(m01_axi_lite.bready),
        .M01_AXI_LITE_bresp(m01_axi_lite.bresp),
        .M01_AXI_LITE_bvalid(m01_axi_lite.bvalid),
        .M01_AXI_LITE_rdata(m01_axi_lite.rdata),
        .M01_AXI_LITE_rready(m01_axi_lite.rready),
        .M01_AXI_LITE_rresp(m01_axi_lite.rresp),
        .M01_AXI_LITE_rvalid(m01_axi_lite.rvalid),
        .M01_AXI_LITE_wdata(m01_axi_lite.wdata),
        .M01_AXI_LITE_wready(m01_axi_lite.wready),
        .M01_AXI_LITE_wstrb(m01_axi_lite.wstrb),
        .M01_AXI_LITE_wvalid(m01_axi_lite.wvalid),

        .M02_AXI_LITE_araddr(m02_axi_lite.araddr),
        .M02_AXI_LITE_arprot(),
        .M02_AXI_LITE_arready(m02_axi_lite.arready),
        .M02_AXI_LITE_arvalid(m02_axi_lite.arvalid),
        .M02_AXI_LITE_awaddr(m02_axi_lite.awaddr),
        .M02_AXI_LITE_awprot(),
        .M02_AXI_LITE_awready(m02_axi_lite.awready),
        .M02_AXI_LITE_awvalid(m02_axi_lite.awvalid),
        .M02_AXI_LITE_bready(m02_axi_lite.bready),
        .M02_AXI_LITE_bresp(m02_axi_lite.bresp),
        .M02_AXI_LITE_bvalid(m02_axi_lite.bvalid),
        .M02_AXI_LITE_rdata(m02_axi_lite.rdata),
        .M02_AXI_LITE_rready(m02_axi_lite.rready),
        .M02_AXI_LITE_rresp(m02_axi_lite.rresp),
        .M02_AXI_LITE_rvalid(m02_axi_lite.rvalid),
        .M02_AXI_LITE_wdata(m02_axi_lite.wdata),
        .M02_AXI_LITE_wready(m02_axi_lite.wready),
        .M02_AXI_LITE_wstrb(m02_axi_lite.wstrb),
        .M02_AXI_LITE_wvalid(m02_axi_lite.wvalid),

        .M03_AXI_LITE_araddr(m03_axi_lite.araddr),
        .M03_AXI_LITE_arprot(),
        .M03_AXI_LITE_arready(m03_axi_lite.arready),
        .M03_AXI_LITE_arvalid(m03_axi_lite.arvalid),
        .M03_AXI_LITE_awaddr(m03_axi_lite.awaddr),
        .M03_AXI_LITE_awprot(),
        .M03_AXI_LITE_awready(m03_axi_lite.awready),
        .M03_AXI_LITE_awvalid(m03_axi_lite.awvalid),
        .M03_AXI_LITE_bready(m03_axi_lite.bready),
        .M03_AXI_LITE_bresp(m03_axi_lite.bresp),
        .M03_AXI_LITE_bvalid(m03_axi_lite.bvalid),
        .M03_AXI_LITE_rdata(m03_axi_lite.rdata),
        .M03_AXI_LITE_rready(m03_axi_lite.rready),
        .M03_AXI_LITE_rresp(m03_axi_lite.rresp),
        .M03_AXI_LITE_rvalid(m03_axi_lite.rvalid),
        .M03_AXI_LITE_wdata(m03_axi_lite.wdata),
        .M03_AXI_LITE_wready(m03_axi_lite.wready),
        .M03_AXI_LITE_wstrb(m03_axi_lite.wstrb),
        .M03_AXI_LITE_wvalid(m03_axi_lite.wvalid),

        .S00_AXI_LITE_araddr(s00_axi_lite.araddr),
        .S00_AXI_LITE_arprot('0),
        .S00_AXI_LITE_arready(s00_axi_lite.arready),
        .S00_AXI_LITE_arvalid(s00_axi_lite.arvalid),
        .S00_AXI_LITE_awaddr(s00_axi_lite.awaddr),
        .S00_AXI_LITE_awprot('0),
        .S00_AXI_LITE_awready(s00_axi_lite.awready),
        .S00_AXI_LITE_awvalid(s00_axi_lite.awvalid),
        .S00_AXI_LITE_bready(s00_axi_lite.bready),
        .S00_AXI_LITE_bresp(s00_axi_lite.bresp),
        .S00_AXI_LITE_bvalid(s00_axi_lite.bvalid),
        .S00_AXI_LITE_rdata(s00_axi_lite.rdata),
        .S00_AXI_LITE_rready(s00_axi_lite.rready),
        .S00_AXI_LITE_rresp(s00_axi_lite.rresp),
        .S00_AXI_LITE_rvalid(s00_axi_lite.rvalid),
        .S00_AXI_LITE_wdata(s00_axi_lite.wdata),
        .S00_AXI_LITE_wready(s00_axi_lite.wready),
        .S00_AXI_LITE_wstrb(s00_axi_lite.wstrb),
        .S00_AXI_LITE_wvalid(s00_axi_lite.wvalid));

endmodule // cl_axi_lite_interconnect_1_to_4_wrapper
