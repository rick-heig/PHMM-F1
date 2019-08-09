//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_zero_axi_lite_slave.sv
// Description  : This is a dummy slave that always will return 0
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

module cl_zero_axi_lite_slave (
    input logic aclk,
    input logic aresetn,
    axi_lite_if.slave axi_lite_slave_bus);

    // Write response (BVALID) register
    always_ff @(posedge aclk) begin
        if (!aresetn) begin
            axi_lite_slave_bus.bvalid <= 1'b0;
        end else begin
            if (axi_lite_slave_bus.awvalid) begin
                axi_lite_slave_bus.bvalid <= 1'b1;
            end
            else if (axi_lite_slave_bus.bvalid && axi_lite_slave_bus.bready) begin
                axi_lite_slave_bus.bvalid <= 1'b0;
            end
        end
    end

    // Always ready (so not to dead-lock the bus)
    // Writes are acknowledged but ignored
    assign axi_lite_slave_bus.awready = '1;
    assign axi_lite_slave_bus.wready  = '1;
    assign axi_lite_slave_bus.bresp   = '0;

    // Read response (RVALID) register
    always_ff @(posedge aclk) begin
        if (!aresetn) begin
            axi_lite_slave_bus.rvalid <= 1'b0;
        end else begin
            if (axi_lite_slave_bus.arvalid) begin
                axi_lite_slave_bus.rvalid <= 1'b1;
            end
            else if (axi_lite_slave_bus.rvalid && axi_lite_slave_bus.rready) begin
                axi_lite_slave_bus.rvalid <= 1'b0;
            end
        end
    end

    // Always ready (so not to dead-lock the bus)
    // Reads always give 0
    assign axi_lite_slave_bus.arready = '1;
    assign axi_lite_slave_bus.rdata   = '0;
    assign axi_lite_slave_bus.rresp   = '0;

    // Note : The write and read response could return SLVERR instead of OKAY,
    // but since this is a "zero" slave all reads return 0 and OKAY response.

endmodule // cl_zero_axi_lite_slave
