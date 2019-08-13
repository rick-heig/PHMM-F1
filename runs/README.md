# Paper
This folder holds the logs of the different benchmarks of the paper.

# Dataset preparation
Source :
ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/working/20101201_cg_NA12878/

First sort the bam file with samtools :
```
samtools sort NA12878.ga2.exome.maq.raw.bam -o NA12878.ga2.exome.maq.raw.sorted.bam
```
Then index it with samtools :
```
samtools index NA12878.ga2.exome.maq.raw.sorted.bam NA12878.ga2.exome.maq.raw.sorted.bai
```
Then create the dictionnary with Picard for the reference :
```
java -jar /path/to/Picard/picard.jar CreateSequenceDictionary R=Homo_sapiens_assembly18.fasta O=Homo_sapiens_assembly18.dict
```

# Commands
The following commands were used for the benchmarks. The logs are in the `logs` folder.

## JAVA
```
/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM LOGLESS_CACHING &> java_chr1.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM LOGLESS_CACHING &> java_chr2.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM LOGLESS_CACHING &> java_chr3.log
```
## AVX
```
/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING &> avx_chr1.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING &> avx_chr2.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING &> avx_chr3.log
```

## OpenMP 4t
```
/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> omp4t_chr1.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> omp4t_chr2.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> omp4t_chr3.log
```

## OpenMP 8t
```
/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 8 &> omp8t_chr1.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 8 &> omp8t_chr2.log

/home/centos/src/project_data/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 8 &> omp8t_chr3.log
```

## Spark 4t + OpenMP 4t
```
/home/centos/src/project_data/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> spark4_4_chr1.log

/home/centos/src/project_data/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> spark4_4_chr2.log

/home/centos/src/project_data/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 4 &> spark4_4_chr3.log
```

## OpenMP 4t + FPGA 24w
Note : The `sudo LD_PRELOAD="PATH/TO/GKL/.../libgkl_pairhmm_shacc.so /usr/local/lib64/libfpga_mgmt.so"` is ommitted in the commands below for readability

```
./fpga/fpga_loading_script.sh agfi-08b44cb4440d82d3e

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA24w_chr1.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA24w_chr2.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA24w_chr3.log
```

## OpenMP 4t + FPGA 96w
```
./fpga/fpga_loading_script.sh agfi-003c75629c2a7f3bf

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA96w_chr1.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA96w_chr2.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCaller -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> omp4t_FPGA96w_chr3.log
```

## Spark 4t + OpenMP 4t + FPGA 4x24w
```
./fpga/fpga_loading_script.sh agfi-08b44cb4440d82d3e

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr1 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> spark4_4_FPGA_4_24_chr1.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr2 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> spark4_4_FPGA_4_24_chr2.log

/home/centos/src/project_data/PHMM-F1/gatk/gatk HaplotypeCallerSpark --spark-master local[4] -R Homo_sapiens_assembly18.fasta -I NA12878.ga2.exome.maq.raw.sorted.bam -O call.vcf -L chr3 --smith-waterman AVX_ENABLED --pairHMM EXPERIMENTAL_FPGA_LOGLESS_CACHING --native-pair-hmm-threads 4 &> spark4_4_FPGA_4_24_chr3.log
```
