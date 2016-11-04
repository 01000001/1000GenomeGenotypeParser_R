# Download the variant files
j=1
while test $j -lt 23; do
  wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.chr${j}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz &
  echo $j
  j=$(( $j + 1 ))
done
wait

# Download 1000 genomes phenotype data file
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/20130606_g1k.ped
