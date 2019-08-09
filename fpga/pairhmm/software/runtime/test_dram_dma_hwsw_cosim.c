// Amazon FPGA Hardware Development Kit
//
// Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License"). You may not use
// this file except in compliance with the License. A copy of the License is
// located at
//
//    http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
// implied. See the License for the specific language governing permissions and
// limitations under the License.

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <poll.h>
#include <pthread.h>
#include <math.h>

#include <utils/sh_dpi_tasks.h>

#ifdef SV_TEST
# include <fpga_pci_sv.h>
#else
# include <fpga_pci.h>
# include <fpga_mgmt.h>
# include "fpga_dma.h"
# include <utils/lcd.h>
#endif

#include "test_dram_dma_common.h"

#include <float.h>
#include <stdint.h>

#define MEM_16G              (1ULL << 34)
#define ACC_MEM_SPACE_SIZE   (1 << 16)

#define CHUNK_LENGTH_IN_BYTES 64

#define NUMBER_OF_THREADS 0 // Not supported yet
#define SIMULATED_NUMBER_OF_READS 16
#define NUMBER_OF_READS 2
#define NUMBER_OF_HAPS  2
#ifdef SV_TEST
// Jobs for testing with full path (because of the simulator)
#define JOB_FILENAME "/SET/PATH/TO/pairhmm/sim/pairhmm_top/sim_memory_job1_4.txt"
#define BATCH_FILENAME "/SET/PATH/TO/pairhmm/sim/pairhmm_top/batch_job.txt"
#else
//#define JOB_FILENAME    "sim_memory_top.txt"
#define JOB_FILENAME    "sim_memory_job1_4.txt"
#define BATCH_FILENAME "batch_job.txt"
#endif

#define SV_WAIT_FOR_INTERRUPT_US 50
#define FROM_BATCH 1
#define NUMBER_OF_RUNS 1

// Control registers
const int NUMBER_OF_READS_ADDR            = 0x1000;
const int NUMBER_OF_HAPS_ADDR             = 0x1004;
const int DDR4_OFFSET_ADDR                = 0x1008;
const int START_ADDR                      = 0x1FF0;

const int READ_READ_ADDR_BASE_ADDR        = 0x2000;
const int READ_READ_LEN_BASE_ADDR         = 0x4000;
const int HAP_HAP_ADDR_BASE_ADDR          = 0x6000;
const int HAP_HAP_LEN_BASE_ADDR           = 0x8000;
const int HAP_INITIAL_CONDITION_BASE_ADDR = 0xA000;

const uint32_t DDR4_RESULTS_OFFSET        = 1024;

// Read addresses
//const int read_addresses[NUMBER_OF_READS] = {0, 64*1*6};
const int read_addresses[NUMBER_OF_READS] = {0, 64*1*6};
// Read lengths
//const int read_lengths[NUMBER_OF_READS]   = {41, 6};
const int read_lengths[NUMBER_OF_READS]   = {41, 41};
// Hap addresses
//const int hap_addresses[NUMBER_OF_HAPS]   = {64*1*5, 64*1*11};
const int hap_addresses[NUMBER_OF_HAPS]   = {64*1*5, 64*1*11};
// Hap lengths
//const int hap_lengths[NUMBER_OF_HAPS]     = {41, 8};
const int hap_lengths[NUMBER_OF_HAPS]     = {41, 41};

int configure_pair_hmm(int slot_id);
int start_pair_hmm(int slot_id);
int wait_on_interrupt(int slot_id, int interrupt_number);
int get_and_print_results(int slot_id, uint32_t offset);
int print_ddr4_contents(int slot_id, int dimm, size_t offset, size_t length);
int scrub_ddr4(int slot_id, int dimm, size_t offset, size_t length);
int print_ocl_stats(int slot_id);

void usage(const char* program_name);
int file_to_ddr4(int slot_id, const char* file_name, int dimm);
int dma_example_hwsw_cosim(int slot_id, size_t buffer_size);
int read_ocl_bus(int slot_id, uint64_t offset, uint32_t* result);

static inline int do_dma_read(int fd, uint8_t *buffer, size_t size,
    uint64_t address, int channel, int slot_id);
static inline int do_dma_write(int fd, uint8_t *buffer, size_t size,
    uint64_t address, int channel, int slot_id);

#if !defined(SV_TEST)
/* use the stdout logger */
const struct logger *logger = &logger_stdout;
#else
# define log_error(...) printf(__VA_ARGS__); printf("\n")
# define log_info(...) printf(__VA_ARGS__); printf("\n")
#endif

