# 1000GenomeGenotypeParser_R

Collection of scripts to parse 1000 Genome Genotype data.

* Run the script download_1000genome_all_chr.sh:
```linux
./download_1000genome_all_chr.sh
```
  This downloads the data sets of genotypes per chromosome in vcf.gz format (e.g. *ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz*).

* Complie parse.c and run readParallel.R:
```linux
cc parse.c
Rscript readParallel.R
```
  This creates RData chunk files (e.g.*ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf-1.rdata*) in a form of a sparse matrix up to 1.2G per file. [Reference for more information on the parser](https://github.com/bwlewis/1000_genomes_examples).

* Filter out the genotypes on available phenotypes by running (rename first phenotypeAnonyme.RData to phenotype.RData):
```linux
Rscript Filter_genotype_data.R 22
```

* Combine the filtered genotype data
```linux
Rscript Combine_genotype_chunks.R 22
```
  This creates sparse matrices per chromose (size of 7.9 Megabyte for chromosome 22 and 43 Mb for Chr 1).


