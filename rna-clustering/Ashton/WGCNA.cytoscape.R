"M#!/usr/bin/Rscript
library("WGCNA")
enableWGCNAThreads(9)
load("topExpressedData.RData")
load("MergedEigenModules.RData")

#mergedColors is the color assignments
#modeulLabels is the model labels
#topDatExpr is top data expression stuff durp

trans = t(topDatExpr)
#TOM = TOMsimilarityFromExpr(trans, power = 6, nThreads = 8)
load("TOM.10.8.RData", verbose = 5)

modules = c("turquoise"," blue", "yellow", "green", "red", "black", "pink", "magenta", "midnightblue")
#modules = c("blue", "yellow", "green", "red", "black", "pink")

probes = row.names(topDatExpr)
inModule = is.finite(match(mergedColors, modules))
modProbes = probes[inModule]

modTOM = tom[inModule, inModule]
dimnames(modTOM) = list(modProbes, modProbes)

nTop =30
IMConn = softConnectivity(trans[,modProbes])
top = (rank(-IMConn) <= nTop)


cyt = exportNetworkToCytoscape(modTOM[top,top], edgeFile = "TopEdges.txt",
	nodeFile = "topNodes.txt", weighted = TRUE,threshold = 0.01);

cyt = exportNetworkToCytoscape(modTOM[top,top], edgeFile = paste("CytoscapeInput-edges-", paste(modules, collapse="-"), ".txt", sep=""),
	nodeFile = paste("CytoscapeInput-nodes-", paste(modules, collapse="-"), ".txt", sep=""),weighted = TRUE,threshold = 0.02,
	nodeNames = modProbes,nodeAttr = mergedColors[inModule]);
