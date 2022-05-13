## Individual-project-Shrishtee-kandoi

### Transcriptional Profiling of mammalian cardiac regeneration with mRNA-Seq

- Roles: Programmer and Analyst 
- Previously performed role in this project: Biologist

In this project, I aim to attempt to replicate the O'Meara et al. results. I chose to perform the programmer and analyst steps from Project 2, "Bioinformatics Reanalysis of: Transcriptional Profile of Mammalian Cardiac Regeneration with mRNA- Seq." As the project's original biologist, I was interested in comparing the original outputs I worked on for the project to the work I could perform as a programmer and analyst.

## Repository contents

### The programmer files contain:

#### run_tophat.qsub

Input: P0_1_1.fastq, P0_1_2.fastq, mm9 reference genome

Dependencies: python2, Bowtie2, topHat, samtools

Execution: qsub run_tophat.qsub

Output: accepted_hits.bam file

#### run_RSeQC.qsub

Input: accepted_hits.bam, accepted_hits.bam.bai, mm9.bed

Dependencies: python3, rseqc, samtools, R

Execution: qsub run_RSeQC.qsub

Output: geneBody_coverage plot, inner_distance plot, one quality control matrix

#### run_cufflinks.qsub

Input: accepted_hits.bam file, mm9.gtf and mm9.fa

Dependencies: python3, cufflinks, R

Execution: qsub run_cufflinks.qsub

Output: gene.FPKM_tracing

#### run_cuffdiff.qsub

Input: accepted_hits.bam files for P0_1, P0_2, AD_1, AD_2

Dependencies: cufflinks

Execution: qsub run_cuffdiff.qsub

Output: gene_exp.diff

#### FPKMhistogram.R

Input: genes.FPKM_tracing

Dependencies: tidyverse package

Execution: It is recommended to run this code on R studio

Alternatively to run on command line:

  module load R/4.0.2

  Rscript FPKMhistogram.R
Output: A histogram for FPKM values of all genes



### The analyst folder contains the script:

Analyst1.R




individual-project-Shrishtee-kandoi created by GitHub Classroom
