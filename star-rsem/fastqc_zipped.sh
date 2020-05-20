#!/bin/bash
#
#SBATCH --job-name=runFastQC 
#SBATCH --mem=6gb
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca     # Where to send mail
#SBATCH --output=/cluster/home/psmirnov/logs/fastqc_%j.log   # Standard output and error log

##################################################################################################
## Steps (For each sample): (with zipped R1.fastq and R2.fastq a input)
## 1) Provide individually zipped R1 and R2 fastq files to STAR
## Output: sortedAligned bam file
##         fusions from STAR-fusion
##         cufflinks FPKM
##         cuffquant
## USAGE: STAR_Pipeline_zipped.sh DATADIR SAMPLEID PROJECTDIR
## CREATED: Nov 11, 2019 Petr Smirnov
## MODIFIED:  Nov 11, 2019 Petr Smirnov
##################################################################################################
# Hard-coded variables

module load fastqc


# Command-line arguments
DATADIR=$1
SAMPLEID=$2
PROJECTDIR=$3

DEST=$DATADIR'/'$SAMPLEID
cd $DEST

# If fastqs are already individually packaged (not using the clipped fastqs)
FASTQ1=$DEST'/'$(ls *_R1_001.fastq.gz)
FASTQ2=$DEST'/'$(ls *_R2_001.fastq.gz)

# Navigate to the correct working directory
mkdir $PROJECTDIR'/fastqc/'$SAMPLEID
cd $PROJECTDIR'/fastqc/'$SAMPLEID

# Execute fastqc
zcat $FASTQ1 $FASTQ2 | fastqc stdin -o $PROJECTDIR'/fastqc/'$SAMPLEID
date
