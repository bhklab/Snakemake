#!/bin/bash

#SBATCH --job-name=snake_snv19
#SBATCH --mem=3000M
#SBATCH -c 1
#SBATCH -t 72:00:00

source /cluster/home/amammoli/.bashrc
module load python3

output_dir="/cluster/home/amammoli/exome" snakemake -s /path/to/gitclone/step5/Snakefile_vcftomaf_hg19_snv --latency-wait 100 -j 100 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads} -p {params.partition}'