// dimm not only represents another DDR4 memory but also another partition
int run_batch_from_file(int slot_id, const char* file_name, int dimm) {
    size_t acc_offset = dimm * ACC_MEM_SPACE_SIZE;

    FILE *fp;
    char *line = NULL;
    size_t len = 0;
    ssize_t chars_read;

    int rc = 0;

    size_t num_reads;
    size_t num_haps;

    // The OCL bus is used to configure the FPGA
    pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    int pf_id = 0;
    int bar_id = 0;
    int fpga_attach_flags = 0;

    int write_fd = -1;
    uint8_t *write_buffer;
    write_buffer = NULL;
    size_t offset = 0;

    uint8_t *read_buffer = NULL;
    int read_fd = -1;

    fp = fopen(file_name, "rb");
    if (fp == NULL) {
        log_error("Failed to open file");
        rc = -errno;
        goto out;
    }

    printf("File opened.\n");

    /* Stat the file */
    size_t buffer_size;
    fseek(fp, 0L, SEEK_END);
    /* Twice the size because of padding */
    buffer_size = (ftell(fp) + 1)*2;
    fseek(fp, 0L, SEEK_SET);

    /* Create a buffer to hold the data */
    write_buffer = malloc(buffer_size);
    if (write_buffer == NULL) {
        rc = -ENOMEM;
        goto out;
    }
    memset(write_buffer, '*', buffer_size);

    fclose(fp);

    /* Reopen the file (not binary this time) */
    fp = fopen(file_name, "r");
    if (fp == NULL) {
        log_error("Failed to open file");
        rc = -errno;
        goto out;
    }

    chars_read = getline(&line, &len, fp);
    sscanf(line, "%lu %lu", &num_reads, &num_haps);

    // Attach to the FPGA
    rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);

    // Configure the FPGA
    rc = fpga_pci_poke(pci_bar_handle, acc_offset + NUMBER_OF_READS_ADDR, num_reads-1);
    fail_on(rc, out, "Unable to write to the fpga !");
    rc = fpga_pci_poke(pci_bar_handle, acc_offset + NUMBER_OF_HAPS_ADDR, num_haps-1);
    fail_on(rc, out, "Unable to write to the fpga !");

    // Prepare read info
    for (size_t i = 0; i < num_reads; ++i) {
        char *sepp;
        chars_read = getline(&line, &len, fp);
        sepp = strsep(&line, " ");

        size_t length = strlen(sepp);
        size_t chunks = ((length - 1) / CHUNK_LENGTH_IN_BYTES) + 1;

        // Write parameters to the FPGA
        rc = fpga_pci_poke(pci_bar_handle, acc_offset + READ_READ_ADDR_BASE_ADDR + (i*4), offset);
        fail_on(rc, out, "Unable to write read base address to the fpga !");
        rc = fpga_pci_poke(pci_bar_handle, acc_offset + READ_READ_LEN_BASE_ADDR + (i*4), length-1);
        fail_on(rc, out, "Unable to write read length to the fpga !");

        // Copy bases
        memcpy(write_buffer + offset, sepp, length);
        offset += chunks * CHUNK_LENGTH_IN_BYTES;

        // Copy qualities Q I D C
        for (size_t j = 0; j < 4; j++) {
            sepp = strsep(&line, " ");
            memcpy(write_buffer + offset, sepp, length);
            offset += chunks * CHUNK_LENGTH_IN_BYTES;
        }
    }

    // Prepare hap info
    for (size_t i = 0; i < num_haps; ++i) {
        chars_read = getline(&line, &len, fp);

        size_t length = chars_read-1; // Separator character included
        size_t chunks = ((length - 1) / CHUNK_LENGTH_IN_BYTES) + 1;

        // Write the parameters to the FPGA
        rc = fpga_pci_poke(pci_bar_handle, acc_offset + HAP_HAP_ADDR_BASE_ADDR + (i*4), offset);
        fail_on(rc, out, "Unable to write to the fpga !");
        rc = fpga_pci_poke(pci_bar_handle, acc_offset + HAP_HAP_LEN_BASE_ADDR + (i*4), length-1);
        fail_on(rc, out, "Unable to write to the fpga !");
        float initial_condition = ldexpf(1.f, 120.f) / length;
        rc = fpga_pci_poke(pci_bar_handle, acc_offset + HAP_INITIAL_CONDITION_BASE_ADDR + (i*4), *((uint32_t*)&initial_condition));
        fail_on(rc, out, "Unable to write to the fpga !");

        // Copy bases
        memcpy(write_buffer + offset, line, length);

        offset += chunks * CHUNK_LENGTH_IN_BYTES;
    }

    // Set result offset address
    rc = fpga_pci_poke(pci_bar_handle, acc_offset + DDR4_OFFSET_ADDR, offset);
    fail_on(rc, out, "Unable to write to the fpga !");

    /* Open the DMA channel */
