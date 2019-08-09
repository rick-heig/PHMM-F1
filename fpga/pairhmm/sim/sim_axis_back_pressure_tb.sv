//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_axis_back_pressure_tb.sv
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

module sim_axis_back_pressure_tb;

    logic reset;
    logic clock = 'b0;

    // Clock generation
    always #5 clock <= ~clock;

    // Reset generation
    initial begin
        reset     <= 'b1;
        #50 reset <= 'b0;
    end

    axi_stream_simple_if axi_stream_bus_master (.aclk(clock));
    axi_stream_simple_if axi_stream_bus_slave  (.aclk(clock));

    // Transfer monitor
    always @(posedge clock) begin
        if (axi_stream_bus_master.tvalid && axi_stream_bus_master.tready) begin
            $display("Data transferred !");
        end
    end

    // Master simulation
    initial begin
        axi_stream_bus_master.tdata  = 'b0;
        axi_stream_bus_master.tvalid = 'b0;

        wait(!reset);

        @(posedge clock);

        // Master has data ready
        axi_stream_bus_master.tdata  <= 'b1;
        axi_stream_bus_master.tvalid <= 'b1;

        @(negedge clock);
        wait(axi_stream_bus_master.tready);
        @(posedge clock);
        axi_stream_bus_master.tdata  <= 'b0;
        axi_stream_bus_master.tvalid <= 'b0;

        // Master has new data ready
        @(posedge clock);
        @(posedge clock);
        axi_stream_bus_master.tdata  <= 'b10;
        axi_stream_bus_master.tvalid <= 'b1;

        @(negedge clock);
        wait(axi_stream_bus_master.tready);
        @(posedge clock);
        axi_stream_bus_master.tdata  <= 'b0;
        axi_stream_bus_master.tvalid <= 'b0;

        // Master has new data ready
        @(posedge clock);
        @(posedge clock);
        @(posedge clock);
        axi_stream_bus_master.tdata  <= 'b11;
        axi_stream_bus_master.tvalid <= 'b1;

        @(negedge clock);
        wait(axi_stream_bus_master.tready);
        @(posedge clock);
        axi_stream_bus_master.tdata  <= 'b0;
        axi_stream_bus_master.tvalid <= 'b0;
    end

    // Back pressure unit
    sim_axis_back_pressure_unit #(
        .MAX_DELAY_CYCLES(6)
        ) bpu (
        .clock_i(clock),
        .reset_i(reset),
        .axis_s(axi_stream_bus_master),
        .axis_m(axi_stream_bus_slave));

    // Slave simulation
    initial begin
        // Slave is always ready (and thus does not provide back-pressure)
        axi_stream_bus_slave.tready = 'b1;
    end

endmodule // sim_axis_back_pressure_tb
