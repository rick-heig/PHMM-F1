//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : sim_pairhmm_top_tb.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 10.04.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    10.04.19           Creation
//-----------------------------------------------------------------------------

`timescale 1 ns / 1 ns

`include "cl_pairhmm_package.vh"

// Control registers
const int NUMBER_OF_READS_ADDR            = 'h1000;
const int NUMBER_OF_HAPS_ADDR             = 'h1004;
const int DDR4_OFFSET_ADDR                = 'h1008;
const int START_ADDR                      = 'h1FF0;

const int READ_READ_ADDR_BASE_ADDR        = 'h2000;
const int READ_READ_LEN_BASE_ADDR         = 'h4000;
const int HAP_HAP_ADDR_BASE_ADDR          = 'h6000;
const int HAP_HAP_LEN_BASE_ADDR           = 'h8000;
const int HAP_INITIAL_CONDITION_BASE_ADDR = 'hA000;

//`define LONG_JOBS

`ifdef LONG_JOBS
 `define JOB_FILENAME "sim_memory_top_long.txt"
 `define NUMBER_OF_READS 2
 `define NUMBER_OF_HAPS  2

// Read addresses
const int read_addresses[`NUMBER_OF_READS] = {0, 20*64}; // Long version
//const int read_addresses[`NUMBER_OF_READS]   = {0}; // Long version
// Read lengths
const int read_lengths[`NUMBER_OF_READS]   = {247, 190}; // Long version
//const int read_lengths[`NUMBER_OF_READS]     = {247}; // Long version
// Hap addresses
const int hap_addresses[`NUMBER_OF_HAPS]   = {35*64, 40*64}; // Long version
//const int hap_addresses[`NUMBER_OF_HAPS]     = {40*64}; // Long version
// Hap lengths
const int hap_lengths[`NUMBER_OF_HAPS]     = {262, 262}; // Long version
//const int hap_lengths[`NUMBER_OF_HAPS]       = {262}; // Long version

