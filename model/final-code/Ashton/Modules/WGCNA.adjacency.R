#!/usr/bin/Rscript
library("WGCNA")
allowWGCNAThreads()
load("topExpressedData.RData")
load("gene_connectivites.RData")
load("Normalized_and_clean.RData")
datExprFinalT <-t(datExprFinal)
sftCnnct <- softConnectivity(datExprFinalT, type="unsigned", blockSize=3000)


#We then keep the genes with scores over 500

sortedGeneConnectivites <- sftCnnct
names(sortedGeneConnectivites) <- row.names(datExprFinal)
topConnectedGenes <- sortedGeneConnectivities[sortedGeneConnectivities > 500]
#Have it to here for sure?
include_list <- names(topConnectedGenes)
datExprFinal[include_list,]
topDatExprT <- t(topDatExpr)
topAdjacency <- adjacency(topDatExprT)
TOM = TOMsimilarity(topAdjacency)
dissTOM = 1-TOM
save(dissTOM, TOM, toAdjacency, file="TOMS_and_adjacency.RData")
