#!/usr/bin/Rscript
rawData <- read.table("/fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/rna-seq/allRNASeqResults.tsv", header= T)
row.names(rawData) <- rawData$GENEID
rawData$GENEID <- NULL

datExpr <- log2((rawData + 1))
 ##STart wgcna tutorial
library(WGCNA)
options(stringsAsFactors = F)
disableWGCNAThreads()
gsg = goodSamplesGenes(datExpr, verbose=3)
gsg$allOK
#3DATA is good to go!
print("About to begin clustering....")
distribution <- dist(datExpr)
write.table(datExpr, file="test.tsv", sep='\t')
print ("found the distribution of the datExpr data")
#testTree = hclust(distribution, method = "average")
#print ("Cleared the clustering")
#sizeGrWindow(12,9)
#pdf(file = "/fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/scripts/Ashton/cluster.pdf", width = 12, height = 9)
#print("Succesfuly wrote out")

#powers= c(c(1:10), seq(from =12, to=30, by=2))

#Choose a set of soft-thresholding powers
# Call the network topology analysis function
#sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)


#net = blockwiseModules(datExpr, power = sft$powerEstimate, TOMType = "unsigned", minModuleSize = 30,
#reassignThreshold = 0, mergeCutHeight = 0.25,numericLabels = TRUE, pamRespectsDendro = FALSE, saveTOMs = TRUE,verbose = 3)

# open a graphics window
#sizeGrWindow(12, 9)
# Convert labels to colors for plotting
#mergedColors = labels2colors(net$colors)
# Plot the dendrogram and the module colors underneath
#plotDendroAndColors(net$dendrograms[[1]], mergedColors[net$blockGenes[[1]]],
"Module colors",dendroLabels = FALSE, hang = 0.03, addGuide = TRUE, guideHang = 0.05)

