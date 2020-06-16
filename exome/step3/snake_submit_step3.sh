#!/bin/bash

#SBATCH --job-name=snake_step3
#SBATCH --mem=3000M
#SBATCH -c 1
#SBATCH -t 72:00:00

source /cluster/home/amammoli/.bashrc
module load python3

output_dir="/cluster/projects/bhklab/Data/TFRI_Exome" snakemake -s /cluster/projects/bhklab/Data/TFRI_Exome/step3/Snakefile_step3 --latency-wait 100 -j 150 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads} -p {params.partition}'