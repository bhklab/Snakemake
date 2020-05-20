#!/bin/bash
#
#SBATCH --job-name=runStarPipeline 
#SBATCH --partition=himem
#SBATCH --mem=30gb
#SBATCH --time=4:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca     # Where to send mail
#SBATCH --output=/cluster/home/psmirnov/logs/starPipeline_%j.log   # Standard output and error log

##################################################################################################
## Steps (For each sample): (with zipped R1.fastq and R2.fastq a input)
## 1) Provide individually zipped R1 and R2 fastq files to STAR
## Output: sortedAligned bam file
##         fusions from STAR-fusion
##         cufflinks FPKM
##         cuffquant
## USAGE: STAR_Pipeline_zipped.sh DATADIR SAMPLEID PROJECTDIR
## CREATED: Nov 11, 2015 Cindy Yang
## MODIFIED:  Nov 11, 2019 Petr Smirnov
##################################################################################################
# Hard-coded variables


# Command-line arguments
DATADIR=$1
SAMPLEID=$2
PROJECTDIR=$3

DEST=$DATADIR'/'$SAMPLEID
cd $DEST

# If fastqs are already individually packaged (not using the clipped fastqs)
FASTQ1=$DEST'/'$(ls *_R1_001.fastq.gz)
FASTQ2=$DEST'/'$(ls *_R2_001.fastq.gz)

GENOMEDIR='/cluster/projects/pughlab/references/STAR/STAR_GRCH38_v26_ReadLen_83'
GTF='/cluster/projects/pughlab/references/gencode/gencode.v26.annotation.gtf'

# Navigate to the correct working directory
mkdir $PROJECTDIR'/STAR/'$SAMPLEID
cd $PROJECTDIR'/STAR/'$SAMPLEID

# Execute STAR alignment
sh /cluster/home/psmirnov/RNAseqPipeline/STAR_zipped_hg38.sh $FASTQ1 $FASTQ2 $GENOMEDIR $GTF $PROJECTDIR'/STAR/'$SAMPLEID

# Cleanup files
rm -r Log.out Log.progress.out SJ.out.tab *fifo.read1 *fifo.read2 STARtmp _STARtmp
# Make a symlink in the raw bamfile directory
#cd /cluster/projects/pughlab/projects/late_meningiomas_RNASEQ/STAR/bamlinks/raw
#ln -s $PROJECTDIR'/STAR/'$SAMPLEID'/Aligned.sortedByCoord.out.bam' $SAMPLEID'.STAR.bam'
# Execute Clean-up for Variant Calling using the Symlink
#sh /cluster/projects/pughlab/src/RNAseqPipeline/VariantCalling.sh $SAMPLEID
# Execute Cuffquant
date
