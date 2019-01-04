##Code Written for final tumor mutation figure presented on 1162019
##Has all the samples from ICGC 

Tumor_Mutational_Burden_Final <- read_csv("Tumor_Mutational_Burden_Final.csv")
G <- ggplot(Tumor_Mutational_Burden_Final, aes(Tumor_Mutational_Burden_Final$Tumor_Sample, Tumor_Mutational_Burden_Final$`Total Mutation Burden`))
G + geom_bar(stat = "identity", aes(fill = Tumor_Mutational_Burden_Final$TYPE))+ 
  scale_y_continuous(name="Mutations/Mb", limits=c(0, 20)) + theme_minimal() + 
  scale_fill_brewer(palette = "Set1") + 
  theme(axis.text.x = element_text(color = "black", size = 8, angle = 90)) 

Hypermut_Medulloblastoma <- read_csv("Tumor_Mutation_Burden_Hyper_Mut.csv")
G <- ggplot(Hypermut_Medulloblastoma, aes(Hypermut_Medulloblastoma$Tumor_Sample, Hypermut_Medulloblastoma$`Total Mutation Burden`))
G + geom_bar(stat = "identity", aes(fill = Hypermut_Medulloblastoma$TYPE), width = 0.9)+ 
  scale_y_continuous(name="Mutations/Mb", limits=c(0, 40)) + theme_minimal() + scale_fill_brewer(palette = "Set1")+ 
  theme(axis.text.x = element_text(color = "black", size = 8, angle = 90)) + theme(aspect.ratio = 6/1) + scale_x_discrete(name = "Tumor")




