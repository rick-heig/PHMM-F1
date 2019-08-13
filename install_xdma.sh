#!/bin/bash

# This script was made from the instructions found here :
# https://github.com/aws/aws-fpga/blob/master/sdk/linux_kernel_drivers/xdma/xdma_install.md

SCRIPT=$(readlink -f "$BASH_SOURCE")
SCRIPTPATH=$(dirname "$SCRIPT")

# Install build tools
sudo yum groupinstall -y "Development tools"
sudo yum install -y kernel kernel-devel

cd $SCRIPTPATH

if [ ! -d "aws-fpga" ]; then
    # This should already exist if the ./generate_gatk.sh script has been run
    git clone https://github.com/aws/aws-fpga.git
    cd aws-fpga
    git checkout -b phmm-1.4.8 eca10db155777ca80990f9ac8c2ccd9ede93613d
fi

cd aws-fpga/sdk/linux_kernel_drivers/xdma
make
sudo rmmod xocl
sudo make install
