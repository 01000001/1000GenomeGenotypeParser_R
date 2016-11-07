#Script to combibne the genotype RData chunks into one RData file
#
# examples:
# 
# Rscript Combine_genotype_chunks.R 21
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
  
  #first see how many chunks are there from the same genotype in the directory
  files_in_dir <- list.files(path = "../data/")
  criteria_for_names <- paste("CHR", args[1], "filtered_chunk_",sep="")
  print(criteria_for_names)
  
  list_of_genotypes <- grep(criteria_for_names,files_in_dir,value = TRUE)
  print(list_of_genotypes)
  
  
  for (i in 1:(length(list_of_genotypes))){
    
    print(i)
    
    load(list_of_genotypes[i])
    
    print(dim(output))

    if(i == 1){
      combined_output <- output
    } else {
      combined_output <- cbind(combined_output,output)
      print("combined output dim")
      print(dim(combined_output))
      
    }

    print("dim of combined output: ")
    print(dim(combined_output))
  }
  
  save(combined_output, file=paste("combined_outputCHR",args[1],".RData", sep=""))
  
}
