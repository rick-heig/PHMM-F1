//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_single_element_fifo.sv
// Description  : Single Element FWFT FIFO
//                This is used to connect two elements that have incompatible
//                FIFO interfaces.
//
// Author       : Rick Wertenbroek
// Date         : 26.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    26.03.19           Creation
//-----------------------------------------------------------------------------

module cl_single_element_fifo #(
    parameter type T = logic
) (
    input logic clock_i,
    input logic reset_i,

    fifo_if.slave_write write_bus,
    fifo_if.slave_read  read_bus
);
    T     data_reg_s;
    logic full;

    ///////////////
    // Registers //
    ///////////////

    //initial begin
    //    assert (type(write_bus.write_data) == type(read_bus.read_data)) else $warning("Different read-write types.");
    //    assert (type(T) == type(write_bus.write_data)) else $warning("Incompatible types.");
    //end

    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            full <= 1'b0;
        end else begin
            if (write_bus.write) begin
                full <= 1'b1;
            end else if (read_bus.read) begin
                full <= 1'b0;
            end
        end

        // Writing a full FIFO will replace the data
        if (write_bus.write) begin
            data_reg_s <= write_bus.write_data;
        end
    end // always_ff @

    /////////////
    // Outputs //
    /////////////

    // The FIFO will be full if there is an element inside it, if it is being read
    // we consider it non-full since we can write a new element to it.
    assign write_bus.full     = full & ~read_bus.read;
    assign read_bus.empty     = ~full;
    assign read_bus.read_data = data_reg_s;

endmodule // cl_single_element_fifo
