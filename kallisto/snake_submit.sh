#!/bin/bash

#SBATCH --job-name=snake_rnaseq
#SBATCH --mem=3000M
#SBATCH -c 1
#SBATCH -t 24:00:00

source /cluster/home/amammoli/.bashrc
module load python3

output_dir="/cluster/home/amammoli/out" transcriptome="/cluster/projects/bhklab/references/RNAseqIndices/kallisto/gencodev33.kallisto.v461.idx" snakemake -s /cluster/home/amammoli/kallisto/Snakefile --latency-wait 100 -j 100 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads}'
