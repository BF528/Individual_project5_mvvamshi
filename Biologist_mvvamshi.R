library(ggplot2)
library(tidyr)
library(dplyr)
library(magrittr)
library(tibble)
library(gridExtra)


#--Reading the fpkm_tracking  from the programmer output file cuff_diff_out---##

df_p0_1<-read.csv('/projectnb/bf528/users/dachsund/project_2/cuffdiff_out/genes.fpkm_tracking',sep='\t',header=T)%>%
  select(gene_short_name,P0_FPKM)

###---------Reading the fpkm_matrix  from the data of bf528 course-------######

df_fpkm<- read.csv('/project/bf528/project_2/data/fpkm_matrix.csv',sep='\t',header = T)


    #####-----Combine the data by P0_FPKM and gene_short_name-------######

df_p0_1_grp<-aggregate(P0_FPKM~gene_short_name, data = df_p0_1, FUN = mean, na.rm = TRUE)

 #####-------a new data frame with gene_short_name and tracking name------######

df_id_name<-read.csv('/projectnb/bf528/project_2/data/samples/P0_2/genes.fpkm_tracking',sep='\t',header = TRUE)
df_id_name<-df_id_name%>% select(tracking_id, gene_short_name)
df_fpkm<-merge(df_fpkm,df_id_name,by='tracking_id')


  ######---------------Group the dataframe  by gene short name----------#######

df_fpkm_combined<-aggregate(cbind(Ad_1_FPKM,Ad_2_FPKM,P0_2_FPKM,P4_1_FPKM,P4_2_FPKM,P7_1_FPKM,P7_2_FPKM)~gene_short_name, data = df_fpkm, FUN = mean, na.rm = TRUE)
df_fpkm_merged<-merge(df_fpkm_combined,df_p0_1_grp,by='gene_short_name')

 ######---------Implementing fucntion rowmeans for the all the fpkms------#####

df_fpkm_merged$P0<- rowMeans(df_fpkm_merged%>% select(P0_FPKM,P0_2_FPKM), na.rm=TRUE)
df_fpkm_merged$P4<- rowMeans(df_fpkm_merged%>% select(P4_1_FPKM,P4_2_FPKM), na.rm=TRUE)
df_fpkm_merged$P7<- rowMeans(df_fpkm_merged%>% select(P7_1_FPKM,P7_2_FPKM), na.rm=TRUE)
df_fpkm_merged$Ad<- rowMeans(df_fpkm_merged%>% select(Ad_1_FPKM,Ad_2_FPKM), na.rm=TRUE)

#####--Now to create a new dataframe and make list of genes for plotting referring to the O'meara paper --------#####

df_fpkm_final<-df_fpkm_merged%>% select(gene_short_name,P0,P4,P7,Ad)
l_s<-list('Pdlim5','Pygm','Myoz2','Des','Csrp3','Tcap','Cryab')
l_m<-list('Mpc1','Prdx3','Acat1','Echs1','Slc25a11','Phyh')
l_cc<-list('Cdc7','E2f8','Cdk7','Cdc26','Cdc6','E2f1','Cdc27','Bora','Cdc45','Rad51','Aurkb','Cdc23')
x<-list('P0','P4','P7','AD')

      #######-------- Graph a plot for the sarcomere --------------#####


df_1 <- filter(df_fpkm_final, gene_short_name %in% l_s)%>%
  pivot_longer(cols = c(P0,P4,P7,Ad), names_to = "name", values_to = "value")
ls_plot<-ggplot(df_1,aes(x =factor(name,level=x), y = value,
                             color=gene_short_name,group=gene_short_name)) + 
  geom_line()+
  geom_point()+
  labs(title = "Sarcomere", x='in vivo Maturation', y="FPKM")

  ###########-------- Graph a plot for the mitochondria --------------##### 

df_2 <- filter(df_fpkm_final, gene_short_name %in% l_m)%>%
  pivot_longer(cols = c(P0,P4,P7,Ad), names_to = "name", values_to = "value")
lm_plot<-ggplot(df_2,aes(x =factor(name,level=x), y = value,color=gene_short_name,group=gene_short_name)) + 
  geom_line()+
  geom_point()+
  labs(title = "Mitochondria", x='in vivo Maturation', y="FPKM")

###########-------- Graph a plot for the Cell-Cycle --------------###########


df_3 <- filter(df_fpkm_final, gene_short_name %in% l_cc)%>%
  pivot_longer(cols = c(P0,P4,P7,Ad), names_to = "name", values_to = "value")
lc_plot<-ggplot(df_3,aes(x =factor(name,level=x), y = value,color=gene_short_name,group=gene_short_name)) + 
  geom_line()+
  geom_point()+
  labs(title = "Cell Cycle", x='in vivo Maturation', y="FPKM")

#######-----------------PLotting the dataframe-----------------#########

grid.arrange(grobs = list(ls_plot,lm_plot, lc_plot))

