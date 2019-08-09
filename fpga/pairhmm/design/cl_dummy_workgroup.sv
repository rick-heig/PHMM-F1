//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_dummy_workgroup.sv
// Description  : This is a dummy workgroup, it takes jobs and generates dummy
//                results.
//
// Author       : Rick Wertenbroek
// Date         : 29.05.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    29.05.19           Creation
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_dummy_workgroup #(
    parameter take_jobs = 1, // Can be changed so this does nothing
    parameter handsoff_delay_in_cycles = 0 // Should be less than 2^16
) (
    input logic clock_i,
    input logic reset_i,

    axi_stream_generic_if.slave job_bus,
    axi_if.master               axi_master_bus,

    axi_stream_generic_if.master final_result_bus
);

    typedef enum {IDLE, GOT_JOB, WAIT_DELAY} state_type_t;
    state_type_t state_reg, state_next;
    PairHMMPackage::work_request_t job;
    logic [15:0] delay_counter;

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////
    assign job_bus.tready                = ((state_reg == IDLE) && take_jobs) ? 'b1 : 'b0;
    assign final_result_bus.tvalid       = (state_reg == GOT_JOB) ? 'b1 : 'b0;
    assign final_result_bus.tdata.result = {16'hdead, job.id[15:0]};
    assign final_result_bus.tdata.id     = job.id;

    //////////
    // Regs //
    //////////
    always_ff @(posedge clock_i) begin
        if (job_bus.tvalid && job_bus.tready) begin
            job <= job_bus.tdata;
        end
    end

    always_ff @(posedge clock_i) begin
        if (state_reg == IDLE) begin
            delay_counter <= '0;
        end else begin
            if (state_reg == WAIT_DELAY) begin
                delay_counter <= delay_counter + 1;
            end
        end
    end

    /////////
    // FSM //
    /////////

    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            state_reg <= IDLE;
        end else begin
            state_reg <= state_next;
        end
    end

    always_comb begin

        state_next = state_reg;

        case (state_reg)
            IDLE: begin
                if (job_bus.tvalid && job_bus.tready) begin
                    state_next = GOT_JOB;
                end
            end

            GOT_JOB: begin
                if (final_result_bus.tready) begin
                    if (handsoff_delay_in_cycles > 0) begin
                        state_next = WAIT_DELAY;
                    end else begin
                        state_next = IDLE;
                    end
                end
            end

            WAIT_DELAY: begin
                if (delay_counter == (handsoff_delay_in_cycles-1)) begin
                    state_next = IDLE;
                end
            end

        endcase // case (state_reg)

    end // always_comb

    ////////////////////
    // AXI Master Bus //
    ////////////////////
    assign axi_master_bus.awid    = '0;
    assign axi_master_bus.awaddr  = '0;
    assign axi_master_bus.awlen   = '0;
    assign axi_master_bus.awsize  = '0;
    assign axi_master_bus.awburst = '0;
    assign axi_master_bus.awvalid = '0;

    assign axi_master_bus.wid     = '0;
    assign axi_master_bus.wdata   = '0;
    assign axi_master_bus.wstrb   = '0;
    assign axi_master_bus.wlast   = '0;
    assign axi_master_bus.wvalid  = '0;

    assign axi_master_bus.bready  = '0;

    assign axi_master_bus.arid    = '0;
    assign axi_master_bus.araddr  = '0;
    assign axi_master_bus.arlen   = '0;
    assign axi_master_bus.arsize  = '0;
    assign axi_master_bus.arburst = '0;
    assign axi_master_bus.arvalid = '0;

    assign axi_master_bus.rready  = '0;

endmodule // cl_dummy_workgroup
