//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_axis_back_pressure_unit.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 19.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    19.03.19           Creation
//-----------------------------------------------------------------------------

module sim_axis_back_pressure_unit #(
    parameter DISPLAY_DEBUG_MESSAGES = 0,
    parameter MAX_DELAY_CYCLES = 10
) (
    input logic reset_i,
    input logic clock_i,
    axi_stream_simple_if.slave  axis_s,
    axi_stream_simple_if.master axis_m
);

    logic       ready_mask;

    always begin
        static int unsigned number_of_delay_cycles = 0;

        // Wait until the master asserts the valid signal
        ready_mask = 'b1;
        wait (axis_s.tvalid);

        // Apply the mask
        ready_mask = 'b0;
        number_of_delay_cycles = $urandom_range(MAX_DELAY_CYCLES);
        if (DISPLAY_DEBUG_MESSAGES) begin
            $display("Number of delay cycles : %d", number_of_delay_cycles);
        end

        // Wait a number of cycles
        repeat(number_of_delay_cycles) begin
            @(posedge clock_i);
        end

        // Remove the mask
        ready_mask = 'b1;
        @(posedge clock_i);
        @(negedge clock_i);
    end

    assign axis_m.tvalid = axis_s.tvalid & ready_mask;
    assign axis_s.tready = axis_m.tready & ready_mask;

    // Data passthrough
    assign axis_m.tdata  = axis_s.tdata;

endmodule // sim_axis_back_pressure_unit
