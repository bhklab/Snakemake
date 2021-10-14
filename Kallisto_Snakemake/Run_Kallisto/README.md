
# run_kallisto
## Snakemake pipeline to run kallisto on slurm cluster. 
This pipeline can be run on multiple fastq files at the same time. Specify the list of samples in "samples.tsv".
Run the pipeline with the following command:

`sbatch sbatch.sh`

This command submits a parent job which will run the snakemake script. Then based on the defined rules, snakemake will automatically submit new jobs in parallel into the cluster.

## Notes
 - Genral cluster settings (e.g. email notification) should be added to cluster_config.yaml and rule specific settings (e.g. number of threads, memory, time, etc.) should be added to params of the rule in the snake file.
 - Path to sample file, Kallisto index, input, and output paths should be defined in "config.yaml".
 - Use kallisto_index pipeline to build kallisto index. 
 - This script was tested using Kallisto v0.46.1. 

TODO:
- Ideally the kallisto version should be specified in YAML file and should be downloaded automatically if necessary.
- Ideally in the absence of a kallisto index, the pipeline should build it automatically. 
