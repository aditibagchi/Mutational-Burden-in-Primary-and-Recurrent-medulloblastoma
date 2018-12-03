##Summary of mutations in all the tumors from ICGC
ggplot2::
Signatures_Table <- read_csv("~/Desktop/Data_Analysis/Data_Analysis_July_-December_2018/Signatures_Table.csv") 
HRD_Signature_Table <- read_csv("~/Desktop/Data_Analysis/Data_Analysis_July_-December_2018/HRD_Signature_Table.csv")

ggplot(data= HRD_Signature_Table, aes(x=HRD_Signature_Table$Tumor, y=HRD_Signature_Table$Fraction, fill=HRD_Signature_Table$Signature)) +
  geom_bar(stat="identity", width = 0.8) +  scale_y_continuous(name="Fraction of Total Mutations", limits=c(0, 1.0)) + theme_minimal() + scale_fill_brewer("Paired") + theme(axis.text.x = element_text(face = "bold", color = "black", size = 12, angle = 90))
Signature_Table_HRD_1_5 <- read_csv("~/Desktop/Data_Analysis/Data_Analysis_July_-December_2018/Signature_Table_HRD_1_5.csv")
ggplot(data= Signature_Table_HRD_1_5, aes(x=Signature_Table_HRD_1_5$Tumor, y=Signature_Table_HRD_1_5$Fraction, fill=Signature_Table_HRD_1_5$`Signature `)) +
  geom_bar(stat="identity") +  scale_y_continuous(name="Fraction of Total Mutations", limits=c(0, 1.0)) + theme_minimal() + scale_fill_brewer(palette = "Paired") + theme(axis.text.x = element_text(face = "bold", color = "black", size = 12, angle = 90))
