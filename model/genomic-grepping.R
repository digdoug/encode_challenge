# install dependencies
#source("https://bioconductor.org/biocLite.R")
#biocLite("GenomicRanges")
#biocLite("BSgenome.Hsapiens.UCSC.hg19")
library(BSgenome.Hsapiens.UCSC.hg19) ## our reference sequence
library(GenomicRanges) ## GRanges lives here

#setwd("~/Documents/brg_work/")
genome_file = read.table("genomic-test.txt")

#genome_file2 = read.table("ladder_regions.blacklistfiltered.bed")
genome_file[] = lapply(genome_file, as.character)

## parse commandline arguments
#args = commandArgs(trailingOnly=TRUE)
#print(args)

## load bins
#bins = read.table(args[1])
#colnames(bins) <- c('ref', 'start', 'stop')
#bins[] = lapply(genome_file, as.character)
output_genome_table = genome_file

# create genomic data column
output_genome_table$newcol <- rep(NA,nrow(output_genome_table))

for (i in 1:nrow(output_genome_table)){
  
      gr = GRanges(output_genome_table$V1[i], 
                   IRanges(as.numeric(output_genome_table$V2[i]),
                           width = 200))      
      seq = getSeq(BSgenome.Hsapiens.UCSC.hg19, gr)
      dnaString = as.character(seq)
      output_genome_table$newcol[i] = dnaString
}

# write file
#output_string = paste("output/","")
write.table(output_genome_table,file=paste(args[1],'gRanges.txt',sep=''),row.names=F,quote=F)
