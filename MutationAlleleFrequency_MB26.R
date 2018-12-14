#Mutationallelefrequency(MAF) for MB-REC-26
#Calculating MAF of POLE and also comparing it with other mutations.
Tools    vcfR::
         ggplot2::
         scales::
         utils::
  
  #Method obtain the mutation allel frequency from VCF
  # Specify your file:
  MB_REC_26="/Volumes/projects_secondary/jewell/EGAD00001000946_4/primary_recurrent/raw_somatic_vcfs/MB-REC-26_tumor.sv.vcf"
  MB_REC_26_Annotated= "/Volumes/projects_secondary/jewell/EGAD00001000946_4/primary_recurrent/annotated_vcfs/MB-REC-26_tumor_PASS.remap.sv.vep.vcf"
# Load the VCF file:
vcf26An = read.vcfR(MB_REC_26_Annotated)

# Load the function to get the chr, pos & depth:
get_tumor_ref_alt_depth=function(vcf26An){
  # x=as.data.frame(x@gt)
  # list=strsplit(x=x$TUMOR,split = ':',fixed = TRUE)   
  m=as.data.frame(extract.gt(vcf26An,element='AD'))
 Mx <-  as.character(m$TUMOR)
  list=strsplit(Mx,',',fixed=TRUE)
  
  # m=matrix(unlist(list),ncol=10,byrow=TRUE) # does not work if lists not all same length
  MB26 = as.data.frame(matrix(unlist(list), ncol=2,byrow = TRUE))
  MB26 = as.data.frame(matrix(unlist(list), ncol=2,byrow = TRUE), stringsAsFactors = FALSE)
  colnames(MB26) = c('t_ref_count','t_alt_count')
  # colnames(m)=unlist(strsplit(x$FORMAT[1],':',TRUE))
  
  # Now get the chrom & pos
  chrpos=as.data.frame(vcf26An@fix, stringsAsFactors = FALSE)
  MB26$CHROM=chrpos$CHROM
  MB26$POS=chrpos$POS

  
  return(MB26)
}

#  Create to dataframe with total depth and also "mutant allele frequency); 
# Convert d to a matrix first to convert the rows to numeric
MB26m <- data.matrix(MB26, rownames.force = NA)
#Then reconvert it to dataframe
MB26 <- as.data.frame(MB26m, stringsAsFactors = FALSE)
#Then add columns by adding ref_depth and allel depth that will give the total depth for the varaint
MB26$Total_depth <- MB26$t_ref_count + MB26$t_alt_count
#Then add column by dividing allel_depth by total_depth to get Mutant allele frquency
MB26$MAF <- MB26$t_alt_count / MB26$Total_depth
#subsetting for total depth more than 10
MB26_Subset_Depth10X <- MB26[ which(MB26$Total_depth >10),]
#Subsetting for total MAF of more than 0.17
MB26_Subset_Depth10X_MAF <- MB26_Subset_Depth10X[ which(MB26_Subset_Depth10X$MAF > 0.17),]
MB26_Subset_Depth10X_MAF$NAME <- c("MAF>0.17")
MB26_Subset_Depth10X_MAF_less <- MB26_Subset_Depth10X[ which(MB26_Subset_Depth10X$MAF < 0.17),]
MB26_Subset_Depth10X_MAF_less$NAME <- c("MAF<0.17")
FinalMB26An <- rbind(MB26_Subset_Depth10X_MAF_less, MB26_Subset_Depth10X_MAF)
mean(MB26_Subset_Depth10X_MAF$MAF)
[1] 0.2577228
median(MB26_Subset_Depth10X_MAF$MAF)
[1] 0.2307692

ggplot(FinalMB26An, aes(x=FinalMB26An$MAF, color=FinalMB26An$NAME, fill=FinalMB26An$NAME)) +
  geom_density() + theme_minimal() + geom_vline(aes(xintercept = median(FinalMB26An$MAF)), linetype = "dashed") + 
  scale_fill_brewer (palette = "BuGn") + scale_color_brewer("blue", "Green") + xlab("Mutation Allele Frequency")+
  ylab("Density") + theme(axis.title.x = element_text(face = "bold", color = "black", size = 12),axis.title.y = element_text(face = "bold", color = "black", size =12))