#if !defined(SV_TEST)
    write_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0 + dimm, /*is_read*/ false);
    fail_on((rc = (write_fd < 0) ? -1 : 0), out, "unable to open write dma queue");
#endif

    printf("Sending Pair-HMM data to DDR4...\n");

    /* DMA it to the DDR4 */
    rc = do_dma_write(write_fd, write_buffer, /*buffer_size*/ offset,
                      dimm * MEM_16G, dimm, slot_id);
    fail_on(rc, out, "DMA write failed on DIMM %d", dimm);

    // Start the computation
    rc = fpga_pci_poke(pci_bar_handle, acc_offset + START_ADDR, 1); // Any value will do
    fail_on(rc, out, "Unable to write to the fpga !");

    // Wait for interrupt
#if defined(SV_TEST)
    //sv_pause(2000); // This may not be enough
#endif
    rc = wait_on_interrupt(slot_id, dimm);

    // Get results
    size_t read_buffer_size = num_reads * num_haps * 4;
    read_buffer = malloc(read_buffer_size);
    fail_on((rc = (read_buffer == NULL) ? -1 : 0), out , "unable to allocate memory");

#if !defined(SV_TEST)
    read_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0 + dimm, /*is_read*/ true);
    fail_on((rc = (read_fd < 0) ? -1 : 0), out, "unable to open read dma queue");
#else
    setup_send_rdbuf_to_c(read_buffer, read_buffer_size);
#endif

    rc = do_dma_read(read_fd, read_buffer, read_buffer_size,
                     dimm * MEM_16G + offset, dimm, slot_id);
    fail_on(rc, out, "DMA read failed on DIMM: %d", dimm);

    // Print results
    for (int i = 0; i < num_reads * num_haps; i++) {
        float result_float = *((float *)(read_buffer+i*4));
        double result_final = (double)(log10f(result_float) - log10f(ldexpf(1.f, 120.f)));
        printf("DIMM %d Result %d : %g - 0x%08x - %g\n", dimm, i, result_float, *((uint32_t *)(read_buffer+i*4)), result_final);
    }

out :
    if (write_buffer != NULL) {
        free(write_buffer);
    }
    if (read_buffer != NULL) {
        free(read_buffer);
    }
    if (fp != NULL) {
        fclose(fp);
    }
    if (line != NULL) {
        free(line);
    }
#if !defined(SV_TEST)
    if (write_fd >= 0) {
        close(write_fd);
    }
    if (read_fd >= 0) {
        close(read_fd);
    }
#endif
    return rc ? 1 : 0;
}

struct batch_args {    /* Used as argument to the threaded function */
    int slot_id;
    const char* file_name;
    int dimm;
};

void *run_batch_from_file_threaded(void * args) {
    struct batch_args *batch_args = args;

    printf("DIMM %d : Running job : %s on slot %d\n", batch_args->dimm, batch_args->file_name, batch_args->slot_id);
    run_batch_from_file(batch_args->slot_id, batch_args->file_name, batch_args->dimm);
    //run_batch_from_file(0, BATCH_FILENAME, 0);

out:
    free(batch_args);
    return NULL;
}


/* Main will be different for different simulators and also for C. The
 * definition is in sdk/userspace/utils/include/sh_dpi_tasks.h file */
#if defined(SV_TEST) && defined(INT_MAIN)
/* For cadence and questa simulators main has to return some value */
int test_main(uint32_t *exit_code)

#elif defined(SV_TEST)
void test_main(uint32_t *exit_code)

#else
int main(int argc, char **argv)

