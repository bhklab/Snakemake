# Snakemake Kallisto Pipeline

Snakemake workflow for Kallisto.
<br/>
<br/>
*Snakefile* contains neccessary workflow components, shell commands, and H4H modules.
<br/>
<br/>
*Snakefile* initation is executed as a low memory job (*snake_submit.sh*). 
<br/>
<br/>
Please follow the directions below to execute this pipeline:
<br/>
<br/>
**1.** Modify *rnaseq_samples.tsv* with your sample names and respective file paths. The format (sample, read1, read2) must not be changed. If you modify the name of the tsv (*rnaseq_samples.tsv*), it must also be changed in *config.yaml*
<br/>
<br/>
**2.** Within *snake_submit.sh*, ensure you specify correct path to 1) output directory; 2) transcriptome index (which can be found in /cluster/projects/bhklab/Data/RNAseqIndices/kallisto); 3) *Snakefile*
<br/>
<br/>
*NOTE*: If you are using a mixed transcriptome (e.g. human/mouse), please upgrade memory of mapKallisto rule in Snakefile to 16GB.
<br/>
<br/>
**3.** Specify the number of samples you are processing using the -j parameter in snake_submit.sh (e.g. to parallelize 77 samples, -j 77)
<br/>
<br/>
**4.** Ensure *snake_submit.sh*, *Snakefile*, *rnaseq_samples.tsv*, and *config.yaml* are all in the same directory
<br/>
<br/>
**5.** Execute the workflow, perform the following on H4H:
<br/>
`sbatch snake_submit.sh`
