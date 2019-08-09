//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_workgroup_tb.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 02.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    02.04.19           Creation
//-----------------------------------------------------------------------------

`timescale 1 ns / 1 ns

`include "cl_pairhmm_package.vh"

module sim_workgroup_tb;

    ///////////////
    // Constants //
    ///////////////

    // Two jobs
    const int  READ_LEN[2]   = {41, 6};
    const int  HAP_LEN[2]    = {41, 8};
    const int  READ_ADDR[2]  = {0, 64*1*6};
    const int  HAP_ADDR[2]   = {64*1*5, 64*1*11};
    //const byte bases[2][$]   = {"CCCTTGCATTTCCATATGGATTTTATAATCAGCCATGTCAA", "CCCTTG"};
    //const byte quals[2][$]   = {">=:>>>??>>>>>?=>===>=>>>>=??>=>>?>?>>>>??", ">=:>>>"};
    //const byte i_qual[2][$]  = {"IIIIIIIIIIDHHIIGHIIHHHDDIHGIIIIIIIIIIIIIK", "IIIIII"};
    //const byte d_qual[2][$]  = {"HHIIIIIIIICIIIIGGIIHHHBBIGGIHIIIIIIIIHIIJ", "HHIIII"};
    //const byte c_qual[2][$]  = {"+++++++++++++++++++++++++++++++++++++++++", "++++++"};
    //const byte h_bases[2][$] = {"CCCTTGCATTTCCATATGGACTTTATAATCAGCCATGTCAA", "CACCCTCA"};

    // The big sequence should yield : 6.95272e+32
    // The small sequence should yield : 3.14298e+31

    // TODO : Test jobs that use more than a single AXI word per sequence (i.e., more than 64 chars)

    /////////////
    // Signals //
    /////////////

    logic reset;
    logic clock = 'b0;
    logic start;
    logic [7:0] job_counter;
    logic [7:0] result_counter;

    localparam NUMBER_OF_JOBS = 2;

    // Two jobs
    PairHMMPackage::work_request_t request_sti[2] = {
        '{READ_ADDR[0] /* Read addr */,
          READ_LEN[0]-1 /* Read len-1 */,
          HAP_ADDR[0] /* Hap addr */,
          HAP_LEN[0]-1 /* Hap len-1 */,
          $shortrealtobits($bitstoshortreal('h7d7fffff) / shortreal'(HAP_LEN[0])) /* Initial condition */},
        '{READ_ADDR[1] /* Read addr */,
          READ_LEN[1]-1 /* Read len-1 */,
          HAP_ADDR[1] /* Hap addr */,
          HAP_LEN[1]-1 /* Hap len-1 */,
          $shortrealtobits($bitstoshortreal('h7d7fffff) / shortreal'(HAP_LEN[1])) /* Initial condition */}
                                                    }; // Initial condition is divided by hap length : (std::numeric_limits<float>::max() / 16) / hap_len

    ////////////
    // Busses //
    ////////////

    axi_stream_generic_if #(.T(PairHMMPackage::work_request_t))   job_bus ();
    axi_if                #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_bus ();
    axi_stream_generic_if #(.T(PairHMMPackage::final_result_t))   final_result_bus ();

    /////////////
    // Stimuli //
    /////////////

    // Clock generation
    always #5 clock <= ~clock;

    default clocking cb @(posedge clock);
    endclocking // cb

    task stimuli();

        reset <= 'b1;
        ##5;
        reset <= 'b0;
        ##3;
        start <= 'b1;
        ##1;
        start <= 'b0;

    endtask // stimuli

    initial begin
        stimuli();
    end

    // Select job data
    always_comb begin
        if (job_counter < NUMBER_OF_JOBS) begin
            job_bus.tdata <= request_sti[job_counter];
        end else begin
            job_bus.tdata <= '{default:'0};
        end
    end

    // Job counter and valid generation
    always_ff @(posedge clock) begin
        if (reset) begin
            job_counter    <= 0;
            job_bus.tvalid <= 'b0;
        end else begin

            // tvalid generation
            if (start) begin
                job_bus.tvalid <= 'b1;
            end else if ((job_counter == NUMBER_OF_JOBS-1) && (job_bus.tvalid && job_bus.tready)) begin
                job_bus.tvalid <= 'b0;
            end

            // Update job counter upon transfer
            if (job_bus.tvalid && job_bus.tready) begin
                job_counter <= job_counter + 1;
            end
        end // else: !if(reset)
    end // always_ff @

    // Result counter
    always_ff @(posedge clock) begin
        if (reset) begin
            result_counter <= 0;
        end else begin
            if (final_result_bus.tvalid && final_result_bus.tready) begin
                result_counter <= result_counter + 1;
            end
        end
    end

    // End of simulation
    initial begin
        final_result_bus.tready <= 1'b0;
        wait (final_result_bus.tvalid == 1'b1);
        #100;
        @(negedge clock);
        final_result_bus.tready <= 1'b1;

        wait (result_counter == NUMBER_OF_JOBS);
        $display("Done !");
        $finish;
    end

    /////////
    // DUT //
    /////////

    // Workgroup
    cl_pairhmm_workgroup #(
        .NUMBER_OF_WORKERS(2),
        .DEBUG_VERBOSITY(2),
        .WORKGROUP_ID(0)
    ) dut_pairhmm_workgroup (
        .clock_i(clock),
        .reset_i(reset),
        .job_bus(job_bus),
        .axi_master_bus(axi_bus),
        .final_result_bus(final_result_bus)
    );

    /////////////////////////
    // Simulation Entities //
    /////////////////////////

    // AXI Slave memory
    sim_axi_slave_memory #(
        .FILENAME("sim_memory_2.txt"),
        .ROM_LOG_DEPTH(8), // TODO Change to correct value
        .ADDRESS_OFFSET(0)
    ) axi_memory (
        .clock_i(clock),
        .reset_i(reset),
        .axi_bus(axi_bus)
    );

endmodule // sim_workgroup_tb
