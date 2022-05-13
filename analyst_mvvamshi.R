#Reading the genes_expression from the programmer output file cuffdiff_out

df <- read.table("/projectnb/bf528/users/dachsund/project_2/cuffdiff_out/gene_exp.diff", header=TRUE)

##########--------subseting the dataframe where STATUS IS OK--------#########
df_1 <- subset(df, status == 'OK')

##----check the dataframe values of Neonatal and the Adult columns have >1---##
df_2 <- subset(df_1, value_1 > 1 | value_2 > 1)

   ##########-----------sort the data by order by q_value-----------########## 
df_3 <- df_2[order(df_2$q_value), ]

   ##########-----------Now take the top 10 genes-----------##########

df_top_10 <- df_3[1:10, c("gene", "value_1", "value_2", "log2.fold_change.", "p_value", "q_value")]

  ############---------write the file into csv.-----------##########

write.csv(df_top_10, "top_10_genes.csv")

  ##########---------Plotting a histogram for all the genes-----------########

histogram(df_3$log2.fold_change., breaks = 30, main="Log2 Fold Change for All Genes", xlab = "Log2 Fold Change Value")

  ############------Plotting a histogram for all significant genes---##########

df_sig <- subset(df, df$significant=='yes')
histogram(df_sig$log2.fold_change., breaks = 30, main="Log2 Fold Change for Significant Genes", xlab = "Log2 Fold Change Value")

   ############------Subsetting the data by Up-regulated  genes---##########

up_genes <- subset(df_sig, df_sig$log2.fold_change.>0)

   ############------Subsetting the data by Up-regulated  genes---##########

down_genes <- subset(df_sig, df_sig$log2.fold_change.<0)

   ############------write the data into csv---##########

write.csv(up_genes$gene, row.names=FALSE, quote =FALSE, file = "up_genes.csv")
write.csv(down_genes$gene, row.names=FALSE, quote =FALSE, file = "down_genes.csv")
