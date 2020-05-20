#!/bin/bash
#
#SBATCH --job-name=mergeBAMs
#SBATCH --partition=all
#SBATCH --mem=20Gb
#SBATCH --time=4:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca     # Where to send mail
#SBATCH --output=/cluster/home/psmirnov/logs/mergeBAMs_%j.log   # Standard output and error log

###################################
### A script to merge STAR aligned RNAseq BAMs 
###
###
### Assumes that a sheet of "sample prefixes" has been made and passed in. This is a sheet
### of the first n characters of the folder names, where all folders matching this prefix
### will be searched for to merge the BAMs  
###
### Writen: Petr Smirnov, Nov 13, 2019
### Last Modified: Petr Smirnov, Nov 13, 2019
###
###################################

module load samtools

fn=$1
BAMDIR=$2
OUTDIR=$3


BAMDIR=`echo $BAMDIR | sed -e 's/\/$//'`
OUTDIR=`echo $OUTDIR | sed -e 's/\/$//'`

echo $BAMDIR
echo $OUTDIR

mkdir $OUTDIR'/'$fn'_merged'
find $BAMDIR'/' -path $BAMDIR'/'$fn'*/*.bam' | xargs samtools merge $OUTDIR'/'$fn'_merged/'$fn'_merged.bam' 

echo 'merged '$fn

echo 'done'



