#!/bin/bash

SCRIPT=$(readlink -f "$BASH_SOURCE")
SCRIPTPATH=$(dirname "$SCRIPT")

# Default FPGA image (4 accelerators 24 workers 250MHz)
FPGA_IMAGE=agfi-08b44cb4440d82d3e
START_DIR=$(pwd)

#if [[ "$SCRIPT" == $(readlink -f "$0") ]]; then
#    echo "Use source ./fpga_loading_script.sh [agfi-xxxxxxxxxxxxxxxxx]"
#    exit 1
#fi

# Compile the create semaphores program if needed
cd ${SCRIPTPATH}/system_semaphores
if [ ! -f "create_sems" ]; then
    gcc -o create_sems create_sems.c -std=gnu99 -pthread
fi

echo $START_DIR
cd $START_DIR

# Delete existing semaphores since FPGA image will be reloaded
${SCRIPTPATH}/system_semaphores/create_sems -d &> /dev/null

# If FPGA image is passed as an argument load it
if [ "$#" -gt 0 ]; then
    if [[ "$1" == agfi-[a-f0-9]* ]]; then
        FPGA_IMAGE=$1
    else
        echo "Wrong FPGA image argument, should be agfi-xxxxxxxxxxxxxxxxx"
        #return 1
        exit 1
    fi
fi

source ${SCRIPTPATH}/../aws-fpga/sdk_setup.sh &> /dev/null

sudo fpga-load-local-image -S 0 -I $FPGA_IMAGE

${SCRIPTPATH}/system_semaphores/create_sems &> /dev/null

GATKPATH=$(readlink -f ${SCRIPTPATH}/../gatk/)
LIBGKLPATH=$(readlink -f ${SCRIPTPATH}/../GKL/build/native/)

if [[ ! -f "${SCRIPTPATH}/../GKL/build/native/libgkl_pairhmm_shacc.so" ]]; then
    echo "Modified GKL is missing, please patch and compile the GKL."
    exit 1
else
    if [[ ! -f "/usr/local/lib64/libfpga_mgmt.so" ]]; then
        echo "/usr/local/lib64/libfpga_mgmt.so is missing, are you running on the Amazon F1 instance ?"
        echo "This can be solved by running 'source sdk_setup.sh' in the aws-fpga directory."
        exit 1
    else
        #export LD_PRELOAD="${SCRIPTPATH}/../GKL/build/native/libgkl_pairhmm_shacc.so /usr/local/lib64/libfpga_mgmt.so"
        echo "Use GATK with the following command : "
        echo ""
        echo "sudo LD_PRELOAD=\"${LIBGKLPATH}/libgkl_pairhmm_shacc.so /usr/local/lib64/libfpga_mgmt.so\" ${GATKPATH}/gatk HaplotypeCaller <-R reference.fasta> <-I input.bam> <-O output.vcf> --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING"
    fi
fi
