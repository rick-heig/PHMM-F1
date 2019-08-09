//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_axi_read_arbiter.sv
// Description  : This is a read-only AXI request arbiter.
//                It will accept read request from one of its masters in a
//                round-robin fashion. Since it is read-only no write requests
//                will be accepted. (A simulation warning should pop up).
//
// Author       : Rick Wertenbroek
// Date         : 10.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    10.04.19           Creation
//-----------------------------------------------------------------------------

// Note : TODO : This should use internal register stages in order to get better
// timings however this requires adding the bus parameters as generic parameters
// since we cannot dynamically extract them from the interfaces that are
// connected. The current version is simpler in that regard (It doesn't care
// about the bus width or address widths as long as they are the same for the
// masters and the slave).

module cl_axi_read_arbiter #(
    parameter NUMBER_OF_MASTERS = 2,
    parameter DEBUG_VERBOSITY = 0
) (
    // Shared clock (does not support different clocks)
    input logic clock_i,
    input logic reset_i,
    // Masters (should all have the same interface parameters as slave)
    axi_if.slave  axi_slave_bus[NUMBER_OF_MASTERS],
    // Shared Slave
    axi_if.master axi_master_bus
);
    /////////////
    // Signals //
    /////////////
    logic [$clog2(NUMBER_OF_MASTERS)-1:0] round_robin_counter;
    logic                                 arvalid_array[NUMBER_OF_MASTERS];
    logic [15:0]                          arid_array[NUMBER_OF_MASTERS];
    logic [63:0]                          araddr_array[NUMBER_OF_MASTERS];
    logic [7:0]                           arlen_array[NUMBER_OF_MASTERS];
    logic [2:0]                           arsize_array[NUMBER_OF_MASTERS];
    logic [1:0]                           arburst_array[NUMBER_OF_MASTERS];
    logic                                 rready_array[NUMBER_OF_MASTERS];

    logic                                 transaction_taking_place;
    logic                                 accept_transaction;
    logic                                 end_of_transaction;

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // We are read only, so tie everything related to the write requests to 0
    assign axi_master_bus.awid    = 0;
    assign axi_master_bus.awaddr  = 0;
    assign axi_master_bus.awlen   = 0;
    assign axi_master_bus.awsize  = 0;
    assign axi_master_bus.awburst = 0;
    assign axi_master_bus.awvalid = 0;

    assign axi_master_bus.wid     = 0;
    assign axi_master_bus.wdata   = 0;
    assign axi_master_bus.wstrb   = 0;
    assign axi_master_bus.wlast   = 0;
    assign axi_master_bus.wvalid  = 0;

    assign axi_master_bus.bready  = 0;

    // We accept a read transaction when there is no other transaction taking place and a master has a valid read request
    assign accept_transaction = !transaction_taking_place && arvalid_array[round_robin_counter];
    // The transaction takes end when the master bus provides the last read data element
    assign end_of_transaction = axi_master_bus.rvalid && axi_master_bus.rlast;

    //////////////////////////
    // Read Request Channel //
    //////////////////////////
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            axi_master_bus.arvalid   <= 1'b0;
            transaction_taking_place <= 1'b0;
        end else begin
            if (accept_transaction) begin
                axi_master_bus.arvalid   <= 1'b1;
                transaction_taking_place <= 1'b1;
            end else begin
                if (axi_master_bus.arready) begin
                    axi_master_bus.arvalid <= 1'b0;
                end
                if (end_of_transaction) begin
                    transaction_taking_place <= 1'b0;
                end
            end
        end

        if (accept_transaction) begin
            axi_master_bus.arid    <= arid_array[round_robin_counter];
            axi_master_bus.araddr  <= araddr_array[round_robin_counter];
            axi_master_bus.arlen   <= arlen_array[round_robin_counter];
            axi_master_bus.arsize  <= arsize_array[round_robin_counter];
            axi_master_bus.arburst <= arburst_array[round_robin_counter];
        end
    end

    /////////////////////////
    // Round Robin Counter //
    /////////////////////////
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            round_robin_counter <= 0;
        end else begin
            // We increment the round robin counter when there is no transaction taking place
            // or on the end of a transaction (otherwise it is possible that the last selected
            // master gets to send a request again).
            if (!transaction_taking_place || end_of_transaction) begin
                // Only increment if we are not currently accepting a transaction
                if (!accept_transaction) begin
                    // The number of masters is not necessarily a power of 2
                    if (round_robin_counter == (NUMBER_OF_MASTERS-1)) begin
                        round_robin_counter <= 0;
                    end else begin
                        round_robin_counter <= round_robin_counter + 1;
                    end
                end
            end
        end
    end

    genvar i;
    generate
        for (i = 0; i < NUMBER_OF_MASTERS; i++) begin
            ///////////
            // Write //
            ///////////

            // This is read only, we are never ready to accept a write request
            assign axi_slave_bus[i].awready = 1'b0;
            always @(posedge clock_i)
                assert (!axi_slave_bus[i].awvalid) else $warning("A master tries to write a read-only slave.");
            // This is read only, so we do not accept data
            assign axi_slave_bus[i].wready = 1'b0;
            always @(posedge clock_i)
                assert (!axi_slave_bus[i].wvalid) else $warning("A master tries to write data to a read-only slave.");

            // Therefore we provide no write response
            assign axi_slave_bus[i].bid    = 0;
            assign axi_slave_bus[i].bresp  = 0;
            assign axi_slave_bus[i].bvalid = 1'b0;

            //////////
            // Read //
            //////////

            // This is used because indexes to array of interfaces need to be constant
            assign arvalid_array[i] = axi_slave_bus[i].arvalid;
            assign arid_array[i]    = axi_slave_bus[i].arid;
            assign araddr_array[i]  = axi_slave_bus[i].araddr;
            assign arlen_array[i]   = axi_slave_bus[i].arlen;
            assign arsize_array[i]  = axi_slave_bus[i].arsize;
            assign arburst_array[i] = axi_slave_bus[i].arburst;
            assign rready_array[i]  = axi_slave_bus[i].rready;

            // Only ready to accept a single transaction at a time if there is not already a transaction taking place
            assign axi_slave_bus[i].arready = (i == round_robin_counter) ? !transaction_taking_place : 1'b0;

            // Share the same info to all busses
            assign axi_slave_bus[i].rid    = axi_master_bus.rid;
            assign axi_slave_bus[i].rdata  = axi_master_bus.rdata;
            assign axi_slave_bus[i].rresp  = axi_master_bus.rresp;
            assign axi_slave_bus[i].rlast  = axi_master_bus.rlast;

            // Only one slave has the valid signal active at the time
            assign axi_slave_bus[i].rvalid = (i == round_robin_counter) ? axi_master_bus.rvalid : 1'b0;
        end
    endgenerate

    assign axi_master_bus.rready = rready_array[round_robin_counter];

endmodule // cl_axi_read_arbiter
