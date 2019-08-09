//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_pairhmm_workgroup.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 26.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    26.03.19           Creation
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

// This will be a simple one worker to one compute engine model for now
// Future implementations will have a "filler" worker who will use the free
// slots of the compute engines that are not used by the other workers

module cl_pairhmm_workgroup #(
    parameter MAX_SEQUENCE_LENGTH = 2048,
    parameter NUMBER_OF_WORKERS = 2, // Must be at least 2 for now
    parameter DEBUG_VERBOSITY = 0
) (
    input logic clock_i,
    input logic reset_i,

    axi_stream_generic_if.slave job_bus,
    axi_if.master               axi_master_bus,

    axi_stream_generic_if.master final_result_bus
);

    /////////////
    // Signals //
    /////////////
    PairHMMPackage::work_request_2_t request_s;
    logic       start_s[NUMBER_OF_WORKERS];
    logic       start_from_controller_s;
    logic [7:0] selected_worker_s;
    logic [7:0] round_robin_counter;
    logic       ready_s[NUMBER_OF_WORKERS-1:0];
    logic       done_s[NUMBER_OF_WORKERS];
    PairHMMPackage::store_type_t stream_type_s;
    logic [7:0] tid_s[NUMBER_OF_WORKERS];
    logic       tlast_s[NUMBER_OF_WORKERS];

    // Sum engine registers
    logic [$bits(PairHMMPackage::floating_point_t)*2-1:0] sum_engine_registers [NUMBER_OF_WORKERS];
    logic                                                 sum_engine_registers_full [NUMBER_OF_WORKERS];
    logic                                                 fill_sum_engine_registers [NUMBER_OF_WORKERS];
    logic                                                 sum_engine_registers_ready [NUMBER_OF_WORKERS];
    logic [7:0]                                           sum_engine_regs_tids [NUMBER_OF_WORKERS];
    logic [7:0]                                           sum_engine_tid_out;

    PairHMMPackage::id_t result_ids_from_workers[NUMBER_OF_WORKERS];

    ////////////
    // Busses //
    ////////////

    axi_stream_simple_if #(.WIDTH_IN_BYTES(4)) axis_stream_bus (.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES(4)) axis_bus[NUMBER_OF_WORKERS] (.aclk(clock_i));
    fifo_if #(.T(PairHMMPackage::request_t)) compute_request_bus[NUMBER_OF_WORKERS] (.clock(clock_i));
    fifo_if #(.T(PairHMMPackage::result_t))  compute_result_bus[NUMBER_OF_WORKERS]  (.clock(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) result_bus[NUMBER_OF_WORKERS] (.aclk(clock_i));
    PairHMMPackage::floating_point_t results_unpacked_if_tdata[NUMBER_OF_WORKERS];
    logic                            results_unpacked_if_tvalid[NUMBER_OF_WORKERS];

    axi_stream_simple_if #(.WIDTH_IN_BYTES(2*$bits(PairHMMPackage::floating_point_t)/$bits(byte))) result_sum_bus[NUMBER_OF_WORKERS] (.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) sum_result_bus[NUMBER_OF_WORKERS] (.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) sum_engine_operand_a_bus (.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) sum_engine_operand_b_bus (.aclk(clock_i));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) sum_engine_result_bus (.aclk(clock_i));


    ////////////////
    // Assertions //
    ////////////////
    initial begin
        assert (NUMBER_OF_WORKERS >= 2) else $error("A workgroup must have at least two workers.");
        assert (NUMBER_OF_WORKERS < 256) else $error("IDs are too short to have more than 256 workers.");
    end

    ////////////////
    // Controller //
    ////////////////
    cl_workgroup_controller #(
        .NUMBER_OF_WORKERS(NUMBER_OF_WORKERS),
        .DEBUG_VERBOSITY(DEBUG_VERBOSITY)
    ) workgroup_controller (
        .clock_i(clock_i),
        .reset_i(reset_i),
        .job_bus(job_bus),
        .axi_bus(axi_master_bus),
        .stream_out_bus(axis_stream_bus),
        .stream_type_o(stream_type_s),
        .request_o(request_s),
        .workers_ready_i(NUMBER_OF_WORKERS'(ready_s)),
        .start_o(start_from_controller_s),
        .selected_worker_o(selected_worker_s)
    );

    /////////////////////
    // Worker Generate //
    /////////////////////
    genvar i;
    generate
        // Workers are always ready
        assign axis_stream_bus.tready = 1'b1;

        for (i = 0; i < NUMBER_OF_WORKERS; i++) begin

            // Same data to all workers
            assign axis_bus[i].tdata      = axis_stream_bus.tdata;
            // Only valid to a single worker at a time
            assign axis_bus[i].tvalid     = (selected_worker_s == i) ? axis_stream_bus.tvalid : 1'b0;
            // Only start a single worker at a time
            assign start_s[i]             = (selected_worker_s == i) ? start_from_controller_s : 1'b0;

            // Worker
            cl_pairhmm_worker_stream #(
                .MAX_SEQUENCE_LENGTH(MAX_SEQUENCE_LENGTH),
                .DEBUG_VERBOSITY(DEBUG_VERBOSITY),
                .WORKER_ID(i)
            ) pairhmm_worker (
                .clock_i(clock_i),
                .reset_i(reset_i),
                .request_i(request_s),
                .start_i(start_s[i]),
                .ready_o(ready_s[i]),
                .done_o(done_s[i]),
                .stream_in_bus(axis_bus[i]),
                .stream_type_i(stream_type_s),
                .compute_request_bus(compute_request_bus[i]),
                .compute_result_bus(compute_result_bus[i]),
                .result_sum_bus(result_sum_bus[i]),
                .sum_result_bus(sum_result_bus[i]),
                .result_bus(result_bus[i]),
                .tid(tid_s[i]),
                .id(result_ids_from_workers[i])
            );

            assign result_bus[i].tready = (round_robin_counter == i) ? final_result_bus.tready : 1'b0;
            assign results_unpacked_if_tdata[i]  = result_bus[i].tdata;
            assign results_unpacked_if_tvalid[i] = result_bus[i].tvalid;
        end
    endgenerate

    ///////////////////
    // Compute Cores //
    ///////////////////
    generate
        logic [159:0] result_to_fifo [NUMBER_OF_WORKERS];
        logic [159:0] result_from_fifo [NUMBER_OF_WORKERS];

        for (i = 0; i < NUMBER_OF_WORKERS; i++) begin
            // Compute Engine
            cl_compute_engine_wrapper compute_engine_inst (
                .clock_i(clock_i),
                .reset_i(reset_i),
                .compute_req_bus(compute_request_bus[i]),
                .result_bus(compute_result_bus[i])
            );

            // FIFOs
            //cl_single_element_fifo #(
            //    .T(PairHMMPackage::result_t)
            //) compute_result_fifo (
            //    .clock_i(clock_i),
            //    .reset_i(reset_i),
            //    .write_bus(compute_result_bus[i]),
            //    .read_bus(compute_result_bus[i])
            //);

            // Serialize to vector
            assign result_to_fifo[i] = {compute_result_bus[i].write_data.match,
                                        compute_result_bus[i].write_data.insertion,
                                        compute_result_bus[i].write_data.deletion,
                                        compute_result_bus[i].write_data.temp_A,
                                        compute_result_bus[i].write_data.temp_B};

            // Deserialize to struct
            assign compute_result_bus[i].read_data = '{result_from_fifo[i][128 +:$bits(PairHMMPackage::floating_point_t)],
                                                       result_from_fifo[i][96  +:$bits(PairHMMPackage::floating_point_t)],
                                                       result_from_fifo[i][64  +:$bits(PairHMMPackage::floating_point_t)],
                                                       result_from_fifo[i][32  +:$bits(PairHMMPackage::floating_point_t)],
                                                       result_from_fifo[i][0   +:$bits(PairHMMPackage::floating_point_t)]};

            result_fifo compute_result_fifo (
                .clk(clock_i),
                .srst(reset_i),
                .din(result_to_fifo[i]),
                .wr_en(compute_result_bus[i].write),
                .rd_en(compute_result_bus[i].read),
                .dout(result_from_fifo[i]),
                .full(compute_result_bus[i].full),
                .empty(compute_result_bus[i].empty),
                .wr_rst_busy(),
                .rd_rst_busy()
            );

        end
    endgenerate

    ////////////////
    // Sum Engine //
    ////////////////
    generate
        // First register (goes into sum engine)
        assign sum_engine_operand_a_bus.tvalid = sum_engine_registers_full[0];
        assign sum_engine_operand_b_bus.tvalid = sum_engine_registers_full[0];
        assign sum_engine_operand_a_bus.tdata  = sum_engine_registers[0][32 +: 32];
        assign sum_engine_operand_b_bus.tdata  = sum_engine_registers[0][ 0 +: 32];

        // The workers are always ready
        assign sum_engine_result_bus.tready = 1'b1;

        // Shift register into the accumulator
        for (i = 0; i < NUMBER_OF_WORKERS; i++) begin
            // Data is passed to all workers
            assign sum_result_bus[i].tdata  = sum_engine_result_bus.tdata;
            // Valid only if the ID is that of the worker
            assign sum_result_bus[i].tvalid = (sum_engine_tid_out == i) ? sum_engine_result_bus.tvalid : 1'b0;

            // Special case (i = 0) First register
            if (i == 0) begin
                // Ready to get new data if data moves out or if not full
                assign sum_engine_registers_ready[0] = (sum_engine_operand_a_bus.tready && sum_engine_operand_b_bus.tready) || !sum_engine_registers_full[0];

            // Normal shift register case
            end else begin
                // Ready to get new data if data moves out or if not full
                assign sum_engine_registers_ready[i] = sum_engine_registers_ready[i-1] || !sum_engine_registers_full[i];
            end

            // Special case. Last register
            if (i == (NUMBER_OF_WORKERS-1)) begin
                // Will be filled if ready and the worker has data
                assign fill_sum_engine_registers[i] = sum_engine_registers_ready[i] && result_sum_bus[i].tvalid;
                // Show ready to worker if ready
                assign result_sum_bus[i].tready = sum_engine_registers_ready[i];

                // Data and full registers
                always_ff @(posedge clock_i) begin
                    if (reset_i) begin
                        sum_engine_registers_full[i] <= 'b0;
                    end else begin
                        sum_engine_registers_full[i] <= fill_sum_engine_registers[i];
                    end

                    if (fill_sum_engine_registers[i]) begin
                        sum_engine_registers[i] <= result_sum_bus[i].tdata;
                    end
                end

                // ID
                assign sum_engine_regs_tids[i] = i;

            // Normal shift register case
            end else begin
                // Will be filled if ready and either a worker of next register has data
                assign fill_sum_engine_registers[i] = sum_engine_registers_ready[i] && (result_sum_bus[i].tvalid || sum_engine_registers_full[i+1]);

                // Show ready to worker only if ready and won't take data from the next register
                assign result_sum_bus[i].tready = sum_engine_registers_ready[i] && !sum_engine_registers_full[i+1];

                // Data and full registers
                always_ff @(posedge clock_i) begin
                    if (reset_i) begin
                        sum_engine_registers_full[i] <= 'b0;
                    end else begin
                        sum_engine_registers_full[i] <= fill_sum_engine_registers[i];
                    end

                    if (fill_sum_engine_registers[i]) begin
                        // Next register has priority over worker
                        if (sum_engine_registers_full[i+1]) begin
                            sum_engine_registers[i] <= sum_engine_registers[i+1];
                            sum_engine_regs_tids[i] <= sum_engine_regs_tids[i+1];
                        end else begin
                            sum_engine_registers[i] <= result_sum_bus[i].tdata;
                            sum_engine_regs_tids[i] <= i;
                        end
                    end
                end
            end
        end
    endgenerate

    // The actual summing engine
    floating_point_sum_wrapper sum_engine (
        .M_AXIS_SUM_RESULT_tdata  (sum_engine_result_bus.tdata),
        .M_AXIS_SUM_RESULT_tready (sum_engine_result_bus.tready),
        .M_AXIS_SUM_RESULT_tuser  (sum_engine_tid_out),
        .M_AXIS_SUM_RESULT_tvalid (sum_engine_result_bus.tvalid),
        .S_AXIS_A_tdata           (sum_engine_operand_a_bus.tdata),
        .S_AXIS_A_tready          (sum_engine_operand_a_bus.tready),
        .S_AXIS_A_tuser           (sum_engine_regs_tids[0]),
        .S_AXIS_A_tvalid          (sum_engine_operand_a_bus.tvalid),
        .S_AXIS_B_tdata           (sum_engine_operand_b_bus.tdata),
        .S_AXIS_B_tready          (sum_engine_operand_b_bus.tready),
        .S_AXIS_B_tvalid          (sum_engine_operand_b_bus.tvalid),
        .aclk                     (clock_i),
        .aresetn                  (~reset_i)
    );

    //////////////////////
    // Final Result Bus //
    //////////////////////

    // Round-Robin counter
    always_ff @(posedge clock_i) begin
        if (reset_i) begin
            round_robin_counter <= 0;
        end else if (round_robin_counter == (NUMBER_OF_WORKERS-1)) begin
            round_robin_counter <= 0;
        end else begin
            round_robin_counter <= round_robin_counter + 1;
        end
    end

    assign final_result_bus.tvalid = results_unpacked_if_tvalid[round_robin_counter];

    // Result (Job) ID comes from worker
    assign final_result_bus.tdata  = '{results_unpacked_if_tdata[round_robin_counter], result_ids_from_workers[round_robin_counter]};

endmodule // cl_pairhmm_workgroup
