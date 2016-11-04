#Script to filter out the genotypes based on the patients that we have phenotype data of
#
# examples:
# filter the downloaded data of 21chromosome 
# Rscript Filter_genotype_data.R 21
#
#

#get command line args
args <- commandArgs(trailingOnly = TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else {

  library(Matrix)
  load("phenotype.RData")
  library(methods)

  function_accomplish <- function(x,pheno,geno,chunk) {

  #z <- paste("ALL.chr",x,".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf-1.rdata",sep="")

  genotype <- readRDS(paste("ALL.chr", x, ".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf-", chunk, ".rdata",sep=""))
  genotype <- t(genotype)

  CHR_selected_genotype <- genotype[which(geno[,1] %in% pheno[,1]),]

  return(CHR_selected_genotype)

  }

#  assign(paste("baba",args[1]),666)

#  sprintf("asdasd%s",args[1])
  
  #first see how many chunks are there from the same genotype in the directory
  files_in_dir <- list.files(path = "../data/")
  criteria_for_names <- paste("ALL.chr", args[1], ".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf-",sep="")
  print(criteria_for_names)
  
  list_of_genotypes <- grep(criteria_for_names,files_in_dir,value = TRUE)
  print(list_of_genotypes)

  #get the locations on the chromosome
  base_location.matrix  <- read.csv(paste("chr",args[1],"_genotype_positions_col.csv",sep=""),header = FALSE)
  base_location.list    <- base_location.matrix[,1]

  gene_location_counter.int 	<- 1
  
  for (i in 1:(length(list_of_genotypes))){
    #genotype.id.chr22 is ok since all chromosomes have the same patient order
    #output <- function_accomplish(x=args[1], pheno=x.phenotyp, geno=genotype.id.chr22,args[2])
    output <- function_accomplish(x=args[1], pheno=x.phenotyp, geno=genotype.id.chr22,i)
    
    print(length(ls()))
    print(dim(output))
    
    if(i>1){
      output <- output[,2:dim(output)[2]]
      print("corrected dims:")
      print(dim(output))
      
    }

    colnames(output) 	<- base_location.list[gene_location_counter.int:(gene_location_counter.int+dim(output)[2]-1)]

    gene_location_counter.int = gene_location_counter.int + dim(output)[2]
    
    print(gene_location_counter.int)
    
    save(output, file=paste("CHR",args[1],"filtered_chunk_",i,".RData", sep=""))
    
  
  }
  
  


#  assign(paste("CHR",args[1],args[2],sep=""),function_accomplish(x=args[1], pheno=x.phenotyp, geno=genotype.id.chr22,args[2]))


}
