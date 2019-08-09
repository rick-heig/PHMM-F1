//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_simple_bram_from_file.sv
// Description  : 
//
// Author       : Rick Wertenbroek
// Date         : 25.01.19
// Version      : 0.0
//
// Dependencies : 
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    25.01.19           Creation
//-----------------------------------------------------------------------------

module sim_simple_bram_from_file #(
    parameter RAM_WIDTH = 64,
    parameter RAM_DEPTH = 512
) (
    // Standard Signals
    input  logic                         clock_i,
    // Write port
    input  logic [$clog2(RAM_DEPTH)-1:0] addr_a_i,
    input  logic [RAM_WIDTH-1:0]         data_in_a_i,
    input  logic                         write_en_a_i,
    // Read port
    input  logic [$clog2(RAM_DEPTH)-1:0] addr_b_i,
    output logic [RAM_WIDTH-1:0]         data_out_b_o
);

    /* Warning : using
     * logic [RAM_DEPTH-1:0] [RAM_WIDTH-1:0] bram;
     * Will not generate BRAM in Vivado 2017.4 and
     * will be implemented with LUTs & FFs
     */
    logic [RAM_WIDTH-1:0] bram [RAM_DEPTH-1:0];

    always_ff @(posedge clock_i) begin
        // Write logic
        if (write_en_a_i)
            bram[addr_a_i] <= data_in_a_i;

        // Read logic
        data_out_b_o <= bram[addr_b_i];
    end

// Instantiation template for cl_simple_dual_port_bram
/*
    cl_simple_dual_port_bram #(
        .RAM_WIDTH(18),
        .RAM_DEPTH(1024)
    ) your_instance_name (
        .clock_i(),
        .addr_a_i(),
        .data_in_a_i(),
        .write_en_a_i(),
        .addr_b_i(),
        .data_out_b_o()
    );
*/

endmodule // cl_simple_dual_port_bram
