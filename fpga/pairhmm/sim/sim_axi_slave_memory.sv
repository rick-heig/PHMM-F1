//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_axi_slave_memory.sv
// Description  : A very simple AXI slave memory for testing.
//                Reads contents from a file.
//                Does not support AXI writes and does not support bursts of
//                any kind.
//
// Author       : Rick Wertenbroek
// Date         : 05.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    05.03.19           Creation
//-----------------------------------------------------------------------------

module sim_axi_slave_memory #(
    parameter FILENAME       = "axi_memory.txt",
    parameter ROM_LOG_DEPTH  = 10,
    parameter ADDRESS_OFFSET = 0
) (
    input logic clock_i,
    input logic reset_i,
    axi_if.slave axi_bus
);

    localparam ROM_DEPTH = 2**ROM_LOG_DEPTH;
    typedef logic [511:0] rom_entry_t;

    rom_entry_t rom [ROM_DEPTH-1:0];

    axi_if #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_reg ();

    initial begin
        int  fd;
        byte c;
        int  bytes_read;
        int  counter;
        int  shift_counter;

        fd = $fopen(FILENAME, "r");

        counter = 0;

        do begin
            bytes_read = $fscanf(fd, "%c", c);
            if (bytes_read != 1) break;
            rom[counter][8*shift_counter+:8] = c;

            shift_counter++;
            if (shift_counter >= 64) begin
                shift_counter = 0;
                counter++;
            end
            if (counter >= ROM_DEPTH) break;
        end
        while (1);
    end

    // AXI arready generation
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
              axi_reg.arready <= 1'b0;
        end else begin
            if (~axi_reg.arready && axi_bus.arvalid) begin
                // indicates that the slave has acceped the valid read address
                axi_reg.arready <= 1'b1;
            end else begin
                axi_reg.arready <= 1'b0;
            end
        end
    end // always_ff @

    // AXI rvalid generation
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            axi_reg.rvalid <= 0;
        end else begin
            if (axi_reg.arready && axi_bus.arvalid && ~axi_reg.rvalid) begin
                // Valid read data is available at the read data bus
                axi_reg.rvalid <= 1'b1;
            end else if (axi_reg.rvalid && axi_bus.rready) begin
                // Read data is accepted by the master
                axi_reg.rvalid <= 1'b0;
            end
        end
    end

    // Output register
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            axi_reg.rdata <= 0;
        end else begin
            if (axi_reg.arready & axi_bus.arvalid & ~axi_reg.rvalid) begin
                axi_reg.rdata <= rom[axi_bus.araddr[$size(axi_bus.araddr)-1:6]];
            end
        end
    end

    /////////////
    // Outputs //
    /////////////

    assign axi_bus.awready = 'b1;
    assign axi_bus.wready  = 'b1;
    assign axi_bus.bid     = '0;
    assign axi_bus.bresp   = '0;
    assign axi_bus.bvalid  = 'b1;
    assign axi_bus.arready = axi_reg.arready;
    assign axi_bus.rid     = '0;
    assign axi_bus.rdata   = axi_reg.rdata;
    assign axi_bus.rresp   = 2'b0; // 'OKAY' response
    assign axi_bus.rlast   = 'b1;
    assign axi_bus.rvalid  = axi_reg.rvalid;

endmodule // sim_axi_slave_memory
