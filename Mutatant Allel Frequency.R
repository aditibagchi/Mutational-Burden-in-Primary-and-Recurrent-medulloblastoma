#Mutationallelefrequency(MAF)
#Calculating MAF of POLE and also comparing it with other mutations.
Tools    vcfR::
         ggplot2::

#Method obtain the mutation allel frequency from VCF
  # Specify your file:
MB_REC_44 ='/Volumes/projects_secondary/jewell/EGAD00001000946_4/primary_recurrent/raw_somatic_vcfs/MB-REC-44_tumor.sv.vcf'
# Load the VCF file:
vcf44 = read.vcfR(MB_REC_44)

# Load the function to get the chr, pos & depth:
get_tumor_ref_alt_depth=function(vcf44){
  # x=as.data.frame(x@gt)
  # list=strsplit(x=x$TUMOR,split = ':',fixed = TRUE)   
  m=as.data.frame(extract.gt(vcf44,element='AD'))
  as.character(m$TUMOR)
  list=strsplit(m$TUMOR,',',fixed=TRUE)
  
  # m=matrix(unlist(list),ncol=10,byrow=TRUE) # does not work if lists not all same length
  d = as.data.frame(matrix(unlist(list), ncol=2,byrow = TRUE))
  d = as.data.frame(matrix(unlist(list), ncol=2,byrow = TRUE), stringsAsFactors = FALSE)
  colnames(d) = c('t_ref_count','t_alt_count')
  # colnames(m)=unlist(strsplit(x$FORMAT[1],':',TRUE))
  
  # Now get the chrom & pos
  chrpos=as.data.frame(vcf44@fix)
  chrpos=as.data.frame(vcf44@fix, stringsAsFactors = FALSE)
 chrpos=as.data.frame(vcf44@fix, stringsAsFactors = FALSE)
  d$CHROM=chrpos$CHROM
  d$POS=chrpos$POS
  return(d)
}

# Get a df that has four columns:
# column 1 = tumor reference count
# column 2 = tumor alternate allele count
# column 3 = chromosome
# column 4 = position
df = get_tumor_ref_alt_depth(vcf44)

#  Create to dataframe with total depth and also "mutant allele frequency); 
# Convert d to a matrix first to convert the rows to numeric
MB44 <- data.matrix(d, rownames.force = NA)
#Then reconvert it to dataframe
MB44 <- as.data.frame(MB44, stringsAsFactors = FALSE)
#Then add columns by adding ref_depth and allel depth that will give the total depth for the varaint
MB44$Total_depth <- MB44$t_ref_count + MB44$t_alt_count
#Then add column by dividing allel_depth by total_depth to get Mutant allele frquency
MB44$MAF <- MB44$t_alt_count / MB44$Total_depth
#subsetting for total depth more than 10
MB44_Subset_Depth10X <- MB44[ which(MB44$Total_depth >10),]
#Subsetting for total MAF of more than 0.1
MB44_Subset_Depth10X_MAF <- MB44_Subset_Depth10X[ which(MB44_Subset_Depth10X$MAF > 0.2),]

# Data frame with al mutaions with  more MAF than 0.49
MB44SUB <- MB44_Subset_Depth10X[ which(MB44_Subset_Depth10X$MAF > 0.49),]
MB44SUB$NAME <- c("MAF>0.49")
#Data frame witk all mutations with less MAF than 0.49
MB44SUB1 <- MB44_Subset_Depth10X_MAF[ which(MB44_Subset_Depth10X_MAF$MAF < 0.49),]
MB44SUB1$NAME <- c("MAF<0.49")
#Now join the rows of MB44SUB and MB44SUB1 to create one Data frame
FinalMB44 <- rbind(MB44SUB, MB44SUB1)
 #Now to use ggplot2:: to create density plot ; The MAF for POLE mutation for position "132673703" is 0.49
ggplot(FinalMB44, aes(x=FinalMB44$MAF, color=FinalMB44$NAME, fill=FinalMB44$NAME)) +
  geom_density() + theme_minimal() + geom_vline(aes(xintercept = median(FinalMB44$MAF)), linetype = "dashed") + 
   scale_fill_brewer (palette = "BuGn") + scale_color_brewer("blue", "Green") + xlab("Mutation Allele Frequency")+
   ylab("Density") + theme(axis.title.x = element_text(face = "bold", color = "black", size = 12),axis.title.y = element_text(face = "bold", color = "black", size =12))

  
 
 