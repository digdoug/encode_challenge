#!/usr/bin/env Rscript
######################################################################
##  THIS VERSION OF THE SCRIPT OMITS COMMAND LINE OPTIONS
##  AND USES EXPRESSION DATA AND GINI CORRELATION
## 
##  Made by Ashton Omdahl, ICE, June-August 2016


#Simple tool that draws a density graph of points above
#A certian threshold
corDensityGraph <- function(in_matrix, thresh, names)
{
  #Our own method:
  #tempNames <-rownames(in_matrix)
  threshCount <-as.data.frame(names)
  threshCount["Counts"] <- NA
  
  for (r in 1:nrow(in_matrix)){
    count = sum(in_matrix[r,] >= thresh)
    threshCount$Counts[r]<- count
  }
  countV <- threshCount[,2]
  d <- density(as.numeric(countV))
  plot(d, main = paste("Density of correlations Past threshold:",thresh), xlab = "Count exceeding threshold")
  abline(v=5000, col="red")
}

suppressMessages(library(WGCNA))
suppressMessages(library(argparse))
suppressMessages(library(data.table))
suppressMessages(library(DESeq2))
options(stringsAsFactors=FALSE);
enableWGCNAThreads()

STD_CORRELATION_THRESHOLD = 0.90
SOFT_POWER_THRESHOLD = 0.8
EXCEEDS_DISTANCE =0.15



##############Pre-processing of RNA-seq Expression Data########################
expression <- fread("~/Datasets/RNASeq/RNASeq_clean_tissue.tsv", header = FALSE, sep='\t', data.table=F)
#Is there any pre-processing, such as varianceStabilizingTransformation, that needs to take place here?
#exprData <- varianceStabilizingTransformation(expression)  DOESNT work
rownames(expression) <- expression$V1
datExpr <- as.data.frame(t(expression[,2:ncol(expression)]))
rownames(datExpr) <- datExpr$GeneID
datExpr <- datExpr[,2:ncol(datExpr)]

#Doing it for the stabilized data.
datExpr2Stabilize <-matrix(as.numeric(unlist(datExpr)), nrow = nrow(datExpr))
datExprStabilized<- as.data.frame(log2(datExpr2Stabilize+1))
rownames(datExprStabilized) <- rownames(datExpr)
names(datExprStabilized) <-names(datExpr)

#Do a simple hierarchical cluster and remove outliers from that test.
#May want to integrate other clustering techniques here.
exprTree = hclust(dist(datExprStabilized), method = "average")
par(cex = 0.6);
par(mar = c(0,4,2,0))
plot(exprTree, main = "Sample clustering to detect outliers", sub="", xlab="", cex.lab = 1.5,
     cex.axis = 1.5, cex.main = 2)
abline(h=425, col="red")

#programmatically, we want this to be anything outside of what, 2 sds??  need to adjust this.
removingOutliers = cutreeStatic(exprTree, cutHeight = 425, minSize=5)
keepSamples = (removingOutliers == 1)
datExprFINAL <-datExprStabilized[keepSamples,]

#Alternatively- this works, but always picks the furtherst.  not very useful.
#datExprFINAL2 <- datExprStabilized[!outlier(exprTree$height, logical=TRUE)]

save(datExprFINAL, file="Normalized_Expression_data.RData")

################################Identify most correlated genes ##################################################

#Read in correaltion data for reference
G_similarity <- fread("~/Datasets/RNASeq/rnaseq_log2_GCC.tsv", header = TRUE, sep='\t',col.names=T,data.table=F)
##Run some things here so you can extract it easily.  Not sure what is going on....
#...
#....
G_similarityF<-data.frame(G_similarity) #Not called on the July 1 run
row.names(G_similarityF) <- names(G_similarityF)

#Limit the genes shown in the expression data to those we are interested in and relevant to correlation data
gene.shared<-intersect(colnames(datExprFINAL),row.names(G_similarity));
g_datExpr<-datExprFINAL[,gene.shared]
g_similarity.matrix <- as.matrix(G_similarityF[gene.shared,gene.shared])

#Select soft-thresholding power
powers = c(c(1:10), seq(from =12, to=30, by=2))
sft = pickSoftThreshold(g_datExpr, powerVector = powers, RsquaredCut = SOFT_POWER_THRESHOLD)
#sft2 = pickSoftThreshold.fromSimilarity(similarity=g_similarity.matrix, RsquaredCut=SOFT_POWER_THRESHOLD, powerVector=powers)
softPower = as.numeric(sft$powerEstimate)

#Determine how connected the different genes are
topGenes <-softConnectivity(g_datExpr, type="unsigned", power = softPower, blockSize = 10000)
#topGenes <- softConnectivity.fromSimilarity(similarity=g_similarity.matrix, type="signed", blockSize= 3000)


topGenesWithNames <-as.data.frame(topGenes)
rownames(topGenesWithNames) <- names(g_datExpr) 

#Order them from most to least connected
topTen = topGenesWithNames[order(-topGenes), , drop=FALSE]
#Keep only the top 10,000
topTen = topTen[1:10000,,drop=FALSE]