#endif
{
    size_t buffer_size;
#if defined(SV_TEST)
    buffer_size = 128;
#else
    buffer_size = 1ULL << 24;
#endif

    /* The statements within SCOPE ifdef below are needed for HW/SW
     * co-simulation with VCS */
#if defined(SCOPE)
    svScope scope;
    scope = svGetScopeFromName("tb");
    svSetScope(scope);
#endif

    int rc;
    int slot_id = 0;

#if !defined(SV_TEST)
    switch (argc) {
    case 1:
        break;
    case 3:
        sscanf(argv[2], "%x", &slot_id);
        break;
    default:
        usage(argv[0]);
        return 1;
    }

    /* setup logging to print to stdout */
    rc = log_init("test_dram_dma_hwsw_cosim");
    fail_on(rc, out, "Unable to initialize the log.");
    rc = log_attach(logger, NULL, 0);
    fail_on(rc, out, "%s", "Unable to attach to the log.");

    /* initialize the fpga_plat library */
    rc = fpga_mgmt_init();
    fail_on(rc, out, "Unable to initialize the fpga_mgmt library");

#endif

    /************/
    /* OCL TEST */
    /************/
    // Read OCL bus test
    uint32_t ocl_read_data;
    rc = read_ocl_bus(slot_id, 0xA000, &ocl_read_data);
    printf("OCL read data is %08x\n", ocl_read_data);

    // OCL bus test
    //pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    //int pf_id = 0;
    //int bar_id = 0;
    //int fpga_attach_flags = 0;
    //
    //// Attach to the FPGA
    //rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    //fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);
    //
    //// Poke the FPGA
    //rc = fpga_pci_poke(pci_bar_handle, 0xA55b1000, 0x12345678);
    //fail_on(rc, out, "Unable to write to the fpga !");

    /***************/
    /* DMA EXAMPLE */
    /***************/
    rc = dma_example_hwsw_cosim(slot_id, buffer_size);
    fail_on(rc, out, "DMA example failed");

    /**********************/
    /* Actual Application */
    /**********************/
    print_ocl_stats(slot_id);

#if FROM_BATCH

#if NUMBER_OF_THREADS
    int effective_number_of_threads = (NUMBER_OF_THREADS < 0) ? 1 :
                                      (NUMBER_OF_RUNS <= 4) ? NUMBER_OF_THREADS :
                                      4;

    pthread_t threads[NUMBER_OF_THREADS];
    pthread_attr_t attr;
    struct batch_args *batch_args = NULL;

    printf("Running the multiple threaded version with %d threads.\n", effective_number_of_threads);

    rc = pthread_attr_init(&attr);
    fail_on(rc, out, "Failed to initialize the attributes of thread %d", i);

    //pthread_attr_setstacksize(&attr, 300000000);

    for (int i = 0; i < effective_number_of_threads; ++i) {
        if (i > 3) break;
        batch_args = malloc(sizeof(struct batch_args));
        batch_args->slot_id = 0;
        batch_args->file_name = BATCH_FILENAME;
        batch_args->dimm = i;
        rc = pthread_create(&(threads[i]), &attr, &run_batch_from_file_threaded, batch_args);
        fail_on(rc, out, "Failed on pthread create %d", i); // Error handling is incomplete...
    }
    pthread_attr_destroy(&attr);
    for (int i = 0; i < effective_number_of_threads; ++i) {
        if (i > 3) break;

        rc = pthread_join(threads[i], NULL);
        fail_on(rc, out, "could not join thread %d", i);
    }
    printf("All %d threads have been joined.\n", effective_number_of_threads);
#else
    rc = run_batch_from_file(slot_id, BATCH_FILENAME, /*dimm*/ 1);
    fail_on(rc, out, "Failed to run batch from file");
#endif

    print_ocl_stats(slot_id);

#else
    for (int i = 0; i < NUMBER_OF_RUNS; ++i) {
        scrub_ddr4(slot_id, 0, 0, 2048);
        print_ddr4_contents(slot_id, 0, 0, 2048);

        /* Read the file & Transfer everything to the first address of the DDR4 module */
        rc = file_to_ddr4(slot_id, JOB_FILENAME, 0);
        //rc = file_to_ddr4(slot_id, file_name, dimm);
        fail_on(rc, out, "File to DDR4 failed");

        print_ddr4_contents(slot_id, 0, 0, 2048);

        /* TODO : Use OCL bus to set parameters and launch computation */
        rc = configure_pair_hmm(slot_id);
        fail_on(rc, out, "FPGA Pair-HMM Configuration failed");

        rc = start_pair_hmm(slot_id);
        fail_on(rc, out, "Starting Pair-HMM failed");

        /* Poll and wait on IRQ */

        // No interrupt support for Co-Simulation, so wait some us
        rc = wait_on_interrupt(slot_id, 0);
        //fail_on(rc, out, "Failed waiting on interrupt.");

        // Read the results from DDR4
        rc = get_and_print_results(slot_id, DDR4_RESULTS_OFFSET);
        fail_on(rc, out, "Failed reading results from DDR4");

        print_ddr4_contents(slot_id, 0, 0, 2048);

        // OCL Read
        print_ocl_stats(slot_id);
    }
#endif
out:

#if !defined(SV_TEST)
    return rc;
#else
    if (rc != 0) {
        printf("TEST FAILED \n");
    }
    else {
        printf("TEST PASSED \n");
    }
    /* For cadence and questa simulators main has to return some value */
    #ifdef INT_MAIN
    *exit_code = 0;
    return 0;
    #else
    *exit_code = 0;
    #endif
#endif
}

