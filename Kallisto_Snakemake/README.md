# Kallisto_Snakemake
## Snakemake pipeline for RNASeq analysis using Kallisto on Slurm

- Use Kallisto_Index pipeline to build the Kallisto Index using the latest GENCODE transcriptome.
- Use Run_Kallisto pipeline to run Kallisto on raw fastq files. If you have multiple samples.The pipeline will automatically submit news jobs into the cluster.
