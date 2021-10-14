# Kallisto_Index
Snakemake pipeline to build kallisto index

By default GENCODE Human Transcriptome v38 will be downloaded.
To build the most updated index, check the latest available version of human transcriptome at https://www.gencodegenes.org/human/ and replace the version on line 3 of the Snakemake script.
Run the following command to build the index:

`snakemake --snakefile Snakemake`

This script was tested using Kallisto v0.46.1. 

TODO:
- Ideally the kallisto version should be specified in YAML file and should be downloaded automatically. 