void usage(const char* program_name) {
    printf("usage: %s [--slot <slot>]\n", program_name);
}

int print_ocl_stats(int slot_id) {
    uint32_t ocl_read_data;

    read_ocl_bus(slot_id, 0x0, &ocl_read_data);
    printf("AXI Read issued : %08x\n", ocl_read_data);

    read_ocl_bus(slot_id, 0x4, &ocl_read_data);
    printf("AXI Read resp : %08x\n", ocl_read_data);

    read_ocl_bus(slot_id, 0x8, &ocl_read_data);
    printf("AXI Write issued : %08x\n", ocl_read_data);

    read_ocl_bus(slot_id, 0xC, &ocl_read_data);
    printf("AXI Write resp : %08x\n", ocl_read_data);

    read_ocl_bus(slot_id, 0x10, &ocl_read_data);
    printf("Number of jobs created : %d\n", ocl_read_data);

    read_ocl_bus(slot_id, 0x14, &ocl_read_data);
    printf("Number of results to wb : %d\n", ocl_read_data);

    return 0;
}

int file_to_ddr4(int slot_id, const char* file_name, int dimm)
{
    int rc = 0;
    int write_fd = -1;
    uint8_t *write_buffer;
    write_buffer = NULL;

    FILE* fp = fopen(file_name, "rb");
    if (fp == NULL) {
        log_warning("Failed to open file");
        rc = -errno;
        goto out;
    }

    printf("File opened.\n");

    /* Stat the file */
    size_t buffer_size;
    fseek(fp, 0L, SEEK_END);
    buffer_size = ftell(fp) + 1;
    fseek(fp, 0L, SEEK_SET);

    /* Create a buffer to hold the data */
    write_buffer = malloc(buffer_size);
    if (write_buffer == NULL) {
        rc = -ENOMEM;
        goto out;
    }

    /* Read the file */
    fread(write_buffer, sizeof(char), buffer_size, fp);

    /* Open the DMA channel */
#if !defined(SV_TEST)
    write_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ false);
    fail_on((rc = (write_fd < 0) ? -1 : 0), out, "unable to open write dma queue");
#endif

    printf("Sending Pair-HMM data to DDR4...\n");

    /* DMA it to the DDR4 */
    rc = do_dma_write(write_fd, write_buffer, buffer_size,
                      dimm * MEM_16G, dimm, slot_id);
    fail_on(rc, out, "DMA write failed on DIMM %d", dimm);

    printf("Data from file transfered to DIMM %d\n", dimm);

out:
    if (write_buffer != NULL) {
        free(write_buffer);
    }
    if (fp != NULL) {
        fclose(fp);
    }
#if !defined(SV_TEST)
    if (write_fd >= 0) {
        close(write_fd);
    }
#endif
    /* if there is an error code, exit with status 1 */
    return (rc != 0 ? 1 : 0);
}