####################Isolate the top 10,0000 from the similarity matrix###################
topGeneIDs<-rownames(topTen)
topCorrGenes <- g_similarity.matrix[topGeneIDs,topGeneIDs]

#
save(topTen, topCorrGenes,G_similarityF , file="CorrelationDataFiltered.RData")
save(g_similarity.matrix, file = "CondensedCorrelationMatrix.RData")
save(G_similarityF , file="CorrelationSuperMatrix.RData")

##Also grab the top 100 for a heatmap (?)
#########HERE
#########Get the soft threshold based on this limited number of expressed genes ############

topCorrGenesNumeric <- matrix(as.numeric(unlist(topCorrGenes),rownames.force=TRUE),nrow=nrow(topCorrGenes))
g_powers = c(c(1:10), seq(from =12, to=30, by=2))
g_sft = pickSoftThreshold.fromSimilarity(topCorrGenesNumeric, powerVector = g_powers, RsquaredCut = SOFT_POWER_THRESHOLD)
g_softPower = as.numeric(g_sft$powerEstimate)
save(topCorrGenesNumeric, g_sft, g_softPower, topGenesList, file="GCCData_modules.RData")

#####Do the clustering################
#Create the adjacency matrix
g_adjacency <- adjacency.fromSimilarity(topCorrGenesNumeric, type = "signed", power = g_softPower)

#Topological overlap matrix
g_TOM = TOMsimilarity(g_adjacency, TOMType="signed");
g_dissTOM = 1-g_TOM

#Cluster the differences in topological overlap to identify groups
g_geneTree = hclust(as.dist(g_dissTOM), method="average")
g_geneTree$labels = row.names(topGenesList)

#Check where we are.
plot(g_geneTree, xlab="", sub="", main = "Gene clustering on TOM-based dissimilarity",
     labels = FALSE, hang = 0.04);

###########Identify the modules#################

#Select the minimum size of modules- tinker with this
minModSize = 30

#Create the modules
dynamicMods = cutreeDynamic(dendro=g_geneTree, distM=g_dissTOM,
                            deepSplit = 4, pamRespectsDendro=FALSE,
                            minClusterSize = minModSize)
#See the different sets:
table(dynamicMods)

#Assign each gene co-expression module a color
dynamicColors = labels2colors(dynamicMods)

####Plot the modules###########
plotDendroAndColors(g_geneTree, dynamicColors, "Dynamic Tree Cut",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Gene Co-expression: GCC-based Modules")

save(g_adjacency, g_TOM, g_dissTOM, g_geneTree, dynamicColors, file="GCC_coexpression_modules.RData")


############Record modules for output#############################
#Calculate intramodular Connectivity
modConnectivityScaled<-intramodularConnectivity(g_adjacency, dynamicColors, scaleByMax= TRUE)
modConnectivity<-intramodularConnectivity(g_adjacency, dynamicColors, scaleByMax= FALSE)
modules.output <- data.frame(Genes = c(row.names(topCorrGenes)), group = c(dynamicColors), 
                             ScaledConnectivity=modConnectivityScaled$kWithin, RawConnectivity=modConnectivity$kWithin)

modules.ordered <- modules.output[rev(order(group, ScaledConnectivity)),]
row.names(modules.ordered) <- modules.ordered[,1]
modules.ordered<-modules.ordered[,-1]

fileName = paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/WGCNA/RNASeqAnalysis/7-1/FinalTFNetworks/GCC_modules.tsv")
write.table(modules.ordered, file= fileName, row.names = TRUE, sep = '\t')


#############################################################################################################
#Identify connectivity of TFs within Modules
#############################################################################################################

#Load the TF file
tf.genes <- read.csv("/home/likewise-open/ICE/aomdahl/Datasets/TranscriptionFactors/TranscriptionFactorFamilies.csv")
tf.genes <- as.data.frame(tf.genes)
#attach(tf.genes)
#Keep only the TFs that are within modules
tfs.in.modules<-intersect(row.names(modules.ordered),tf.genes$Gene)

for (TF.gene.id in tfs.in.modules){
  #Get the gene's group-- test case: NIATv7_g20397
  module<-modules.ordered[TF.gene.id,"group"];
  #select the gene's module- size 841, this is correct
  modules.ordered.selected<-row.names(modules.ordered[modules.ordered$group==module,]);
  #Get its rank from the ordered list
  #rank <- as.numeric(which(modules.ordered.selected == TF.gene.id))
  sc.score <-as.numeric(modules.ordered[TF.gene.id,][2])
  #Is the gene in the upper 50% of connectivity within the module?
  #if (rank <= length(modules.ordered.selected)/2)
  #Alternative option:  use soft connectivity again on the subset to determine the top ones
  
  #Modification: is the scaled connectivity score > .5?
    if(sc.score > 0.5)
  {
    #Call gini lookup
    ## check connectivity;
    correlated.Genes <- topCorrGenes[TF.gene.id, modules.ordered.selected]
    #Changed the size of the groups to 10%
    top.correlated.modular.genes <- (rev(sort(correlated.Genes)))[1:(0.1*length(correlated.Genes))]
    
    #If the top 10% doesn't give us a large enough list, take the top 30.
    if (length(top.correlated.modular.genes) <= 30)
    {
      top.correlated.modular.genes <- (rev(sort(correlated.Genes)))[1:30]
    }
    
    #Not sure why, but here it is.
    
    #Print this to an output file.
    fileName = paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/WGCNA/RNASeqAnalysis/7-1/FinalTFNetworks/",TF.gene.id, "_", module, "_module.txt", sep="")
    #headerPrint= paste(TF.gene.id, " module\n Transcription Factor Family: ", tf.genes[Gene == TF.gene.id, Family])
    #write(headerPrint, file= fileName)
    focus.genes <- data.frame(Gene = c(names(top.correlated.modular.genes)), Correlation = as.numeric(top.correlated.modular.genes), 
                              ScaledConnectivity=c(modules.ordered[names(top.correlated.modular.genes),]$ScaledConnectivity))
    #create the print table
    
    write.table(focus.genes, file= fileName, append = TRUE, row.names = FALSE, sep='\t', quote=FALSE, col.names=F)
    
    
  }
  else
  {
    next
  }
  
}

############################Trying to find the genes we are interested in for RAN ############################
length(topCorrGenes["NIATv7_g23317",])
length(topCorrGenes["NIATv7_g41919",])
length(topCorrGenes["NIATv7_g23226",])
  #So all 3 are in the topCor Genes....


################# Build a nice network picture using VisANT, v stands for visualization
#The module we want (let's say green)
v.module = "green"
v.inModule = (dynamicColors == v.module)
v.modTOM = g_TOM[v.inModule, v.inModule]
v.names <-row.names(topCorrGenes[v.inModule,])
dimnames(v.modTOM) = list(v.names, v.names)
#Keep only the top genes in the module, since its too expensive otherwise.
v.topModuleGenes = modules.ordered[v.names, ]
v.top <- v.topModuleGenes[order(v.topModuleGenes$ScaledConnectivity, decreasing=T),]
v.top10 <- v.top[1:10,]
#Make sure the gene we want is there too
v.topGeneIDs <- row.names(v.top10)
v.topGeneIDs[11]="NIATv7_g36100"
v.topGeneIDs[12]="NIATv7_g44117"
v.topGeneIDs[13]="NIATv7_g23836"
v.topGeneIDs[14]="NIATv7_g12037"
v.topGeneIDs[15]="NIATv7_g15308"
v.topGeneIDs[16]="NIATv7_g14955"
#Well, screw it.  For our diagram, we need to customize the ones we want.

vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInputR1-", v.module, ".txt", sep=""), weighted = TRUE,
                          threshold = 0)
