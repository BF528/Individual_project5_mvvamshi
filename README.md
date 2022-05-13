# Individual_project5_mvvamshi
This is my Individual project on transcriptional profile of mammalian cardiac regeneration with mRNA-Seq. 

In project 2, I was the programmer who analyzed the role analyst and the biologist for this project. I investigated using the cuffdiff output files that I generated as a programmer in section 5 to execute the differentially expressed analysis, quantify Gene expression, and gene set enrichment analysis that was initially performed by the analyst in part 6. I played the job of Biologist, which entails assessing biological data and identifying trends in sarcomere, mitochondria, and cell cycle plots of differential expression results.



The programmer's output files are used in this project's downstream analysis. The data was divided into upregulated and downregulated genes using the differential expression genes file. Upregulated genes and downregulated genes data sets were used to process David functional gene enrichment set analysis for further investigation.



Gene_exp_diff <- /projectnb/bf528/users/dachsund/project_2/cuffdiff_out/gene_exp.diff

genes.fpkm_tracking <-/projectnb/bf528/users/dachsund/project_2/cuffdiff_out/genes.fpkm_tracking

fpkm_matrix <- /project/bf528/project_2/data/fpkm_matrix.csv