int configure_pair_hmm(int slot_id)
{
    int rc = 0;

    // The OCL bus is used to configure the FPGA
    pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    int pf_id = 0;
    int bar_id = 0;
    int fpga_attach_flags = 0;

    // Attach to the FPGA
    rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);

    // Poke the FPGA
    //rc = fpga_pci_poke(pci_bar_handle, NUMBER_OF_READS_ADDR, NUMBER_OF_READS-1);
    rc = fpga_pci_poke(pci_bar_handle, NUMBER_OF_READS_ADDR, SIMULATED_NUMBER_OF_READS-1);
    fail_on(rc, out, "Unable to write to the fpga !");
    rc = fpga_pci_poke(pci_bar_handle, NUMBER_OF_HAPS_ADDR, NUMBER_OF_HAPS-1);
    fail_on(rc, out, "Unable to write to the fpga !");

    // For each read
    //for (int i = 0; i < NUMBER_OF_READS; ++i) {
    for (int i = 0; i < SIMULATED_NUMBER_OF_READS; ++i) {
        rc = fpga_pci_poke(pci_bar_handle, READ_READ_ADDR_BASE_ADDR + (i*4), read_addresses[i%NUMBER_OF_READS]);
        fail_on(rc, out, "Unable to write to the fpga !");
        rc = fpga_pci_poke(pci_bar_handle, READ_READ_LEN_BASE_ADDR + (i*4), read_lengths[i%NUMBER_OF_READS]-1);
        fail_on(rc, out, "Unable to write to the fpga !");
    }

    // For each hap
    for (int i = 0; i < NUMBER_OF_HAPS; ++i) {
        rc = fpga_pci_poke(pci_bar_handle, HAP_HAP_ADDR_BASE_ADDR + (i*4), hap_addresses[i]);
        fail_on(rc, out, "Unable to write to the fpga !");
        rc = fpga_pci_poke(pci_bar_handle, HAP_HAP_LEN_BASE_ADDR + (i*4), hap_lengths[i]-1);
        fail_on(rc, out, "Unable to write to the fpga !");
        float initial_condition = (FLT_MAX / 16) / hap_lengths[i];
        rc = fpga_pci_poke(pci_bar_handle, HAP_INITIAL_CONDITION_BASE_ADDR + (i*4), *((uint32_t*)&initial_condition));
        fail_on(rc, out, "Unable to write to the fpga !");
    }

    rc = fpga_pci_poke(pci_bar_handle, DDR4_OFFSET_ADDR, DDR4_RESULTS_OFFSET);
    fail_on(rc, out, "Unable to write to the fpga !");

out:
    return rc ? 1 : 0;
}

int start_pair_hmm(int slot_id)
{
    int rc = 0;

    // The OCL bus is used to configure the FPGA
    pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    int pf_id = 0;
    int bar_id = 0;
    int fpga_attach_flags = 0;

    // Attach to the FPGA
    rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);

    // Send start command
    rc = fpga_pci_poke(pci_bar_handle, START_ADDR, 1); // Any value will do
    fail_on(rc, out, "Unable to write to the fpga !");

    log_info("Pair-HMM started");

out:
    return rc ? 1 : 0;
}

int wait_on_interrupt(int slot_id, int interrupt_number)
{
#ifdef SV_TEST
    sv_pause(SV_WAIT_FOR_INTERRUPT_US + SIMULATED_NUMBER_OF_READS * NUMBER_OF_HAPS * 10); // Very approximate
    return 0;
#else
    int rc = 0;
    pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    uint32_t fd = 0;
    uint32_t rd = 0;
    //uint32_t read_data = 0;
    struct pollfd fds[1];
    int num_fds = 1;
    int poll_timeout = 1000; // TODO check, -1 means infinite, otherwise in milliseconds
    int pf_id = 0;
    int bar_id = 0;
    int fpga_attach_flags = 0;
    char event_file_name[256];

    int device_num = 0;
    rc = fpga_pci_get_dma_device_num(FPGA_DMA_XDMA, slot_id, &device_num);
    fail_on((rc = (rc != 0)? 1 : 0), out, "Unable to get xdma device number.");

    rc = sprintf(event_file_name, "/dev/xdma%i_events_%i", device_num, 0 + interrupt_number /* Interrupt number */);
    fail_on((rc = (rc < 0)? 1 : 0), out, "Unable to format event file name.");

    log_info("Waiting on interrupts");
    rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);

    log_info("Polling device file: %s for interrupt events", event_file_name);
    if((fd = open(event_file_name, O_RDONLY)) == -1) {
        log_error("Error - invalid device\n");
        fail_on((rc = 1), out, "Unable to open event device");
    }
    fds[0].fd = fd;
    fds[0].events = POLLIN;

    // Poll checks whether an interrupt was generated.
    rd = poll(fds, num_fds, poll_timeout);
    if((rd > 0) && (fds[0].revents & POLLIN)) {
        uint32_t events_user;

        // Check how many interrupts were generated, and clear the interrupt so we can detect
        // future interrupts.
        rc = pread(fd, &events_user, sizeof(events_user), 0);
        fail_on((rc = (rc < 0)? 1:0), out, "call to pread failed.");

        log_info("Interrupt present for Interrupt %i, events %i. It worked!",
                 0 + interrupt_number /* interrupt_number */, events_user);

        //Clear the interrupt register
        //rc = fpga_pci_poke(pci_bar_handle, interrupt_reg_offset , 0x1 << (16 + interrupt_number) );
        //fail_on(rc, out, "Unable to write to the fpga !");
    }
    else{
        log_error("No interrupt generated before timeout - something went wrong.");
        fail_on((rc = 1), out, "Interrupt generation failed");
    }
    close(fd);
    fd = 0;

