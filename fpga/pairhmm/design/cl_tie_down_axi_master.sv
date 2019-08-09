//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_tie_down_axi_master.sv
// Description  : This modules just ties down an AXI master interface.
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

module cl_tie_down_axi_master (
    axi_if.master axi_master_bus);

    assign axi_master_bus.awid    = '0;
    assign axi_master_bus.awaddr  = '0;
    assign axi_master_bus.awlen   = '0;
    assign axi_master_bus.awsize  = '0;
    assign axi_master_bus.awburst = '0;
    assign axi_master_bus.awvalid = '0;
    assign axi_master_bus.wid     = '0;
    assign axi_master_bus.wdata   = '0;
    assign axi_master_bus.wstrb   = '0;
    assign axi_master_bus.wlast   = '0;
    assign axi_master_bus.wvalid  = '0;
    assign axi_master_bus.bready  = '1;
    assign axi_master_bus.arid    = '0;
    assign axi_master_bus.araddr  = '0;
    assign axi_master_bus.arlen   = '0;
    assign axi_master_bus.arsize  = '0;
    assign axi_master_bus.arburst = '0;
    assign axi_master_bus.arvalid = '0;
    assign axi_master_bus.rready  = '1;

    // Note : The ready signals are tied up so not to block the interface if for
    // any reason responses would arrive to this master.

endmodule // cl_tie_down_axi_master
