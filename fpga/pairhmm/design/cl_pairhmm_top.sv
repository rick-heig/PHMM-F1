//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_pairhmm_top.sv
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

module cl_pairhmm_top #(
    parameter logic [63:0] DDR4_MODULE_OFFSET = '0,
    parameter VERSION_MAGIC = 0,
    parameter NUMBER_OF_WORKGROUPS = 2,
    parameter NUMBER_OF_WORKERS_PER_WORKGROUP = 2,
    parameter DUMMY_WORKGROUP = 0,
    parameter DEBUG_COUNTERS = 1,
    parameter DEBUG_VERBOSITY = 0
) (
    // Standard signals
    input logic       clock_i,
    input logic       reset_i,
    // Interface from PC
    axi_lite_if.slave axi_lite_slave_control_bus,
    // Interface to DDR4
    axi_if.master     axi_master_to_ddr4,
    // Interrupt to PC
    output logic      interrupt_o
);

    ///////////////
    // Constants //
    ///////////////
    localparam TOTAL_NUMBER_OF_WORKERS = NUMBER_OF_WORKGROUPS * NUMBER_OF_WORKERS_PER_WORKGROUP;

    /////////////
    // Signals //
    /////////////
    logic        reset_wb_s;
    logic [31:0] total_number_of_jobs_min_1_s;
    logic [31:0] ddr4_result_offset_s;
    logic        total_number_valid_s;

    logic [31:0] axi_read_issued_counter;
    logic [31:0] axi_read_resp_counter;
    logic [31:0] axi_write_issued_counter;
    logic [31:0] axi_write_resp_counter;

    // Debug
    logic [31:0] job_bram_data;
    logic [10:0] job_bram_addr;

    ////////////
    // Busses //
    ////////////
    axi_stream_generic_if #(.T(PairHMMPackage::work_request_t)) job_bus [NUMBER_OF_WORKGROUPS+1] ();
    axi_stream_generic_if #(.T(PairHMMPackage::work_request_t)) job_to_worker_bus[NUMBER_OF_WORKGROUPS] ();
    axi_stream_generic_if #(.T(PairHMMPackage::work_request_t)) no_job_bus[NUMBER_OF_WORKGROUPS] ();

    axi_if #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_bus[NUMBER_OF_WORKGROUPS] ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) result_from_workgroup_bus[NUMBER_OF_WORKGROUPS] ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) result_bus[NUMBER_OF_WORKGROUPS] ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) no_result_bus ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) dead_end_bus[NUMBER_OF_WORKGROUPS] ();

    // FIFO busses
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) fifo_result_bus[NUMBER_OF_WORKGROUPS*NUMBER_OF_WORKERS_PER_WORKGROUP] ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) fifo_no_result_bus[NUMBER_OF_WORKGROUPS*NUMBER_OF_WORKERS_PER_WORKGROUP] ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t)) fifo_dead_end_bus[NUMBER_OF_WORKGROUPS*NUMBER_OF_WORKERS_PER_WORKGROUP] ();

    axi_if #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_read_bus ();
    axi_if #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_write_bus ();

    dbg_if dbg ();

    /////////////////////
    // Main Controller //
    /////////////////////
    cl_main_controller #(
        .VERSION_MAGIC(VERSION_MAGIC),
        .DEBUG_VERBOSITY(DEBUG_VERBOSITY)
    ) main_controller (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .axi_lite_slave_bus(axi_lite_slave_control_bus),
        .job_bus(job_bus[0]),
        .dbg(dbg),
        .bram_addr_o(job_bram_addr),
        .bram_data_i(job_bram_data),
        .reset_wb_o(reset_wb_s),
        .total_number_of_jobs_min_1_o(total_number_of_jobs_min_1_s),
        .ddr4_result_offset_o(ddr4_result_offset_s),
        .total_number_valid_o(total_number_valid_s)
    );

    ////////////////
    // WORKGROUPS //
    ////////////////

    // With job and result queues.
    genvar i;
    generate

        // Nothing comes from this bus
        assign no_result_bus.tvalid = 1'b0;

        for (i = 0; i < NUMBER_OF_WORKGROUPS; i++) begin

            // These are busses that are not used
            assign no_job_bus[i].tvalid = 1'b0;

            // Work "queue" (Conveyer belt, with loopback)
            if (i == 0) begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::work_request_t),
                    .REG_VERSION(1)
                ) job_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(job_bus[NUMBER_OF_WORKGROUPS]),
                    .in_lo_pri(job_bus[i]),
                    .out_hi_pri(job_to_worker_bus[i]),
                    .out_lo_pri(job_bus[i+1])
                );
            end else begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::work_request_t),
                    .REG_VERSION(1)
                ) job_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(no_job_bus[i]),
                    .in_lo_pri(job_bus[i]),
                    .out_hi_pri(job_to_worker_bus[i]),
                    .out_lo_pri(job_bus[i+1])
                );
            end


            // Workgroups
            if (DUMMY_WORKGROUP == 0) begin
                cl_pairhmm_workgroup #(
                    .NUMBER_OF_WORKERS(NUMBER_OF_WORKERS_PER_WORKGROUP),
                    .DEBUG_VERBOSITY(DEBUG_VERBOSITY)
                ) workgroup (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .job_bus(job_to_worker_bus[i]),
                    .axi_master_bus(axi_bus[i]),
                    .final_result_bus(result_from_workgroup_bus[i])
                );
            end else begin // This is only for testing/debug
                cl_dummy_workgroup #(
                    .take_jobs(1),
                    .handsoff_delay_in_cycles(10)
                ) workgroup (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .job_bus(job_to_worker_bus[i]),
                    .axi_master_bus(axi_bus[i]),
                    .final_result_bus(result_from_workgroup_bus[i])
                );
            end

            // This bus is a dead end, therefore it is never ready
            assign dead_end_bus[i].tready = 1'b0;

            // Result gathering "queue" (Conveyer belt)
            if (i == 0) begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::final_result_t),
                    .REG_VERSION(1)
                ) result_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(no_result_bus),
                    .in_lo_pri(result_from_workgroup_bus[i]),
                    .out_hi_pri(result_bus[i]),
                    .out_lo_pri(dead_end_bus[i])
                );
            end else begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::final_result_t),
                    .REG_VERSION(1)
                ) result_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(result_bus[i-1]),
                    .in_lo_pri(result_from_workgroup_bus[i]),
                    .out_hi_pri(result_bus[i]),
                    .out_lo_pri(dead_end_bus[i])
                );
            end
        end // for (i = 0; i < NUMBER_OF_WORKGROUPS; i++)

    //////////////////////
    // AXI Interconnect //
    //////////////////////

        // This is actually slower by more than a factor of 3 !
        // Tested 2 implementations (4 workgroups of 4 and 6 workers resp.)
        if (0) begin
        //if (NUMBER_OF_WORKGROUPS == 4) begin
            // 4 to 1 AXI interconnect IP
            cl_axi_interconnect_4_to_1_wrapper axi_interconnect (
                .aclk(clock_i),
                .aresetn(~reset_i),
                .s00_axi(axi_bus[0]),
                .s01_axi(axi_bus[1]),
                .s02_axi(axi_bus[2]),
                .s03_axi(axi_bus[3]),
                .m00_axi(axi_read_bus)
            );
        end else begin
            // The read arbiter is generic in the number of AXI interfaces but
            // is slower than the interconnect since the requests-response cycles
            // are exclusive.
            cl_axi_read_arbiter #(
                .NUMBER_OF_MASTERS(NUMBER_OF_WORKGROUPS)
            ) axi_interconnect (
                .clock_i(clock_i),
                .reset_i(reset_i),
                .axi_slave_bus(axi_bus),
                .axi_master_bus(axi_read_bus)
            );
        end

    ////////////////
    // Write Back //
    ////////////////

    // Small FIFO before the write back to avoid having stalling the workers.
    // This FIFO is made with "conveyer" modules, this is equivalent to a shift-register FIFO.
        for (i = 0; i < TOTAL_NUMBER_OF_WORKERS; i++) begin
            // A dead end is never ready
            assign fifo_dead_end_bus[i].tready = 1'b0;
            // No results from here
            assign fifo_no_result_bus[i].tvalid = 1'b0;

            if (i == 0) begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::final_result_t),
                    .REG_VERSION(0) // These can be locally close so no need for a register
                ) result_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(result_bus[NUMBER_OF_WORKGROUPS-1]),
                    .in_lo_pri(fifo_no_result_bus[i]),
                    .out_hi_pri(fifo_result_bus[i]),
                    .out_lo_pri(fifo_dead_end_bus[i])
                );
            end else begin
                cl_conveyer_axi_s #(
                    .T(PairHMMPackage::final_result_t),
                    .REG_VERSION(0) // These can be locally close so no need for a register
                ) result_conveyer_block (
                    .clock_i(clock_i),
                    .reset_i(reset_i),
                    .in_hi_pri(fifo_result_bus[i-1]),
                    .in_lo_pri(fifo_no_result_bus[i]),
                    .out_hi_pri(fifo_result_bus[i]),
                    .out_lo_pri(fifo_dead_end_bus[i])
                );
            end
        end
    endgenerate

    cl_write_back write_back(
        .clock_i(clock_i),
        .reset_i(reset_i),
        .reset_wb_i(reset_wb_s),
        .total_number_of_jobs_min_1_i(total_number_of_jobs_min_1_s),
        .ddr4_result_offset_i(ddr4_result_offset_s),
        .total_number_valid_i(total_number_valid_s),
        //.axi_s_result_bus(result_bus[NUMBER_OF_WORKGROUPS-1]),
        .axi_s_result_bus(fifo_result_bus[TOTAL_NUMBER_OF_WORKERS-1]),
        .axi_master_bus(axi_write_bus),
        .irq_o(interrupt_o)
    );

    /////////
    // AXI //
    /////////

    // Share the AXI access to DDR4 between reader and writer

    // Writer Side (Result Write-Back)
    assign axi_master_to_ddr4.awid    = axi_write_bus.awid;
    assign axi_master_to_ddr4.awaddr  = {DDR4_MODULE_OFFSET[63:32], axi_write_bus.awaddr[31:0]}; // Since the write bus uses 32-bit addresses internally and DDR4 modules are 16GB we can use concatenation instead of addition here.
    // assign axi_master_to_ddr4.awaddr  = DDR4_MODULE_OFFSET + axi_write_bus.awaddr;
    assign axi_master_to_ddr4.awlen   = axi_write_bus.awlen;
    assign axi_master_to_ddr4.awsize  = axi_write_bus.awsize;
    assign axi_master_to_ddr4.awburst = axi_write_bus.awburst;
    assign axi_master_to_ddr4.awvalid = axi_write_bus.awvalid;
    assign axi_write_bus.awready      = axi_master_to_ddr4.awready;

    //assign axi_master_to_ddr4.wid     = axi_write_bus.wid;
    assign axi_master_to_ddr4.wid     = '0;
    assign axi_master_to_ddr4.wdata   = axi_write_bus.wdata;
    assign axi_master_to_ddr4.wstrb   = axi_write_bus.wstrb;
    assign axi_master_to_ddr4.wlast   = axi_write_bus.wlast;
    assign axi_master_to_ddr4.wvalid  = axi_write_bus.wvalid;
    assign axi_write_bus.wready       = axi_master_to_ddr4.wready;

    assign axi_write_bus.bid          = axi_master_to_ddr4.bid;
    assign axi_write_bus.bresp        = axi_master_to_ddr4.bresp;
    assign axi_write_bus.bvalid       = axi_master_to_ddr4.bvalid;
    assign axi_master_to_ddr4.bready  = axi_write_bus.bready;

    // Reader Side (Getting Data for the Algorithm)
    assign axi_master_to_ddr4.arid    = axi_read_bus.arid;
    assign axi_master_to_ddr4.araddr  = {DDR4_MODULE_OFFSET[63:32], axi_read_bus.araddr[31:0]}; // Since the read bus uses 32-bit addresses internally and DDR4 modules are 16GB we can use concatenation instead of addition here.
    // assign axi_master_to_ddr4.araddr  = DDR4_MODULE_OFFSET + axi_read_bus.araddr;
    assign axi_master_to_ddr4.arlen   = axi_read_bus.arlen;
    assign axi_master_to_ddr4.arsize  = axi_read_bus.arsize;
    assign axi_master_to_ddr4.arburst = axi_read_bus.arburst;
    assign axi_master_to_ddr4.arvalid = axi_read_bus.arvalid;
    assign axi_read_bus.arready       = axi_master_to_ddr4.arready;

    assign axi_read_bus.rid           = axi_master_to_ddr4.rid;
    assign axi_read_bus.rdata         = axi_master_to_ddr4.rdata;
    assign axi_read_bus.rresp         = axi_master_to_ddr4.rresp;
    assign axi_read_bus.rlast         = axi_master_to_ddr4.rlast;
    assign axi_read_bus.rvalid        = axi_master_to_ddr4.rvalid;
    assign axi_master_to_ddr4.rready  = axi_read_bus.rready;

    // Tie Writer Unused Signals to 0
    assign axi_write_bus.arready      = '0;

    assign axi_write_bus.rid          = '0;
    assign axi_write_bus.rdata        = '0;
    assign axi_write_bus.rresp        = '0;
    assign axi_write_bus.rlast        = '0;
    assign axi_write_bus.rvalid       = '0;

    // Tie Read Unused Signals to 0
    assign axi_read_bus.awready       = '0;

    assign axi_read_bus.wready        = '0;

    assign axi_read_bus.bid           = '0;
    assign axi_read_bus.bresp         = '0;
    assign axi_read_bus.bvalid        = '0;

    ///////////
    // Debug //
    ///////////
    generate
        if (DEBUG_VERBOSITY) begin
            always @(posedge clock_i) begin
                if (result_bus[NUMBER_OF_WORKGROUPS-1].tvalid && result_bus[NUMBER_OF_WORKGROUPS-1].tready) begin
                    $display("Result with id : %d was written with result : %g", result_bus[NUMBER_OF_WORKGROUPS-1].tdata.id, $bitstoshortreal(result_bus[NUMBER_OF_WORKGROUPS-1].tdata.result));
                end
            end
        end
    endgenerate

    ////////////////////
    // Debug Counters //
    ////////////////////

    cl_job_logger cl_job_logger_inst (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .job_bus(job_bus[0]),
        .bram_addr_i(job_bram_addr),
        .bram_data_o(job_bram_data));

    generate if (DEBUG_COUNTERS) begin

        always_ff @(posedge clock_i) begin

            if (reset_i) begin
                dbg.axi_read_issued_counter     <= '0;
                dbg.axi_read_resp_counter       <= '0;
                dbg.axi_write_issued_counter    <= '0;
                dbg.axi_write_resp_counter      <= '0;

                dbg.number_of_jobs_created      <= '0;
                dbg.number_of_results_to_wb     <= '0;


            end else begin
                if (axi_master_to_ddr4.arready && axi_master_to_ddr4.arvalid) begin
                    dbg.axi_read_issued_counter <= dbg.axi_read_issued_counter + 1;
                end
                if (axi_master_to_ddr4.rready && axi_master_to_ddr4.rvalid) begin
                    dbg.axi_read_resp_counter <= dbg.axi_read_resp_counter + 1;
                end
                if (axi_master_to_ddr4.awready && axi_master_to_ddr4.awvalid) begin
                    dbg.axi_write_issued_counter <= dbg.axi_write_issued_counter + 1;
                end
                if (axi_master_to_ddr4.bready && axi_master_to_ddr4.bvalid) begin
                    dbg.axi_write_resp_counter <= dbg.axi_write_resp_counter + 1;
                end

                if (job_bus[0].tvalid && job_bus[0].tready) begin
                    dbg.number_of_jobs_created <= dbg.number_of_jobs_created + 1;
                end

                if (result_bus[NUMBER_OF_WORKGROUPS-1].tvalid && result_bus[NUMBER_OF_WORKGROUPS-1].tready) begin
                    dbg.number_of_results_to_wb <= dbg.number_of_results_to_wb + 1;
                end
            end
        end

    end else begin

        assign dbg.axi_read_issued_counter     = '0;
        assign dbg.axi_read_resp_counter       = '0;
        assign dbg.axi_write_issued_counter    = '0;
        assign dbg.axi_write_resp_counter      = '0;

        assign dbg.number_of_jobs_created      = '0;
        assign dbg.number_of_results_to_wb     = '0;
    end
    endgenerate

endmodule // cl_pairhmm_top
