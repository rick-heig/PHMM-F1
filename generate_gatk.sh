#!/bin/bash

if [[ ! -d patches ]]; then
    echo script must be run from base directory of the git repository
    exit 1
fi

############
# AWS-FPGA #
############
echo "************************"
echo "* Cloning AWS-FPGA ... *"
echo "************************"

git clone https://github.com/aws/aws-fpga.git
cd aws-fpga
git checkout -b phmm-1.4.8 eca10db155777ca80990f9ac8c2ccd9ede93613d

echo "**********************"
echo "* Applying patch ... *"
echo "**********************"

git apply ../patches/aws-fpga.patch

cd ..

#######
# GKL #
#######
echo "******************************************************"
echo "* Cloning the Intel Genomic Kernel Library (GKL) ... *"
echo "******************************************************"

git clone https://github.com/Intel-HLS/GKL.git
cd GKL
git checkout -b phmm-fpga c071276633f01d8198198fb40df468a0dffb0d41

echo "**********************"
echo "* Applying patch ... *"
echo "**********************"

git apply ../patches/gkl.patch

echo "***********************************"
echo "* Installing GKL dependencies ... *"
echo "***********************************"

sudo yum install -y java-1.8.0-openjdk-devel git cmake patch libtool automake yasm zlib-devel centos-release-scl
sudo yum install -y devtoolset-4-gcc-c++

echo "*************************"
echo "* Compiling the GKL ... *"
echo "*************************"

source scl_source enable devtoolset-4
./gradlew clean && ./gradlew test

echo "*************************"
echo "* GKL compilation done. *"
echo "*************************"

cd ..

########
# GATK #
########
echo "********************"
echo "* Cloning GATK ... *"
echo "********************"

sudo yum install -y git-lfs &> /dev/null # Install git-lfs dependency for GATK
git clone https://github.com/broadinstitute/gatk.git
cd gatk
git checkout -b phmm-fpga fdc1f645fa6ed7ee1c2163d1a513da73ea4cdef8

echo "**********************"
echo "* Applying patch ... *"
echo "**********************"

git apply ../patches/gatk.patch

echo "**********************"
echo "* Compiling GATK ... *"
echo "**********************"

./gradlew clean && ./gradlew bundle

echo "**************************"
echo "* GATK compilation done. *"
echo "**************************"

exit 0
