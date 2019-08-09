//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_stream_worker_tb.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 25.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    25.03.19           Creation
//-----------------------------------------------------------------------------

`timescale 1 ns / 1 ns

`include "cl_pairhmm_package.vh"

module sim_stream_worker_tb;

    ///////////////
    // Constants //
    ///////////////
    //const int  READ_LEN   = 41;
    //const int  HAP_LEN    = 41;
    //const byte bases[$]   = "CCCTTGCATTTCCATATGGATTTTATAATCAGCCATGTCAA";
    //const byte quals[$]   = ">=:>>>??>>>>>?=>===>=>>>>=??>=>>?>?>>>>??";
    //const byte i_qual[$]  = "IIIIIIIIIIDHHIIGHIIHHHDDIHGIIIIIIIIIIIIIK";
    //const byte d_qual[$]  = "HHIIIIIIIICIIIIGGIIHHHBBIGGIHIIIIIIIIHIIJ";
    //const byte c_qual[$]  = "+++++++++++++++++++++++++++++++++++++++++";
    //const byte h_bases[$] = "CCCTTGCATTTCCATATGGACTTTATAATCAGCCATGTCAA";
    const int  READ_LEN   = 6;
    const int  HAP_LEN    = 8;
    const byte bases[$]   = "CCCTTG";
    const byte quals[$]   = ">=:>>>";
    const byte i_qual[$]  = "IIIIII";
    const byte d_qual[$]  = "HHIIII";
    const byte c_qual[$]  = "++++++";
    const byte h_bases[$] = "CACCCTCA";

    /////////////
    // Signals //
    /////////////

    logic reset;
    logic clock = 'b0;

    PairHMMPackage::work_request_2_t request_sti =
        '{READ_LEN-1 /* Read len-1 */,
          HAP_LEN-1 /* Hap len-1 */,
          $shortrealtobits($bitstoshortreal('h7d7fffff) / shortreal'(HAP_LEN)) /* Initial condition */
         }; // Initial condition is divided by hap length : (std::numeric_limits<float>::max() / 16) / hap_len
    logic       start_sti = 'b0;
    logic       ready_obs;
    logic       done_obs;
    logic [7:0] tid_obs;

    PairHMMPackage::store_type_t stream_type_sti;
    PairHMMPackage::floating_point_t final_result_reg;

    ////////////
    // Busses //
    ////////////

    axi_stream_simple_if #(.WIDTH_IN_BYTES(4)) axis_bus            ();
    fifo_if #(.T(PairHMMPackage::request_t))   compute_request_bus (.clock(clock));
    fifo_if #(.T(PairHMMPackage::result_t))    compute_result_bus  (.clock(clock));
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) result_bus ();
    axi_stream_simple_if #(.WIDTH_IN_BYTES(2*$bits(PairHMMPackage::floating_point_t)/$bits(byte))) result_sum_bus ();
    axi_stream_simple_if #(.WIDTH_IN_BYTES($bits(PairHMMPackage::floating_point_t)/$bits(byte))) sum_result_bus ();

    /////////////
    // Stimuli //
    /////////////

    // Clock generation
    always #5 clock <= ~clock;

    default clocking cb @(posedge clock);
    endclocking // cb

    task stimuli();
        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_R;

        reset <= 'b1;
        ##5;
        reset <= 'b0;
        ##3;

        // Stream the read bases
        for (int i = 0; i < (READ_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {bases[i*4+3], bases[i*4+2], bases[i*4+1], bases[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_Q;
        ##1;

        // Stream the qualities
        for (int i = 0; i < (READ_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {quals[i*4+3], quals[i*4+2], quals[i*4+1], quals[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_I;
        ##1;

        // Stream the insertion qualities
        for (int i = 0; i < (READ_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {i_qual[i*4+3], i_qual[i*4+2], i_qual[i*4+1], i_qual[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_D;
        ##1;

        // Stream the deletion qualities
        for (int i = 0; i < (READ_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {d_qual[i*4+3], d_qual[i*4+2], d_qual[i*4+1], d_qual[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_C;
        ##1;

        // Stream the continuation qualities
        for (int i = 0; i < (READ_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {c_qual[i*4+3], c_qual[i*4+2], c_qual[i*4+1], c_qual[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_H;
        ##1;

        // Stream the haplotype bases
        for (int i = 0; i < (HAP_LEN+3) / 4; i++) begin
            axis_bus.tdata  <= {h_bases[i*4+3], h_bases[i*4+2], h_bases[i*4+1], h_bases[i*4]};
            axis_bus.tvalid <= 1'b1;
            ##1;
        end

        axis_bus.tdata  <= 'b0;
        axis_bus.tvalid <= 'b0;
        stream_type_sti <= PairHMMPackage::STORE_R; // default
        ##1;

        ##5;

        // Start the computation
        start_sti <= 'b1;
        wait (ready_obs == 1'b0);
        $display("Computation started !");
        start_sti <= 'b0;

    endtask // stimuli

    initial begin
        stimuli();
    end

    // Add some back-pressure on the result bus
    initial begin
        result_bus.tready <= 1'b0;
        wait (result_bus.tvalid == 1'b1);
        #100;
        @(negedge clock);
        result_bus.tready <= 1'b1;

        $display("Done !");
        @ (posedge clock);
        @ (posedge clock);
        $display("Final result : %g", $bitstoshortreal(final_result_reg));
    end

    /////////////////
    // Observation //
    /////////////////

    /* Accumulate the final result */
    always_ff @(posedge clock) begin
        if (reset) begin
            final_result_reg <= 0;
        end else begin
            if (result_bus.tvalid && result_bus.tready) begin
                final_result_reg <= result_bus.tdata;
            end
        end
    end

    //////////
    // DUTs //
    //////////

    // Worker
    cl_pairhmm_worker_stream #(
        .MAX_SEQUENCE_LENGTH(2048),
        .DEBUG_VERBOSITY(2),
        .WORKER_ID(0)
    ) dut_pairhmm_worker (
        .clock_i(clock),
        .reset_i(reset),
        .request_i(request_sti),
        .start_i(start_sti),
        .ready_o(ready_obs),
        .done_o(done_obs),
        .stream_in_bus(axis_bus.slave),
        .stream_type_i(stream_type_sti),
        .compute_request_bus(compute_request_bus),
        .compute_result_bus(compute_result_bus),
        .result_sum_bus(result_sum_bus),
        .sum_result_bus(sum_result_bus),
        .result_bus(result_bus),
        .tid(tid_obs)
    );

    // Compute Engine
    cl_compute_engine_wrapper compute_engine_inst (
        .clock_i(clock),
        .reset_i(reset),
        .compute_req_bus(compute_request_bus),
        .result_bus(compute_result_bus)
    );

    // Simulation FIFO
    PairHMMPackage::result_t result_fifo [$];

    always_comb begin
        compute_result_bus.full      <= 'b0;
        compute_result_bus.empty     <= (result_fifo.size) ? 1'b0 : 1'b1;
        compute_result_bus.read_data <= result_fifo[0];
    end

    always_ff @(posedge clock) begin
        if (compute_result_bus.write) begin
            result_fifo.push_back(compute_result_bus.write_data);
        end
        if (result_fifo.size && compute_result_bus.read) begin
            void'(result_fifo.pop_front());
        end
    end

    //// Sum engine (simulation)
    //assign result_sum_bus.tready = 1'b1; // always ready
    //
    //always_ff @(posedge clock) begin
    //    if (reset) begin
    //        sum_result_bus.tvalid <= 1'b0;
    //    end else begin
    //        sum_result_bus.tvalid <= result_sum_bus.tvalid;
    //    end
    //
    //    sum_result_bus.tdata <= $shortrealtobits(
    //                            $bitstoshortreal(result_sum_bus.tdata[32 +: 32]) +
    //                            $bitstoshortreal(result_sum_bus.tdata[0  +: 32])
    //                            );
    //end

    floating_point_sum_wrapper sum_engine (
        .M_AXIS_SUM_RESULT_tdata(sum_result_bus.tdata),
        .M_AXIS_SUM_RESULT_tready(sum_result_bus.tready),
        .M_AXIS_SUM_RESULT_tuser(),
        .M_AXIS_SUM_RESULT_tvalid(sum_result_bus.tvalid),
        .S_AXIS_A_tdata(result_sum_bus.tdata[32 +: 32]),
        .S_AXIS_A_tready(result_sum_bus.tready),
        .S_AXIS_A_tuser(tid_obs),
        .S_AXIS_A_tvalid(result_sum_bus.tvalid),
        .S_AXIS_B_tdata(result_sum_bus.tdata[0 +: 32]),
        .S_AXIS_B_tready(), // Should be the same as S_AXIS_A_tready
        .S_AXIS_B_tvalid(result_sum_bus.tvalid),
        .aclk(clock),
        .aresetn(~reset)
    );

endmodule // sim_stream_worker_tb
