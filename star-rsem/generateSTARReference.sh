#!/bin/bash
#
#SBATCH --job-name=generateSTARref
#SBATCH --partition=himem
#SBATCH --mem=40gb
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca     # Where to send mail
#SBATCH --output=/cluster/home/psmirnov/logs/starRef_%j.log   # Standard output and error log

##################################################################################################
## CREATED: Nov 14, 2019 Petr Smirnov
## MODIFIED:  Nov 11, 2019 Petr Smirnov
##################################################################################################
# Hard-coded variables
module load STAR/2.5.2b
module load igenome-human/hg38
module load picard/1.9.1
module load samtools/1.2

# Command-line arguments
GTF=$1
readLength=$2
SAVEDIR=$3
gencodeVersion=$4


DEST=$SAVEDIR'/STAR_GRCH38_'$gencodeVersion'_ReadLen_'$readLength
mkdir $DEST
cd $DEST

echo $DEST

STAR --runMode genomeGenerate \
--runThreadN 4 --genomeDir $DEST \
--genomeFastaFiles /cluster/tools/data/genomes/human/hg38/iGenomes/Sequence/WholeGenomeFasta/genome.fa \
--genomeChrBinNbits 18   --genomeSAsparseD 2   --limitGenomeGenerateRAM 30000000000   --limitIObufferSize 150000000   --outTmpDir GenomeTmp   \
--sjdbGTFfile $GTF \
--sjdbOverhang $(($readLength - 1))


date

