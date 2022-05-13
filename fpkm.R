library('tidyverse')
genes_fpkm <- read.table('genes.fpkm_tracking')
colnames(genes_fpkm) <- genes_fpkm[1,] #column names are in the first row
genes_fpkm <- genes_fpkm[-1,] #get rid of that first row
genes_fpkm$P0_FPKM <- as.numeric(genes_fpkm$P0_FPKM) #convert to numeric

#creating histogram
fpkm <- genes_fpkm$P0_FPKM
fpkm <- fpkm[which(fpkm > 0)] #significant reduction in the amount after application of filter (FPKM>0)
hist(log10(fpkm), main = 'Histogram of log adjusted FPKM values')