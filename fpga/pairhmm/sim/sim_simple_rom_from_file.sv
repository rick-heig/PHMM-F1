//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_simple_rom_from_file.sv
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

module sim_simple_rom_from_file #(
    //parameter ROM_WIDTH = 64,
    parameter ROM_DEPTH = 2048,
    parameter FILENAME = "10s.in"
) (
    // Standard Signals
    input  logic                         clock_i,
    // Read port
    input  logic [$clog2(ROM_DEPTH)-1:0] addr_i,
    input  logic                         read_en_i,
    output logic [7:0]                   data_out_o
);

    localparam ROM_WIDTH = 8;
    logic [ROM_WIDTH-1:0] rom [ROM_DEPTH-1:0];
    
    initial begin
        int  fd;
        byte c;
        int  bytes_read;
        int  counter;
        
        fd = $fopen(FILENAME, "r");

        counter = 0;
        
        do begin
            bytes_read = $fscanf(fd, "%c", c);
            if (bytes_read != 1) break;
            $display("read %c", c);
            rom[counter] = c;
            counter++;
        end
        while (1);
    end
    
    always_ff @(posedge clock_i) begin
        // Read logic
        if (read_en_i)
            data_out_o <= rom[addr_i];
    end

// Instantiation template for sim_simple_rom_from_file
/*
    sim_simple_rom_from_file #(
        //.ROM_WIDTH(18),
        .ROM_DEPTH(1024),
        .FILENAME("")
    ) your_instance_name (
        .clock_i(),
        .addr_i(),
        .addr_i(),
        .read_en_i(),
        .data_out_o()
    );
*/

endmodule // cl_simple_dual_port_bram
