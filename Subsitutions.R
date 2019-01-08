## Bar Graph for subsitutions.
Subsitution_Recurrent_ICGC <- read_csv("Subsitution_Recurrent_ICGC.csv")
View(Subsitution_Recurrent_ICGC)
ggplot(data= Subsitution_Recurrent_ICGC, aes(x=Subsitution_Recurrent_ICGC$Tumor, y=Subsitution_Recurrent_ICGC$Number, fill=Subsitution_Recurrent_ICGC$Subsitution)) +
  geom_bar(stat="identity", width = 0.8) +  scale_y_continuous(name="Total Mutations") + theme_minimal() + scale_fill_brewer(palette = 3) + theme(axis.text.x = element_text(face = "bold", color = "black", size = 12, angle = 90))
Subsitution_Hypermutatant_ICGC <- read_csv("Subsitution_Hypermutatant_ICGC.csv")
ggplot(data= Subsitution_Hypermutatant_ICGC, aes(x=Subsitution_Hypermutatant_ICGC$Tumor, y=Subsitution_Hypermutatant_ICGC$Number, fill=Subsitution_Hypermutatant_ICGC$Subsitution)) +
  geom_bar(stat="identity", width = 0.8) +  scale_y_continuous(name="Total Mutations") + theme_minimal() + scale_fill_brewer(palette = 3) + theme(axis.text.x = element_text(face = "bold", color = "black", size = 12, angle = 90))+
  theme(aspect.ratio = 8/1)
## Total 6 subsitutions in RM
Total_Subsitutions_RM <- read.csv("~/Desktop/Data_Analysis/Data_Analysis_July_-December_2018/Mutational-Burden-in-Primary-and-Recurrent-medulloblastoma/Mutational-Burden-in-Primary-and-Recurrent-medulloblastoma/Total_Subsitutions_RM.csv")
ggplot(data= Total_Subsitutions_RM, aes(x=Total_Subsitutions_RM$Subsitution, y=Total_Subsitutions_RM$Number, fill=Total_Subsitutions_RM$Subsitution)) +
  geom_bar(stat="identity", width = 0.8) +  scale_y_continuous(name="Total Mutations") + theme_minimal() + scale_fill_brewer(palette = 3) + theme(axis.text.x = element_text(face = "bold", color = "black", size = 12, angle = 90))+
  theme(aspect.ratio = 4/1)
