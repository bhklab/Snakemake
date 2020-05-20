#!/bin/bash
#
#SBATCH --job-name=runStarPipeline 
#SBATCH --partition=all
#SBATCH --mem=30gb
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca     # Where to send mail
#SBATCH --output=/cluster/home/psmirnov/logs/RSEM_%j.log   # Standard output and error log

module load perl/5.18.1
module load rsem/1.3.0
module load samtools/1.2

BAM_DIR=$1
SAMPLE=$2
REF_DIR=$3
OUTPUT_DIR=$4

mkdir $OUTPUT_DIR'/'$SAMPLE

#SAMPLE_NAME=${SAMPLE%.transcriptome.bam}
BAMNAME=$SAMPLE'.bam'
INPUT=$BAM_DIR'/'$SAMPLE'/'$BAMNAME
OUTPUT_PREFIX=$OUTPUT_DIR'/'$SAMPLE'/'$SAMPLE
TMP=$OUTPUT_DIR'/'$SAMPLE'/tmp'


rsem-calculate-expression -p 8 \
--forward-prob 0 \
--paired-end \
--bam \
--estimate-rspd \
--output-genome-bam \
--time \
--temporary-folder $TMP \
$INPUT $REF_DIR $OUTPUT_PREFIX