out:
    if(fd){
        close(fd);
    }
    return rc;
#endif
}

int get_and_print_results(int slot_id, uint32_t offset)
{
    int rc = 0;

    size_t buffer_size = NUMBER_OF_READS * NUMBER_OF_HAPS * 4;
    uint8_t *read_buffer = malloc(buffer_size);
    fail_on((rc = (read_buffer == NULL) ? -1 : 0), out , "unable to allocate memory");

    int read_fd = -1;
    int dimm = 0;

#if !defined(SV_TEST)
    read_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ true);
    fail_on((rc = (read_fd < 0) ? -1 : 0), out, "unable to open read dma queue");
#else
    setup_send_rdbuf_to_c(read_buffer, buffer_size);
#endif

    rc = do_dma_read(read_fd, read_buffer, buffer_size,
                     dimm * MEM_16G + offset, dimm, slot_id);
    fail_on(rc, out, "DMA read failed on DIMM: %d", dimm);

    for (int i = 0; i < NUMBER_OF_READS * NUMBER_OF_HAPS; i++) {
        printf("Result %d : %g - 0x%08x\n", i, *((float *)(read_buffer+i*4)), *((uint32_t *)(read_buffer+i*4)));
    }

out:
    if (read_buffer != NULL) {
        free(read_buffer);
    }
#if !defined(SV_TEST)
    if (read_fd >= 0) {
        close(read_fd);
    }
#endif
    return rc ? 1 : 0;
}

int print_ddr4_contents(int slot_id, int dimm, size_t offset, size_t length)
{
    int rc = 0;

    size_t buffer_size = length;
    uint8_t *read_buffer = malloc(buffer_size);
    fail_on((rc = (read_buffer == NULL) ? -1 : 0), out , "unable to allocate memory");

    int read_fd = -1;

#if !defined(SV_TEST)
    read_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ true);
    fail_on((rc = (read_fd < 0) ? -1 : 0), out, "unable to open read dma queue");
#else
    setup_send_rdbuf_to_c(read_buffer, buffer_size);
#endif

    rc = do_dma_read(read_fd, read_buffer, buffer_size,
                     dimm * MEM_16G + offset, dimm, slot_id);
    fail_on(rc, out, "DMA read failed on DIMM: %d", dimm);

    for (int i = 0; i < (length+3)/4; i++) {
        printf("0x%08x : %08x\n", (uint32_t)(dimm * MEM_16G + offset + i*4), *((uint32_t *)(read_buffer+i*4)));
    }

out:
    if (read_buffer != NULL) {
        free(read_buffer);
    }
#if !defined(SV_TEST)
    if (read_fd >= 0) {
        close(read_fd);
    }
#endif
    return rc ? 1 : 0;
}

int scrub_ddr4(int slot_id, int dimm, size_t offset, size_t length)
{
    int rc = 0;
    int write_fd = -1;
    size_t buffer_size = length;
    uint8_t *write_buffer = malloc(buffer_size);
    if (write_buffer == NULL) {
        rc = -ENOMEM;
        goto out;
    }

    /* Set ones in the buffer */
    memset(write_buffer, 0xff, buffer_size);

    /* Open the DMA channel */
#if !defined(SV_TEST)
    write_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ false);
    fail_on((rc = (write_fd < 0) ? -1 : 0), out, "unable to open write dma queue");
#endif

    printf("Scrubbing the DDR4...\n");

    /* DMA it to the DDR4 */
    rc = do_dma_write(write_fd, write_buffer, buffer_size,
                      dimm * MEM_16G + offset, dimm, slot_id);
    fail_on(rc, out, "DMA write failed on DIMM: %d", dimm);

    printf("DDR4 scrubbed\n");

out:
    if (write_buffer != NULL) {
        free(write_buffer);
    }
#if !defined(SV_TEST)
    if (write_fd >= 0) {
        close(write_fd);
    }
