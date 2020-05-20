#!/bin/bash
#
#PBS -V
#PBS -S /bin/bash
#PBS -l vmem=50gb
#PBS -l mem=60gb

#################################################################################################
## Modified STAR Alignment Pipeline for H4H (with zipped R1.fastq and R2.fastq a input)
## To perform STAR alignment with Aldape RNAseq fastq
##
## Output: sortedAligned bam file
##         fusions from STAR-fusion
##
## USAGE: STAR_zipped.sh FASTQ1 FASTQ2 GENOMEDIR OUTPUTDIR 
## CREATED: January 11 2016 Cindy Yang
## MODIFIED: November 11, 2019 Petr Smirnov 
##################################################################################################

# Load modules
module load STAR/2.5.2b
module load igenome-human/hg38
module load picard/1.9.1
module load samtools/1.2

# Hard-coded variables

GENOMEDIR=$3
ANNOTATION_FILE=$4
OUTPUTDIR=$5

# Command-line arguments
FASTQ1=$1
FASTQ2=$2

# (Updated for STAR/2.4.2a) Using per sample two pass mapping
# Manual: http://chagall.med.cornell.edu/RNASEQcourse/STARmanual_2.4.2a.pdf
# Output Chimeric reads for STAR-fusion
# Output unmapped reads both as separate fastqs and within the sorted bam
# Output Transcript annotated bam for RSME and gene counts for htseq
# Limit IO and Bam sort RAM

echo -e $(date)'\tStart STAR/2.5.2b 2-pass'

STAR --runMode alignReads \
--genomeDir $GENOMEDIR \
--readFilesCommand zcat \
--readFilesIn $FASTQ1 $FASTQ2 \
--runThreadN 1 \
--genomeSAsparseD 2\
--twopassMode Basic \
--outSAMprimaryFlag AllBestScore \
--outFilterIntronMotifs RemoveNoncanonical \
--outSAMtype BAM SortedByCoordinate \
--chimSegmentMin 10 \
--chimOutType SeparateSAMold \
--quantMode GeneCounts TranscriptomeSAM \
--limitIObufferSize 150000000 \
--limitBAMsortRAM 50000000000 \
--outSAMunmapped Within \
--outFileNamePrefix $OUTPUTDIR'/' \
--outBAMsortingThreadN 1 \

echo -e $(date)'\tComplete STAR/2.5.2b 2-pass'

samtools view -b Chimeric.out.sam > Chimeric.out.bam
