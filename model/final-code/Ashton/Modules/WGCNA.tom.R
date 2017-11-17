#!/usr/bin/Rscript
library("WGCNA")
disableWGCNAThreads()
load("adjacency_matrix.RData")
tom= TOMsimilarity(adjacency.10.8)
save(tom, file="TOM.10.8.RData")

