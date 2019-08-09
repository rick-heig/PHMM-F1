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

### Modified GKL
This uses a modified version of the Intel Genomic Kernel Library that will call the accelerator.

From the base directory

First clone the GKL and checkout the last version for which this has been tested (newer versions probably work but are not guaranteed to).

```
git clone https://github.com/Intel-HLS/GKL.git
cd GKL
git checkout -b phmm-fpga c071276633f01d8198198fb40df468a0dffb0d41
```

Apply the patch

```
git apply ../patches/gkl.patch
```

#### Compile GKL
from within the `GKL/` directory run the following command :

```
# Check GKL README for dependencies
source scl_source enable devtoolset-4
./gradlew clean && ./gradlew test
```

Once compiled and the tests passed it can be used to compile GATK.

### Compile GATK
From the base directory

Clone [GATK](https://github.com/broadinstitute/gatk) and checkout the last version for which this has been tested (newer versions probably work but are not guaranteed to). Also apply the patch that will use the modified GKL instead of the current GKL.

```
git clone https://github.com/broadinstitute/gatk.git
cd gatk
git checkout -b phmm-fpga fdc1f645fa6ed7ee1c2163d1a513da73ea4cdef8
```

```
git apply ../patches/gatk.patch
```

Finally compile with

```
# Check GATK README for dependencies
./gradlew clean && ./gradlew bundle
```

### Usage

In order to use the accelerator it must be loaded, this can be done with the following script.

```
source fpga/fpga_loading_script.sh
```

Or with a specific AFI.

```
source fpga/fpga_loading_script.sh agfi-08b44cb4440d82d3e
```

### Running GATK
To run the GATK HaplotypeCaller with the FPGA accelerator the `--pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING` option must be passed as an argument.

Example :

```
/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING
```

This requires the `fpga_loading_script` to have been run (sourced) as described above because
1) It will load the FPGA image
2) Load the system wide semaphores for mutual exclusion
3) set the `LD_PRELOAD` environment variable in order to dynamically load the FPGA related libraries (If this is not set properly, by sourcing the script above, GATK will return an error message stating that the FPGA Accelerated version is not supported).

Multiple runs of GATK can be run together or one after the other.
If a run is interrupted it is better to reload the FPGA image because it may have been left in an unstable state (interrupted midway).

## Benchmarks

Benchmarks logs and commands are available in the `runs` directory.
