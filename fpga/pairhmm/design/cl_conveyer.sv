//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_conveyer.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 09.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    09.04.19           Creation
//-----------------------------------------------------------------------------

module cl_conveyer #(
    parameter type T = logic[7:0],
    parameter REG_VERSION = 1
) (
    // Standard signals
    input logic  clock_i,
    input logic  reset_i,
    // In High-Priority Stream
    input  T     in_hi_pri_tdata,
    input  logic in_hi_pri_tvalid,
    output logic in_hi_pri_tready,
    // In Low-Priority Stream
    input  T     in_lo_pri_tdata,
    input  logic in_lo_pri_tvalid,
    output logic in_lo_pri_tready,
    // Out High-Priority Stream
    output T     out_hi_pri_tdata,
    output logic out_hi_pri_tvalid,
    input  logic out_hi_pri_tready,
    // Out Low-Priority Stream
    output T     out_lo_pri_tdata,
    output logic out_lo_pri_tvalid,
    input  logic out_lo_pri_tready
);

    /////////////
    // Signals //
    /////////////

    T            reg_data;
    logic        reg_empty;
    logic        fill_reg;
    logic        transfer_out;
    logic        reg_tready;
    logic        reg_tvalid;

    logic        in_tvalid;
    logic        out_tready;

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // At least one input is valid
    assign in_tvalid = in_hi_pri_tvalid || in_lo_pri_tvalid;

    // At least one output is ready
    assign out_tready = out_hi_pri_tready || out_lo_pri_tready;

    // Fill the register if the register is ready and the input is valid
    assign fill_reg = reg_tready && in_tvalid;

    // Reg has valid data when not empty
    assign reg_tvalid = !reg_empty;

    // Chose between a "REG" version where ready is only asserted when the
    // register is empty and a "not REG" version where ready is also asserted
    // when a transfer will take place (means the register will be empty on the
    // next clock cycle if no input or filled with the new data).
    // The "not REG" version propagates the ready signals therefore it may not
    // be good for timings if the conveyer chains is long.
    // The "REG" version can only transfer data every two cycles at most
    // since it waits for the register to be empty. This version however does
    // not propagate a combinatorial signal and therefore can run at high
    // frequencies even for very long chains (since each stage is registered).
    //
    // Since these blocks have two inputs and two outputs you can run mix
    // between the two blocks and have, e.g., two long "REG" pipelines running
    // through a distance on the FPGA and merge into a smaller "not REG" chain.
    generate
        // In this version we only rely on the register being empty (register)
        if (REG_VERSION) begin
            assign reg_tready = reg_empty;
        // In this version we use the output's tready signal, this signal is
        // combinatorially propagated if we chain these conveyer blocks
        end else begin
            assign reg_tready = reg_empty || out_tready;
        end
    endgenerate

    // Transfer out of register when out is ready and register not empty
    assign transfer_out = reg_tvalid && out_tready;

    ///////////////
    // Registers //
    ///////////////

    // Data Register status
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            reg_empty <= 1'b1;
        end else begin
            if (fill_reg) begin
                reg_empty <= 1'b0;
            end else if (transfer_out) begin
                reg_empty <= 1'b1;
            end
        end
    end

    // Data Register
    always_ff @(posedge clock_i) begin
        if (fill_reg) begin
            if (in_hi_pri_tvalid) begin
                reg_data <= in_hi_pri_tdata;
            end else begin
                reg_data <= in_lo_pri_tdata;
            end
        end
    end

    /////////////
    // Outputs //
    /////////////

    // Ready for the high priority input
    assign in_hi_pri_tready = reg_tready;
    // We are only ready for the low priority input if we don't get data from the
    // high priority input
    assign in_lo_pri_tready = reg_tready && !in_hi_pri_tvalid;

    // Valid to the high priority output
    assign out_hi_pri_tvalid = reg_tvalid;
    // We are only valid to the low priority output if we don't transfer to the
    // high priority output
    assign out_lo_pri_tvalid = reg_tvalid && !out_hi_pri_tready;

    // Same data to both
    assign out_hi_pri_tdata = reg_data;
    assign out_lo_pri_tdata = reg_data;

endmodule // cl_conveyer
