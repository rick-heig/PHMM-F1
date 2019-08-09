//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_job_logger.sv
// Description  : This unit will log jobs created inside a dual ported BRAM.
//                The other side of this dual ported BRAM can then be read by
//                the PC through the main controller.
//
// Author       : Rick Wertenbroek
// Date         : 28.05.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    28.05.19           Creation
//-----------------------------------------------------------------------------

module cl_job_logger (
    input logic         clock_i,
    input logic         reset_i,

    axi_stream_generic_if job_bus,

    input  logic [10:0] bram_addr_i,
    output logic [31:0] bram_data_o
);

    localparam MAX_BRAM_INDEX = 511;

    logic [32*5-1:0]    bram_data;
    logic [8:0]         bram_index;
    logic               write_to_bram;

    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            write_to_bram <= '0;
            bram_index    <= '0;
        end else begin
            write_to_bram <= job_bus.tready && job_bus.tvalid;

            // The bram index will be updated one cycle after the write_to_bram signal
            // becomes active, this is the intended behavior.
            if (write_to_bram) begin
                if (bram_index <= MAX_BRAM_INDEX) begin
                    bram_index <= bram_index + 1;
                end else begin
                    bram_index <= '0;
                end
            end
        end
        bram_data <= {32'(job_bus.tdata.read_addr),
                      16'(job_bus.tdata.read_len_min_1),
                      16'(job_bus.tdata.hap_len_min_1),
                      32'(job_bus.tdata.hap_addr),
                      32'(job_bus.tdata.initial_condition)};
    end

    // Instanciate BRAM Block
    job_log_bram job_logger_bram_inst (
        .clka(clock_i),      // input wire clka
        .wea(write_to_bram), // input wire [0 : 0] wea
        .addra(bram_index),  // input wire [8 : 0] addra
        .dina(bram_data),    // input wire [127 : 0] dina
        .clkb(clock_i),      // input wire clkb
        .addrb(bram_addr_i), // input wire [10 : 0] addrb
        .doutb(bram_data_o)  // output wire [31 : 0] doutb
    );

endmodule // cl_job_logger
