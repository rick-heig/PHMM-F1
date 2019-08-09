//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_simple_rom_from_file_bram_interface.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 28.01.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    28.01.19           Creation
//-----------------------------------------------------------------------------

module sim_simple_rom_from_file_bram_interface #(
    parameter QUAL_OFFSET = 0,
    parameter FILENAME = "10s.in"
) (
    bram_t.slave_read bus
);

    localparam ROM_DEPTH = 2**$size(bus.read_addr);
    typedef logic [7:0] rom_entry_t;

    rom_entry_t rom [ROM_DEPTH-1:0];

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
            //$display("read %c", c);
            rom[counter] = c - QUAL_OFFSET;
            counter++;
        end
        while (1);
    end

    always_ff @(posedge bus.clock) begin
        // Read logic
        if (bus.read_en)
            bus.read_data <= rom[bus.read_addr];
    end

// Instantiation template for sim_simple_rom_from_file
/*
    sim_simple_rom_from_file_bram_interface #(
        .FILENAME("")
    ) your_instance_name (
        .bus()
    );
*/

endmodule // sim_simple_rom_from_file_bram_interface
