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
  colnames(d) = c('t_ref_count','t_alt_count')
  # colnames(m)=unlist(strsplit(x$FORMAT[1],':',TRUE))
  
  # Now get the chrom & pos
  chrpos=as.data.frame(vcf44@fix)
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
