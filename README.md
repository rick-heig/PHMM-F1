# PHMM-F1
FPGA Accelerator (Amazon F1) for the Pair-HMM Forward Algorithm of the GATK HaplotypeCaller

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## FPGA Accelerator
Source code and build instructions are available in the `fpga` directory.

### Bitstreams (AFIs)
Pre-generated images are available on AWS with the following IDs. (Available only for *eu-west-1* region).

1 Accelerator 8 work-groups 12 workers 250 MHz

```
"FpgaImageGlobalId": "agfi-003c75629c2a7f3bf"
```

4 Accelerators 4 work-groups 6 workers 250 MHz

```
"FpgaImageGlobalId": "agfi-08b44cb4440d82d3e"
```

4 Accelerators 4 work-groups 6 workers 125 MHz

```
"FpgaImageGlobalId": "agfi-0cc848fb8b40dd40b"
```

## GATK
In order to use the accelerator in [GATK](https://software.broadinstitute.org/gatk/), GATK requires to be recompiled with a modified version of the [Intel Genomic Kernel Library (GKL)](https://github.com/Intel-HLS/GKL).

GATK can be generated with the following script (tested on the Amazon FPGA Developer AMI 1-6-0, CentOS) :

```
./generate_gatk.sh
```

The script will clone the `aws-fpga` repository since it needs include files for the FPGA accelerator. Then it will clone the GKL, patch it, and compile it. Finally the script will clone GATK, patch it, and compile it. The script will checkout the last versions of the different repositories for which this has been tested (newer version probably also work but are not guaranteed to).

Note : This will require at least 15 GB of space, be sure to clone this repository to a disk with suficient space. Or copy this repository to another location. If there is not enough space on the disk the script will fail (an error message will show this). The GATK repository grows to 12 GB alone because of test data.

### XDMA driver
The XDMA driver requires to be compiled and installed before launching GATk with the accelerator because it uses this driver to transfer data to the FPGA. The driver can be installed with the following script

```
./install_xdma.sh
```

To check if the driver has been installed, the following command can be used

```
lsmod | grep xdma
```

If this command returns `xdma` followed by two numbers, then the driver is loaded. If this returns nothing then the driver failed to be loaded.

### Usage

In order to use the accelerator it must be loaded, this can be done with the following script.

```
./fpga/fpga_loading_script.sh
```

Or with a specific AFI.

```
./fpga/fpga_loading_script.sh agfi-08b44cb4440d82d3e
```

### Running GATK
To run the GATK HaplotypeCaller with the FPGA accelerator the `--pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING` option must be passed as an argument.

Example :

```
sudo LD_PRELOAD="/PATH/TO/GKL/.../libgkl_pairhmm_shacc.so /usr/local/lib64/libfpga_mgmt.so" /PATH/TO/REPOSITORY/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING
```

This requires the `fpga_loading_script` to have been run because
1) It will load the FPGA image
2) Load the system wide semaphores for mutual exclusion
3) It generates an example command with the correct paths for the LD_PRELOAD environment variable. It gives an example GATK command at the end of the script, this can be copied.

#### Notes
The `LD_PRELOAD` environment variable is set in order to dynamically load the FPGA related libraries (If this is not set properly GATK will return an error message stating that the FPGA Accelerated version is not supported).

GATK is run in superuser mode `sudo`, because accessing the FPGA and using the XDMA driver requires superuser rights.

Multiple runs of GATK can be run together or one after the other.
If a run is interrupted it is better to reload the FPGA image because it may have been left in an unstable state (interrupted midway).

## Benchmarks

Benchmarks logs and commands are available in the `runs` directory.
