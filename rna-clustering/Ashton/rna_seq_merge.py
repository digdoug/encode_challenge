#!/usr/bin/env python
###########################################
#Tool to merge RNA-seq datasets.
##########################################
import re, sys
import argparse
#import errorReporting as ER
import os
from decimal import * #This allows us to get the accuracy we need

#This function generates a map based on the RNA reads of gene ID to tpk
def rnaMap(filePath, readIndex, geneIDSet = None):
    retMap = dict()
    fileStream = open(filePath, 'r')
    for line in fileStream:
        if "ENSEMBLE" in line:
           continue
          
        elif "TPM" in line:
            continue
        else:
            tableData = line.strip().split('\t')
            try:
                retMap[tableData[0]] = tableData[readIndex]
                if geneIDSet:
                    geneIDSet.add(tableData[0])
            except IndexError:
                print "Invalid results for line", line.strip()
                continue
    fileStream.close()
    return retMap


#This priints out everything there...
def printMap(rnaMap, tissueName):
    print "GeneID\t" + tissueName
    for geneID in rnaMap:
        print geneID + '\t' + str(rnaMap[geneID])

#Grabs the tissue name.
def getTissueName(fileName):
	tissueName = re.search("gene_expression.(\w+).", fileName)
	if not tissueName:
		print "No tissue name"
		return ""
	else:
		try:
			return tissueName.group(1)
		except:
			return ""
 

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Merge and modify RNA-seq input files.')
    parser.add_argument("-m", "--merge",action="store_true", help="Merge two runs of RNA seq results together, by average")
    parser.add_argument("-i1", "--input1", help="First of RNA-seq runs")
    parser.add_argument("-i2", "--input2",  help="Second of RNA-seqruns")
    parser.add_argument('-s',"--superFile", action="store_true", help = "Merge to super file")
    parser.add_argument('-d', "--stepDir", help = "Directory to step through for merging")
    args = parser.parse_args()

    if (args.merge):
        printingMap = dict()
        map1 = rnaMap(args.input1, 5)
        map2 = rnaMap(args.input2, 5)
        tissueName = getTissueName(args.input1)
        for geneID in map1:
            if geneID not in map2:
                print "Missing geneID in both maps,", geneID
                continue
            else:
                read1 = float(map1[geneID])
                read2 = float(map2[geneID])
                printingMap[geneID] = ((read1 + read2)/ 2.0)
        
        printMap(printingMap, tissueName)
            

    if (args.superFile):
    #Merge everything by gen
        if not args.stepDir:
            print "Please specify the directory of files to merge with -d"
            sys.exit()
        rnaMapList = list()
        tissueNames= list()
        masterGenesList = set([""])
        for fn in os.listdir("./" + args.stepDir):
            #raw_input(fn)
        
            if os.path.isfile(os.path.join(args.stepDir, fn)):
                
                rnaMapList.append(rnaMap(os.path.join(args.stepDir, fn), 1, masterGenesList))
                tissueNames.append(fn[:-4])
        print ("GENEID" +"\t"+ "\t".join(tissueNames))
        for geneID in masterGenesList:
            if geneID == "" or "Gene" in geneID:
                continue
            printTable = list()
            for rnaMap in rnaMapList:
                if geneID in rnaMap:
                    printTable.append(rnaMap[geneID])
                else:
                    printTable.append(" ")
            print geneID + '\t'+ '\t'.join(printTable)
            printTable[:]=[]
