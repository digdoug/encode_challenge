#!/usr/bin/Rscript

install.packages("devtools")
# with Documentation specify build_vignettes as TRUE
install.packages("BiocInstaller", repos="http://www.bioconductor.org/packages/3.1/bioc")
source("http://bioconductor.org/biocLite.R")
biocLite("BSgenome.Scerevisiae.UCSC.sacCer3") # this is necessary for determining parameters from genomic coordinates
# if wanting to pull genomic intervals from public domain projects
biocLite("AnnotationHub")
biocLite("BSgenome.Hsapiens.UCSC.hg19")
biocLite(c("GenomicRanges","Biostrings"))
install_github(repo =  "TsuPeiChiu/DNAshapeR", build_vignettes = TRUE)
