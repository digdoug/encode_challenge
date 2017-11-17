#!/usr/bin/Rscript
library("WGCNA")
enableWGCNAThreads(5)
load("TOM.10.8.RData")
diss_tom= 1-tom
geneTree = hclust(as.dist(diss_tom), method="average")
minModuleSize = 30
#Save the geneTree
save(geneTree, file="geneTree.10.10.RData")

#Get modules with a deep split of 2
dynamicMods2 = cutreeDynamic(dendro = geneTree,distM = diss_tom, deepSplit=2, pamRespectsDendro=F, minClusterSize = minModuleSize)
save(dynamicMods2, file="modules.ds2.RData")

dynColors.2 = labels2colors(dynamicMods2)
pdf(file="Plots/modules.ds2.pdf")
plotDendroAndColors(geneTree, dynColors.2, "Dynamic Tree Cut", dendroLabels =F, hange = 0.03, addGuide=T, guideHang = 0.05, main="Preliminary Modules, DS=2")
dev.off()

dynamicMods3 = cutreeDynamic(dendro = geneTree,distM = diss_tom, deepSplit=3, pamRespectsDendro=F, minClusterSize = minModuleSize)
save(dynamicMods3, file="modules.ds3.RData")
dynColors.3 = labels2colors(dynamicMods3)
pdf(file="Plots/modules.ds3.pdf")
plotDendroAndColors(geneTree, dynColors.3, "Dynamic Tree Cut", dendroLabels =F, hange = 0.03, addGuide=T, guideHang = 0.05, main="Preliminary Modules, DS=3")
dev.off()

dynamicMods4 = cutreeDynamic(dendro = geneTree,distM = diss_tom, deepSplit=4, pamRespectsDendro=F, minClusterSize = minModuleSize)
save(dynamicMods4, file="modules.ds4.RData")
dynColors.4 = labels2colors(dynamicMods4)
pdf(file="Plots/modules.ds4.pdf")
plotDendroAndColors(geneTree, dynColors.4, "Dynamic Tree Cut", dendroLabels =F, hange = 0.03, addGuide=T, guideHang = 0.05, main="Preliminary Modules, DS=4")
dev.off()


