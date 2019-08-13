# How to build the FPGA image

## Setting up the Amazon F1 environment from aws-fpga git
These steps are required to be done only once.

First clone the Amazon FPGA git inside the `fpga` directory, Second checkout and branch version V1.4.8.
(The project was built using version V1.4.8 never versions may require modifications). Note that the repository may already have been cloned if the `generate_gatk.sh` has been run.

```
git clone https://github.com/aws/aws-fpga.git
cd aws-fpga
git checkout -b phmm-1.4.8 eca10db155777ca80990f9ac8c2ccd9ede93613d
```

### Copy design files
These steps are required to be done only once.

Copy the user design file inside the aws-fpga folder.

```
# From the aws-fpga directory
cp -r ../pairhmm hdk/cl/developer_designs/
```

## How to build and submit the Custom Logic (CL) to AWS

From the `aws-fpga` directory run the following command to setup the environment (This may take a while the first time it is called).
```
source hdk_setup.sh
```

Now move to the project directory to set the `CL_DIR` environment variable.
```
cd hdk/cl/developer_designs/pairhmm
export CL_DIR=$(pwd)
```

Now move to the project build scripts directory and link to the Amazon build script.
```
cd build/scripts
ln -s ../../../../../common/shell_v04261818/build/scripts/aws_build_dcp_from_cl.sh 
```

### Building the image
```
./aws_build_dcp_from_cl.sh -clock_recipe_a A0 -foreground
```

The clock recipe allows to chose the clock sources as defined in :

https://github.com/aws/aws-fpga/blob/master/hdk/docs/clock_recipes.csv

The `-clock_recipe_a A0` will result in a 125 MHz main clock for the design, the `-clock_recipe_a A1` will result in a 250 MHz clock for the design.

Building the FPGA image may take a long time. E.g., approx 15 hours for a 8 workgroup 12 workers 250 MHz image on a 12-core Dual-Xeon machine with 64 GB DDR3 RAM and SSD.

#### Customizing the image
It is possible to change design options in the `hdk/cl/developer_designs/pairhmm/design/cl_top.sv` file which are :
- `NUM_WORKGROUPS` This is the number of workgroups inside an accelerator, E.g., 4
- `NUM_WORKERS_PER_WORKGROUP` This is the number of workers inside a workgroup, E.g., 6
- `NUMBER_OF_ACCELERATORS` This is the number of accelerators on one card, From 1 to 4

Depending on the configuration the image may not be possible to generate (lack or resources or impossible routing or failed timings) or may take a very long time.
The following configurations have been validated (among others) :
1 Accelerator 1 Workgroup 1 Worker  
1 Accelerator 4 Workgroups 6 Workers  
1 Accelerator 8 Workgroups 12 Workers  
4 Accelerators 4 Workgroups 6 Workers  

### Generating the AFI
In order to generate the Amazon FPGA image the design checkpoint requires to be copied into an Amazon S3 bucket. Further information is available in the Amazon README here : https://github.com/aws/aws-fpga/blob/master/hdk/README.md#endtoend

```
# Example (You may require to create the S3 bucket and folders first) and replace the filename with the correct one.
aws s3 cp aws-fpga/hdk/cl/developer_designs/pairhmm/build/checkpoints/to_aws/YY_MM_DD-HHMMSS.Developer_CL.tar s3://phmm-fpga-bucket/dcp-folder/

# Create the AFI (check options, replace with correct values).
aws ec2 create-fpga-image --region <REGION e.g, eu-west-1> --name <NAME e.g., phmm-fpga-ami> --description <DESCRIPTION e.g., Pair-HMMM> --input-storage-location Bucket=phmm-fpga-bucket,Key=dcp-folder/YY_MM_DD-HHMMSS.Developer_CL.tar --logs-storage-location Bucket=phmm-fpga-bucket,Key=log-folder
```

This will result in the FPGA image IDs as given by Amazon :
```
{
    "FpgaImageGlobalId": "agfi-xxxxxxxxxxxxxxxxx",
    "FpgaImageId": "afi-xxxxxxxxxxxxxxxxx"
}
```

These IDs are used to check the status of the images and to load the images

#### Checking the image status
```
aws ec2 describe-fpga-images --fpga-image-ids afi-xxxxxxxxxxxxxxxxx
```

#### Loading the FPGA image on an F1 instance
```
sudo fpga-load-local-image -S 0 -I agfi-xxxxxxxxxxxxxxxxx
```



# How to simulate the project
Simulation scripts were written for Questasim 10.7, Xilinx libraries require to be compiled first.
This project requires libraries from Xilinx Vivado 2017.4 as well as 2018.3 both library collections require to be compiled.

Note : This is because parts of the project were developed with an older version of the aws-fpga that did run with Vivado 2017.4 and parts had not since been updated. Therefore the project requires both because part of the IPs are from Vivado 2017.4 and part from 2018.3.

## Compile Xilinx libraries
From the Xilinx Vivado software Tools menu use "Compile Simulation Libraries" for Questa Advanced Simulator.
Do this both with Vivado 2017.4 and 2018.3. The output directories will need to be added to the modelsim.ini files below.

`modelsim.ini` files require to be updated with the path to these libraries.

Note : Compilation of the Xilinx libraries for Questasim through the Amazon provided scripts may fail due to `(suppressible)` error messages.

## HW-SW cosimulation
Hardware-Software cosimulation runs tests from C software and interacts with the simulated FPGA through the Amazon AWS FPGA framework.

### AWS-FPGA setup
From `aws-fpga` run the following command :

```
source hdk_setup.sh
```

From the `aws-fpga/hdk/cl/developer_designs/pairhmm/verif/scripts` directory run the following command :

```
make C_TEST=test_dram_dma_hwsw_cosim QUESTA=1
```

This will launch the Hardware-Software co-simulation.

In order to do the simulation with another simulator (E.g., the Xilinx simulator) instead of Questasim, Makefiles require to be created, use the questasim Makefiles as a reference and adapt to your simulator.

## HW Top-level simulation
TODO.

This is a top level simulation without software interaction (System-Verilog testbench).

## Workgroup simulation
TODO.

This is a simulation at the workgroup level.

## Worker simulation
TODO.

This is a simulation at the worker level.