`else
 //`define JOB_FILENAME "sim_memory_top.txt"
 //`define NUMBER_OF_READS 2
 //`define NUMBER_OF_HAPS  2
 //`define JOB_FILENAME "sim_memory_job1_1.txt"
 //`define NUMBER_OF_READS 1
 //`define NUMBER_OF_HAPS  1
 `define JOB_FILENAME "sim_memory_job1_4.txt"
 `define NUMBER_OF_READS 2
 `define NUMBER_OF_HAPS  2

// Read addresses
//const int read_addresses[`NUMBER_OF_READS] = {0, 64*1*6};
//const int read_addresses[`NUMBER_OF_READS] = {0};
const int read_addresses[`NUMBER_OF_READS] = {0, 64*1*6};
// Read lengths
//const int read_lengths[`NUMBER_OF_READS]   = {41, 6};
//const int read_lengths[`NUMBER_OF_READS]   = {17};
const int read_lengths[`NUMBER_OF_READS]   = {41, 41};
// Hap addresses
//const int hap_addresses[`NUMBER_OF_HAPS]   = {64*1*5, 64*1*11};
//const int hap_addresses[`NUMBER_OF_HAPS]   = {64*1*5};
const int hap_addresses[`NUMBER_OF_HAPS]   = {64*1*5, 64*1*11};
// Hap lengths
//const int hap_lengths[`NUMBER_OF_HAPS]     = {41, 8};
//const int hap_lengths[`NUMBER_OF_HAPS]     = {41};
const int hap_lengths[`NUMBER_OF_HAPS]     = {41, 41};
`endif


class Command;
    logic [31:0] addr;
    logic [31:0] data;
endclass : Command

typedef mailbox #(Command) command_fifo_t;

///////////////
// Sequencer //
///////////////

class Sequencer;

    command_fifo_t sequencer_to_driver_fifo;

    task testcase;
        automatic Command command;

        // Write the number of reads (min 1)
        command = new;
        command.addr = NUMBER_OF_READS_ADDR;
        command.data = `NUMBER_OF_READS-1;
        sequencer_to_driver_fifo.put(command);

        // Write the number of haps (min 1)
        command = new;
        command.addr = NUMBER_OF_HAPS_ADDR;
        command.data = `NUMBER_OF_HAPS-1;
        sequencer_to_driver_fifo.put(command);

        // For each read
        for(int i = 0; i < `NUMBER_OF_READS; i++) begin
            // Write the address of the read
            command = new;
            command.addr = READ_READ_ADDR_BASE_ADDR + (i*4);
            command.data = read_addresses[i];
            sequencer_to_driver_fifo.put(command);
            // Write the length of the read minus 1
            command = new;
            command.addr = READ_READ_LEN_BASE_ADDR + (i*4);
            command.data = read_lengths[i]-1;
            sequencer_to_driver_fifo.put(command);
        end

        // For each hap
        for(int i = 0; i < `NUMBER_OF_HAPS; i++) begin
            // Write the address of the hap
            command = new;
            command.addr = HAP_HAP_ADDR_BASE_ADDR + (i*4);
            command.data = hap_addresses[i];
            sequencer_to_driver_fifo.put(command);
            // Write the length of the read minus 1
            command = new;
            command.addr = HAP_HAP_LEN_BASE_ADDR + (i*4);
            command.data = hap_lengths[i]-1;
            sequencer_to_driver_fifo.put(command);
            // Write the initial condition
            command = new;
            command.addr = HAP_INITIAL_CONDITION_BASE_ADDR + (i*4);
            command.data = $shortrealtobits($bitstoshortreal('h7d7fffff) / shortreal'(hap_lengths[i]));
            sequencer_to_driver_fifo.put(command);
        end

        // Write the DDR4 offset
        command = new;
        command.addr = DDR4_OFFSET_ADDR;
        command.data = 'h4000; // Put it somewhere
        sequencer_to_driver_fifo.put(command);

        // Start the machinery
        command = new;
        command.addr = START_ADDR;
        command.data = 1; // Anything will do
        sequencer_to_driver_fifo.put(command);

    endtask : testcase

    task run;
        $display("Sequencer : start");
        testcase();
    endtask : run

endclass : Sequencer

class Driver;

    command_fifo_t sequencer_to_driver_fifo;

    virtual axi_lite_if command_bus;

    task drive_command(Command command);
        /* Write */
        @(posedge command_bus.aclk);

        command_bus.awaddr  <= command.addr;
        command_bus.awvalid <= 1;

        wait(command_bus.awready == 1);

        @(posedge command_bus.aclk);
        command_bus.awvalid <= 0;

        @(posedge command_bus.aclk);
        command_bus.wvalid <= 1;
        command_bus.wdata  <= command.data;

        wait(command_bus.wready == 1);

        @(posedge command_bus.aclk);
        command_bus.wvalid <= 0;

        wait(command_bus.bvalid == 1);
        wait(command_bus.bvalid == 0);
    endtask

    task run;
        automatic Command command;
        command = new;
        $display("Driver : start");

        /* Default values, IDLE state */
        command_bus.awaddr  <= '0;
        command_bus.awvalid <= '0;
        command_bus.wdata   <= '0;
        command_bus.wstrb   <= '1;
        command_bus.wvalid  <= '0;
        command_bus.bready  <= '1;
        command_bus.araddr  <= '0;
        command_bus.arvalid <= '0;
        command_bus.rready  <= '0;
        wait(command_bus.aresetn == 1);
        @(posedge command_bus.aclk);
        @(posedge command_bus.aclk);
        @(posedge command_bus.aclk);

        forever begin
            sequencer_to_driver_fifo.get(command);
            drive_command(command);
            $display("Driver : Has driven a packet");
        end

        // Will not end
        $display("Driver : end");
    endtask : run

endclass : Driver

class Environment;

    Sequencer sequencer;
    Driver    driver;

    virtual axi_lite_if command_bus;

    command_fifo_t sequencer_to_driver_fifo;

    task build;
        sequencer_to_driver_fifo = new(10);

        sequencer = new;
        driver    = new;

        driver.command_bus = command_bus;

        sequencer.sequencer_to_driver_fifo = sequencer_to_driver_fifo;
        driver.sequencer_to_driver_fifo    = sequencer_to_driver_fifo;

    endtask : build

    task timeout;
        /* TODO : Set value */
        #100000000;
        $error("Timeout reached");
    endtask : timeout

    /* Launch the sequencer */
    task do_sequencing;
        fork
            sequencer.run();
        join;
    endtask : do_sequencing

    task run;
        fork
            /* These tasks run forever */
            driver.run();
        join_none;

        fork
            /* The first task will stimulate the DUV and verify the output */
            do_sequencing();
            /* The second task is a timeout, the first task may wait forever
             * e.g. if the DUV never generates an output */
            timeout();
        join_any;

    endtask : run

endclass : Environment

typedef class Environment;

module sim_pairhmm_top_tb;
    logic reset;
    logic clock = 0;

    // Environment
    Environment env;

    ////////////
    // Busses //
    ////////////
    axi_lite_if #(.WIDTH_IN_BYTES(4), .ADDR_WIDTH(32))  axi_control_bus ();
    axi_if      #(.WIDTH_IN_BYTES(64), .ADDR_WIDTH(64)) axi_ddr4_bus ();

    /////////////
    // Stimuli //
    /////////////

    // Clock generation
    always #5 clock <= ~clock;
    task reset_gen();
        reset <= 'b1;
        #100;
        reset <= 'b0;
    endtask // reset_gen

    assign axi_control_bus.aclk    = clock;
    assign axi_control_bus.aresetn = ~reset;

    // Stimulation
    initial begin
        env = new;

        fork
            reset_gen();
        join_none;

        env.command_bus = axi_control_bus;
        env.build();
        env.run();
        //$finish;
    end

    /////////
    // DUT //
    /////////

    // PairHMM Top Module
    cl_pairhmm_top #(
        .NUMBER_OF_WORKGROUPS(1),
        .NUMBER_OF_WORKERS_PER_WORKGROUP(1),
        .DEBUG_VERBOSITY(1)
    ) dut (
        .clock_i(clock),
        .reset_i(reset),
        .axi_lite_slave_control_bus(axi_control_bus),
        .axi_master_to_ddr4(axi_ddr4_bus),
        .interrupt_o()
    );

    ////////////////////////
    // Simulation Modules //
    ////////////////////////

    // AXI Slave memory
    sim_axi_slave_memory #(
        //.FILENAME("sim_memory_top.txt"),
        .FILENAME(`JOB_FILENAME),
        .ROM_LOG_DEPTH(20), // TODO Change to correct value
        .ADDRESS_OFFSET(0)
    ) axi_memory (
        .clock_i(clock),
        .reset_i(reset),
        .axi_bus(axi_ddr4_bus)
    );

endmodule // sim_pairhmm_top_tb
