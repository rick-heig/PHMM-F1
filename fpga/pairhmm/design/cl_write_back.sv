//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_write_back.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 06.05.19
// Version      : 0.0
//
// Dependencies : cl_pairhmm_package.vh
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    06.05.19           Creation
//-----------------------------------------------------------------------------

// TODO : There is no error handling on the AXI Master bus (E.g., when BRESP is not OK)

`include "cl_pairhmm_package.vh"

module cl_write_back (
    input logic clock_i,
    input logic reset_i,

    // Control signals
    input logic        reset_wb_i,
    input logic [31:0] total_number_of_jobs_min_1_i,
    input logic [31:0] ddr4_result_offset_i,
    input logic        total_number_valid_i,

    // AXI-Stream Result Interface
    axi_stream_generic_if.slave axi_s_result_bus,

    // AXI to DDR4
    axi_if.master      axi_master_bus,

    // IRQ out
    output logic       irq_o
);

    /////////////
    // Signals //
    /////////////

    // Registers
    logic [31:0]       job_counter_s;
    logic [31:0]       total_number_of_jobs_min_1_s;
    logic [31:0]       ddr4_result_offset_s;

    logic              total_number_of_jobs_valid_s;

    logic              result_to_write_s;
    logic              write_request_to_send_s;
    logic              write_data_to_send_s;
    logic              waiting_write_response_s;

    PairHMMPackage::final_result_t result_reg_s;

    // Wires
    logic              getting_result_s;
    logic              write_request_accepted_s;
    logic              write_data_accepted_s;
    logic              write_response_received_s;
    logic              result_transfered_s;

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////
    assign axi_s_result_bus.tready   = !result_to_write_s;
    assign getting_result_s          = axi_s_result_bus.tready && axi_s_result_bus.tvalid;

    assign write_request_accepted_s  = axi_master_bus.awvalid && axi_master_bus.awready;
    assign write_data_accepted_s     = axi_master_bus.wvalid  && axi_master_bus.wready;
    assign write_response_received_s = axi_master_bus.bvalid && axi_master_bus.bready;

    // A results has been transfered to the DDR4 when there was a result to write and
    // the write request, write data have been sent and the write response received.
    assign result_transfered_s       = result_to_write_s && !write_request_to_send_s && !write_data_to_send_s && !waiting_write_response_s;

    // Generate IRQ pulse when the last data have been transfered.
    assign irq_o                     = total_number_of_jobs_valid_s && (job_counter_s == total_number_of_jobs_min_1_s) && result_transfered_s;

    ///////////////
    // Registers //
    ///////////////

    // Result register
    always_ff @(posedge clock_i) begin
        if (getting_result_s) begin
            result_reg_s <= axi_s_result_bus.tdata;
        end
    end

    // Job counter, resets when main controller resets this unit and increments
    // when a result is written to DDR4 memory
    always_ff @(posedge clock_i) begin
        if (reset_i || reset_wb_i) begin
            job_counter_s <= 0;
        end else begin
            if (result_transfered_s) begin
                job_counter_s <= job_counter_s + 1;
            end
        end
    end

    // Total number of jobs counter and ddr4 offset, register this info when the
    // main controller asserts the valid line.
    always_ff @(posedge clock_i) begin
        if (reset_i || reset_wb_i) begin
            ddr4_result_offset_s         <= ddr4_result_offset_i;
            total_number_of_jobs_valid_s <= 1'b0;
        end else if (total_number_valid_i) begin
            total_number_of_jobs_min_1_s <= total_number_of_jobs_min_1_i;
            total_number_of_jobs_valid_s <= 1'b1;
        end
    end

    always_ff @(posedge clock_i) begin
        if (reset_i || reset_wb_i) begin
            result_to_write_s        <= 'b0;
            write_request_to_send_s  <= 'b0;
            write_data_to_send_s     <= 'b0;
            waiting_write_response_s <= 'b0;
        end else begin
            if (getting_result_s) begin
                result_to_write_s        <= 'b1;
                write_request_to_send_s  <= 'b1;
                write_data_to_send_s     <= 'b1;
                waiting_write_response_s <= 'b1;
            end else begin
                // Done writing result
                if (result_transfered_s) begin
                    result_to_write_s <= 'b0;
                end

                // Write request was accepted
                if (write_request_accepted_s) begin
                    write_request_to_send_s <= 'b0;
                end

                // Write data was accepted
                if (write_data_accepted_s) begin
                    write_data_to_send_s <= 'b0;
                end

                // Write response received
                if (write_response_received_s) begin
                    waiting_write_response_s <= 'b0;
                end
            end
        end
    end

    ////////////////
    // AXI Master //
    ////////////////

    // We use this bus as an AXI lite interface (simple writes)
    assign axi_master_bus.awid    = '0;    // Not needed since we do a single write at a time
    //assign axi_master_bus.awaddr  = ddr4_result_offset_s + ((result_reg_s.id >> 4) << 6);  // This is offset + id + DDR4 bank offset
    assign axi_master_bus.awaddr  = ddr4_result_offset_s + {result_reg_s.id[$size(result_reg_s.id)-1:4], 6'b000000};  // This is offset + id + DDR4 bank offset
    assign axi_master_bus.awlen   = '0;    // Single transaction (burst length = 1)
    assign axi_master_bus.awsize  = 'b010; // Burst size : 4 bytes in transfer
    assign axi_master_bus.awburst = 'b01;  // Only INCR is supported by DDR4 controller
    assign axi_master_bus.awvalid = write_request_to_send_s;

    assign axi_master_bus.wid     = '0;    // Not needed since we do a single write at a time
    assign axi_master_bus.wdata   = {16{result_reg_s.result}};
    assign axi_master_bus.wstrb   = 'hF << (4*result_reg_s.id[3:0]);
    assign axi_master_bus.wlast   = 'b1;   // Single write, therefore wlast is always asserted
    assign axi_master_bus.wvalid  = write_data_to_send_s;

    assign axi_master_bus.bready  = 'b1; // We are always ready for the write response

    // This interface does not read
    assign axi_master_bus.arid    = '0;
    assign axi_master_bus.araddr  = '0;
    assign axi_master_bus.arlen   = '0;
    assign axi_master_bus.arsize  = '0;
    assign axi_master_bus.arburst = 'b01;
    assign axi_master_bus.arvalid = '0;

    assign axi_master_bus.rready  = 'b0;

endmodule // cl_write_back
