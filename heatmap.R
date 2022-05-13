library(ggplot2)
library(tidyr)
library(dplyr)


#--Reading the genes_exp.diff  from the programmer output file cuff_diff_out---##

df_exp<-read.csv('/projectnb/bf528/users/dachsund/project_2/cuffdiff_out/gene_exp.diff',sep='\t',header=TRUE)

df_sig<- df_exp[df_exp$significant == 'yes', ]
######------------Extract the 1000 significant  genes to plot----------######

df_order <- df_sig[order(df_exp$q_value)[1:1000],] 

#########-----------------#Get significant genes------------##########
df_sig_genes<-df_sig$gene


#--Reading the genes with fpkm  data from the biologist output file cuff_diff_out---##
fpkm_final <-read.csv("/projectnb/bf528/users/dachsund/project_2/df_fpkm_final.csv", sep = ',', header = T)
fpkm_sig <- filter(fpkm_final, gene_short_name%in% df_sig_genes)
row.names(fpkm_sig)<-fpkm_sig$gene_short_name
heatmap_colors<-colorRampPalette(c("orange","red", "yellow"), interpolate = "spline")

  ######------------------------PLot the Heatmap----------------############
sig_heatmap <- heatmap(as.matrix(fpkm_sig[, 3:5]),
                        scale = "row", 
                        col = heatmap_colors(10),
                        xlab = "Sample name", 
                        ylab = "Genes")