#endif
    /* if there is an error code, exit with status 1 */
    return (rc != 0 ? 1 : 0);
}

/**
 * Write 4 identical buffers to the 4 different DRAM channels of the AFI
 */
int dma_example_hwsw_cosim(int slot_id, size_t buffer_size)
{
    int write_fd, read_fd, dimm, rc;

    write_fd = -1;
    read_fd = -1;

    uint8_t *write_buffer = malloc(buffer_size);
    uint8_t *read_buffer = malloc(buffer_size);
    if (write_buffer == NULL || read_buffer == NULL) {
        rc = -ENOMEM;
        goto out;
    }

    printf("Memory has been allocated, initializing DMA and filling the buffer...\n");
#if !defined(SV_TEST)
    read_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ true);
    fail_on((rc = (read_fd < 0) ? -1 : 0), out, "unable to open read dma queue");

    write_fd = fpga_dma_open_queue(FPGA_DMA_XDMA, slot_id,
        /*channel*/ 0, /*is_read*/ false);
    fail_on((rc = (write_fd < 0) ? -1 : 0), out, "unable to open write dma queue");
#else
    setup_send_rdbuf_to_c(read_buffer, buffer_size);
    printf("Starting DDR init...\n");
    init_ddr();
    printf("Done DDR init...\n");
#endif
    printf("filling buffer with  random data...\n") ;

    rc = fill_buffer_urandom(write_buffer, buffer_size);
    fail_on(rc, out, "unable to initialize buffer");

    printf("Now performing the DMA transactions...\n");
    for (dimm = 0; dimm < 4; dimm++) {
        rc = do_dma_write(write_fd, write_buffer, buffer_size,
            dimm * MEM_16G, dimm, slot_id);
        fail_on(rc, out, "DMA write failed on DIMM: %d", dimm);
    }

    bool passed = true;
    for (dimm = 0; dimm < 4; dimm++) {
        rc = do_dma_read(read_fd, read_buffer, buffer_size,
            dimm * MEM_16G, dimm, slot_id);
        fail_on(rc, out, "DMA read failed on DIMM: %d", dimm);
        uint64_t differ = buffer_compare(read_buffer, write_buffer, buffer_size);
        if (differ != 0) {
            log_error("DIMM %d failed with %lu bytes which differ", dimm, differ);
            passed = false;
        } else {
            log_info("DIMM %d passed!", dimm);
        }
    }
    rc = (passed) ? 0 : 1;

out:
    if (write_buffer != NULL) {
        free(write_buffer);
    }
    if (read_buffer != NULL) {
        free(read_buffer);
    }
#if !defined(SV_TEST)
    if (write_fd >= 0) {
        close(write_fd);
    }
    if (read_fd >= 0) {
        close(read_fd);
    }
#endif
    /* if there is an error code, exit with status 1 */
    return (rc != 0 ? 1 : 0);
}

int read_ocl_bus(int slot_id, uint64_t offset, uint32_t* result)
{
    int rc = 0;

    // The OCL bus is used to control the FPGA
    pci_bar_handle_t pci_bar_handle = PCI_BAR_HANDLE_INIT;
    int pf_id = 0;
    int bar_id = 0;
    int fpga_attach_flags = 0;

    // Attach to the FPGA
    rc = fpga_pci_attach(slot_id, pf_id, bar_id, fpga_attach_flags, &pci_bar_handle);
    fail_on(rc, out, "Unable to attach to the AFI on slot id %d", slot_id);

    // Peek inside the FPGA
    rc = fpga_pci_peek(pci_bar_handle, offset, result);
    fail_on(rc, out, "Unable to write to the fpga !");

out :
    return (rc ? 1 : 0);
}

static inline int do_dma_read(int fd, uint8_t *buffer, size_t size,
    uint64_t address, int channel, int slot_id)
{
#if defined(SV_TEST)
    sv_fpga_start_cl_to_buffer(slot_id, channel, size, (uint64_t) buffer, address);
    return 0;
#else
    return fpga_dma_burst_read(fd, buffer, size, address);
#endif
}

static inline int do_dma_write(int fd, uint8_t *buffer, size_t size,
    uint64_t address, int channel, int slot_id)
{
#if defined(SV_TEST)
    sv_fpga_start_buffer_to_cl(slot_id, channel, size, (uint64_t) buffer, address);
    return 0;
#else
    return fpga_dma_burst_write(fd, buffer, size, address);
#endif
}
