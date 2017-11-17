#!/usr/bin/Rscript

# dna shape stuff
# upload dependencies 
library(devtools)
library(BiocInstaller)
library(BSgenome.Scerevisiae.UCSC.sacCer3)
library(GenomicRanges)
library(AnnotationHub)
library(BSgenome.Hsapiens.UCSC.hg19)
library(DNAshapeR)

# set working directory
setwd('.')
# upload files
data = read.table("full_three_fourth_bound.txt")
test_data = read.table("test_data.txt")

data2 = read.table("full_half_unbound.txt")
data3 = read.table("full_1percent_bound.txt")

# example of how to do a one genomic coordinate of 200 bp width (as in chip-seq labels) on the forward and reverse strand
shape_data = data.frame(matrix(NA,nrow = nrow(data), ncol = 4))


shape_data2 = data.frame(matrix(NA,nrow = nrow(data2), ncol = 4))
shape_data3 = data.frame(matrix(NA,nrow = nrow(data3), ncol = 4))

# file 1
for (i in 1:nrow(data)){
  gr	<- GRanges(seqnames	= data$V1[i],
                strand	= c("+"),
                ranges	= IRanges(start	= c(data$V2[i]),	width	= 200))
  
  getFasta(gr,	Hsapiens,	width	= 200,	filename	= "tmp.fa")
  fn	<- "tmp.fa"
  pred	<- getShape(fn)
  
  shape_data[i,1] <- mean(pred$MGW[!is.na(pred$MGW[1,])])
  shape_data[i,2] <- mean(pred$HelT[!is.na(pred$HelT[1,])])
  shape_data[i,3] <- mean(pred$ProT[!is.na(pred$ProT[1,])])
  shape_data[i,4] <- mean(pred$Roll[!is.na(pred$Roll[1,])])
}

# file 2
for (i in 1:nrow(data2)){
gr	<- GRanges(seqnames	= data2$V1[i],
              strand	= c("+"),
              ranges	= IRanges(start	= c(data2$V2[i]),	width	= 200))

getFasta(gr,	Hsapiens,	width	= 200,	filename	= "tmp.fa")
fn	<- "tmp.fa"
pred	<- getShape(fn)

shape_data2[i,1] <- mean(pred$MGW[!is.na(pred$MGW[1,])])
shape_data2[i,2] <- mean(pred$HelT[!is.na(pred$HelT[1,])])
shape_data2[i,3] <- mean(pred$ProT[!is.na(pred$ProT[1,])])
shape_data2[i,4] <- mean(pred$Roll[!is.na(pred$Roll[1,])])
}

# file 3
for (i in 1:nrow(data3)){
  gr	<- GRanges(seqnames	= data3$V1[i],
                strand	= c("+"),
                ranges	= IRanges(start	= c(data3$V2[i]),	width	= 200))
  
  getFasta(gr,	Hsapiens,	width	= 200,	filename	= "tmp.fa")
  fn	<- "tmp.fa"
  pred	<- getShape(fn)
  
  shape_data3[i,1] <- mean(pred$MGW[!is.na(pred$MGW[1,])])
  shape_data3[i,2] <- mean(pred$HelT[!is.na(pred$HelT[1,])])
  shape_data3[i,3] <- mean(pred$ProT[!is.na(pred$ProT[1,])])
  shape_data3[i,4] <- mean(pred$Roll[!is.na(pred$Roll[1,])])
}

# combine files together - put labels on end 
training_data <- cbind(data,shape_data)

training_data2 <- cbind(data2, shape_data2)
training_data3 <- cbind(data3, shape_data3)

training_data2 <- training_data

factors1 <- training_data2$V1

labels <- training_data2$V4
training_data2$V4 <- NULL
training_data2$labels <- labels
factors2 <- training_data2$labels

training_data$X1 <- as.numeric(training_data2$X1)
factors3 <- training_data2$X1 

training_data2$X1 <- as.numeric(factors3)
training_data2$V1 <- as.numeric(factors1)
training_data2$labels <- as.numeric(factors2)

write.table(training_data,file="training_data_sample_1_fourth.txt",sep="\t",col.names= F, row.names = F)

# average all the values 
# dealing only w forward strands currently 
pred$MGW[!is.na(pred$MGW[1,])]
pred$HelT[!is.na(pred$HelT[1,])]
pred$ProT[!is.na(pred$ProT[1,])]
pred$Roll[!is.na(pred$Roll[1,])]

mean(pred$MGW[!is.na(pred$MGW[1,])])
mean(pred$HelT[!is.na(pred$HelT[1,])])
mean(pred$ProT[!is.na(pred$ProT[1,])])
mean(pred$Roll[!is.na(pred$Roll[1,])])


nrow(mydata)
length(nrow(mydata))
mydata[1,]






