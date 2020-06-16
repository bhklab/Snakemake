# Snakemake Exome Workflow

Snakemake workflow for Pugh lab/TFRI exome processing.
<br/>
<br/>
Snakefile initation is executed as a low memory job (snake_submit.sh). Ensure you specify correct path to processed output directory.
<br>
<br> 
The workflow contains 3 separate Snakemake pipelines,
in order to effectively parallelize two key steps that have a long runtime and rather complex execution (MuTect2, VCFtoMAF)
<br>
<br> 
Please run the pipelines (Snakefiles) in the following order (with accompanying snake_submit.sh, config.yaml, and .tsv files for H4H execution) - change some file paths in Snakefiles (e.g. S04380110_Covered.headless.bed):
<br>
<br>
Example: Run `snake_submit_step1.sh` in same directory as Snakefile_step1, config.yaml, and .tsv files.
<br> 
1. `preprocess/Snakefile_step1` (executes bwa alignment, picard MarkDuplicates, and GATK preprocessing steps)
2. `process/mutect2/Snakefile_step2` (executes MuTect2 in parallelized manner on split BED file - approx 20 min per sample runtime)
3. `process/mutect2/Snakefile_step2merge` (merges MuTect2 parallelized outputs per sample)
4. `process/Snakefile_step3` (executes MuTect1, MuTect2 filtering, Varscan (CN, Somatic), Strelka, Sequenza, VCFIntersect)
5. `process/Snakefile_step4` (executes hg19tohg38LiftOver)
6. `process/Snakefile_step5_hg38_indel` + `process/Snakefile_step5_hg38_snv`(executes VCFtoMAF. Make sure you run for both hg19 and hg38)

OncoKb-Annotator was ran on all MAF's, but not using Snakemake, as it required Samwise with internet access. Jobs
had to be parallelized on Samwise with *screen*, which Snakemake cannot track for validity. Script can be found under
`oncokb/run_oncokb.sh`
