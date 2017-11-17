#!/usr/bin/Rscript
library("WGCNA")
enableWGCNAThreads(5)
#We will be going with the DS 3:

load("topExpressedData.RData")
load("modules.ds3.RData")
dynamicolors = labels2colors(dynamicMods3)


MEList = moduleEigengenes(t(topDatExpr), colors = dynamicolors)
MEs = MEList$eigengenes
MEDiss = 1-cor(MEs)
METree = hclust(as.dist(MEDiss), method = "average")
#Here we now need to graph and see where the cutoff should be....
pdf(file="Plots/metree.pdf")
plot(METree, main = "Clustring of module eigengenes", xlab = "", sub="")

dev.off()