greenModuleMap = exportNetworkToVisANT(v.modTOM, file=paste("VisANTALLGREEN-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0)

vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput8-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.08)
vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput3-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.3)
vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput4-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.4)
vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput5-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.5)
vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput6-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.6)
vis = exportNetworkToVisANT(v.modTOM[v.topGeneIDs,v.topGeneIDs], file=paste("VisANTInput65-", v.module, ".txt", sep=""), weighted = TRUE,
                            threshold = 0.65)

##Okay, lets try selecting the module directly
jazGModule <- read.table("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/GenomeWideAnalysis/TFBasedModules/FinalTFNetworks/NIATv7_g36100_green_module.txt", header=F)
inclusionData <- topGeneIDs %in% jazGModule$V1[1:15]
jazGNames <- topGeneIDs[inclusionData]
jazGTOM <- g_TOM[inclusionData, inclusionData]
dimnames(jazGTOM) = list(jazGNames,jazGNames)
jazGVIS =exportNetworkToVisANT(jazGTOM, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTjazG1-", v.module, ".txt", sep=""), weighted = TRUE,
                                     threshold = 0.10)
jazGVIS =exportNetworkToVisANT(jazGTOM, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTjazG3-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.30)
jazGVIS =exportNetworkToVisANT(jazGTOM, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTjazG5-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.50)
###This doesn't give the kind sof results we really want.  Trying something else-- correlation results
jazGCorr <- topCorrGenes[jazGModule$V1[1:15], jazGModule$V1[1:15]]
jazGVIS =exportNetworkToVisANT(jazGCorr, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazG1-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.10)
jazGVIS =exportNetworkToVisANT(jazGCorr, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazG3-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.30)
jazGVIS =exportNetworkToVisANT(jazGCorr, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazG5-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.50)
jazGVIS =exportNetworkToVisANT(jazGCorr, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazG7-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.70)
jazGVIS =exportNetworkToVisANT(jazGCorr, file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazG9-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.99)


#HMM still not quite rite. Modifications to stuff above so it grabs the top ones in the module and ourselves.  then we will grab the ones most closely correlated to it...
JagCorr <- topCorrGenes[v.top15,v.top15]

jazGVISTEST =exportNetworkToVisANT(G_similarityF[v.topGeneIDs,v.topGeneIDs], file=paste("/home/likewise-open/ICE/aomdahl/CoExpressionNetworks/Graphics/VisANTCorrjazGRetry-", v.module, ".txt", sep=""), weighted = TRUE,
                               threshold = 0.1)

