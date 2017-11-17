## install dependencies
#source("https://bioconductor.org/biocLite.R")
#biocLite("GenomicRanges")
#biocLite("BSgenome.Hsapiens.UCSC.hg19")
#biocLite("DNAshapeR")


## load libraries
library(GenomicRanges)
library(BSgenome.Hsapiens.UCSC.hg19)
library(DNAshapeR)


## parse commandline arguments
args = commandArgs(trailingOnly=TRUE)
print(args)


## load bins
bins = read.table(args[1])
colnames(bins) <- c('ref', 'start', 'stop')


## initialize data frame for storing data
df = data.frame(matrix(ncol=800, nrow=0))
df_colnames = vector(length=10)
for (i in 1:200) {
	df_colnames[i] <- paste('MGW', i, sep='')
	df_colnames[i+200] <- paste('HelT', i, sep='')
	df_colnames[i+400] <- paste('ProT', i, sep='')
	df_colnames[i+600] <- paste('Roll', i, sep='')
}
colnames(df) <- df_colnames


## get shape features
for (i in 1:nrow(bins)) {
	gr <- GRanges(seqnames = bins$ref[i],
				  strand   = c("+"),
                  ranges   = IRanges(start = c(bins$start[i]-2), width = 204))
	getFasta(gr, Hsapiens, width = 204, filename = paste(args[1], '.tmp.fa'))
  	fn   <- paste(args[1], '.tmp.fa')
  	pred <- getShape(fn)
	
	MGW  = pred$MGW
 	HelT = pred$HelT
  	ProT = pred$ProT
  	Roll = pred$Roll
	
	MGW  =  MGW[3:(length(MGW)-2)]
	HelT = HelT[3:(length(HelT)-1)]
	ProT = ProT[3:(length(ProT)-2)]
	Roll = Roll[3:(length(Roll)-1)]

	df[i,] <- c(MGW, HelT, ProT, Roll)
}


## write output to file
output = cbind(bins, df)
write.table(output, file=paste(args[1], '.shapes', '.txt', sep=''), sep='\t', col.names=T, row.names=F, quote=F)
