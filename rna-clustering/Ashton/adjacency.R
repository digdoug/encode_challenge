#!/usr/bin/Rscript
load("Normalized_and_clean.RData")
library("WGCNA")
adjMat <- adjacency(t(datExprFinal))
save(adjMat, file="adjacency.RData")
