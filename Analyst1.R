library('tidyverse')
library('gridExtra')
library('formattable')
# Chunks are split and numbered corresponding to section 6 of https://bf528.readthedocs.io/en/latest/content/projects/project_2_rnaseq_1/project_2_rnaseq_1.html#identifying-differentially-expressed-genes-associated-with-myocyte-differentiation 


#1 Load Expression Data
gene_exp <- read_delim('/projectnb/bf528/users/frizzled/project_2/data/cuffdiff_out/gene_exp.diff') %>%
  arrange(q_value)
head(gene_exp, 10)


#2 Plot Histogram of log2fold change for all genes
log2fold_hist <- function(exp_data) {
  p <- exp_data %>% 
    ggplot(aes(x=`log2(fold_change)`)) +
    geom_histogram(color='grey40',fill='lightsalmon1', bins = 20) +
    theme_minimal() +
    labs(title='Counts of Log2-Fold Change obtained from DE analysis 
         \n(vP0vs.vAd)\n',
         x = 'Log2 Fold Change', y = 'Count') +
    theme(plot.title = element_text(vjust=1))
  
  
  return(p)
}
log2fold_hist(gene_exp)

#3 Significant Subset
significant_subset <- gene_exp %>%
  dplyr::filter(significant == 'yes')
significant_subset
tail(significant_subset)

#4 Histogram of log2fold change for significant subset
log2fold_hist(significant_subset)

#5 Up regulated and Down Regulated from significant subset
up_regulated_significant <- significant_subset %>%
  dplyr::filter(`log2(fold_change)` > 0)
down_regulated_significant <- significant_subset %>%
  dplyr::filter(`log2(fold_change)` < 0)
up_regulated_significant
down_regulated_significant



#6 Write up & down regulated to csv
write(up_regulated_significant$gene, file = 'up_regulated_significant.csv')
write(down_regulated_significant$gene, file = 'down_regulated_significant.csv')




#deliverable bullet 1: A table of the top 10 differentially expressed genes and statistics from 6.1
top_10_diffexp <- head(gene_exp, 10) %>%
  dplyr::select(gene, value_1, value_2, `log2(fold_change)`, p_value, q_value) %>%
  dplyr::rename(Gene = gene, `P0 FPKM` = value_1, `Ad FPKM` = value_2, `Log2 Fold Change` = `log2(fold_change)`, `p-value` = p_value, `q-value` = q_value)
top_10_diffexp

# Differentially Expressed Genes Detected at q < 0.05 for use in table in report
print(str_glue('Number of genes detected at q < 0.05: {nrow(significant_subset)}'))
print(str_glue('Number of genes detected at q < 0.05 & up-regulated: {nrow(up_regulated_significant)}' ))
print(str_glue('Number of genes detected at q < 0.05 & down-regulated: {nrow(down_regulated_significant)}' ))

# deliverable bullet point 3:
#A report of the number of differentially expressed genes detected at p<0.01, and the numbers of up- and down- regulated genes at this significance level
# Differentially Expressed Genes Detected at p < 0.01
p01_gene_exp <- gene_exp %>%
  dplyr::filter(p_value < 0.01)
# up-regulated at p<0.01
p01_gene_exp_up <- p01_gene_exp %>%
  dplyr::filter(`log2(fold_change)` > 0)
# down-regulated at p<0.01
p01_gene_exp_down <- p01_gene_exp %>%
  dplyr::filter(`log2(fold_change)` < 0)
print(str_glue('Number of genes detected at p < 0.01: {nrow(p01_gene_exp)}'))
print(str_glue('Number of genes detected at p < 0.01 & up-regulated: {nrow(p01_gene_exp_up)}' ))
print(str_glue('Number of genes detected at p < 0.01 & down-regulated: {nrow(p01_gene_exp_down)}' ))


# Function specifically for only significant labeled data
log2fold_hist_sig <- function(exp_data) {
  p <- exp_data %>% 
    ggplot(aes(x=`log2(fold_change)`)) +
    geom_histogram(color='grey40',fill='lightsalmon1', bins = 20) +
    theme_minimal() +
    labs(x = 'Log2 Fold Change', y = 'Count')
  
  
  return(p)
}
plot1 <- log2fold_hist(gene_exp)
plot2 <- log2fold_hist_sig(significant_subset)
both_plots <- grid.arrange(plot1, plot2, ncol=1)
ggsave("both_plots.tiff",both_plots,dpi=300)


# Non-essential code for analysis methodology.  Used for Figure generation.
formattable(top_10_diffexp)
