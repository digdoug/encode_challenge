#!/usr/bin/env python
import sys

if len(sys.argv) != 3:
	print """USAGE:
	./stats_chip_seq_labels.py transcriptionfactor.train.labels.tsv transcriptionfactor.stats.txt
	Input sample:
		chr	start	stop	HeLa-S3
		chr10	600	800	U
		chr10	650	850	U
		...
	Output will include summary statistics for each chromosome and cell line in the input file."""
	sys.exit()

inputFile = open(sys.argv[1], 'r')

header = inputFile.readline().strip()
headerList = header.split('\t')
dictionary = {}

count = 0
for head in headerList:
	if head != "chr" and head != "start" and head != "stop":
		dictionary[head] = [count, {}]
	count = count + 1


line = inputFile.readline().strip()
while line != "":
	binList = line.split('\t')
	for key in dictionary:
		if binList[0] not in dictionary[key][1].keys():
			dictionary[key][1][binList[0]] = [0,0,0]
		if binList[dictionary[key][0]] == "A":
			dictionary[key][1][binList[0]][0] = dictionary[key][1][binList[0]][0] + 1
		elif binList[dictionary[key][0]] == "B":
			dictionary[key][1][binList[0]][1] = dictionary[key][1][binList[0]][1] + 1
		elif binList[dictionary[key][0]] == "U":
			dictionary[key][1][binList[0]][2] = dictionary[key][1][binList[0]][2] + 1
	line = inputFile.readline().strip()

inputFile.close()

outFile = open(sys.argv[2],'w')
outFile.write("CellLine,chromosome\t#bound\t#unbound\t#ambiguous\ttotal#\t%bound\t%unbound\t%ambiguous\n")

for key1 in dictionary:
	for key2 in dictionary[key1][1]:
		outFile.write(key1 + ',' + key2 + '\t')
		bound = dictionary[key1][1][key2][1]
		outFile.write(str(bound) + '\t')
		unbound = dictionary[key1][1][key2][2]
		outFile.write(str(unbound) + '\t')
		ambiguous = dictionary[key1][1][key2][0]
		outFile.write(str(ambiguous) + '\t')
		total = bound + unbound + ambiguous
		outFile.write(str(total) + '\t')
		bPerc = 100*(bound / float(total))
		outFile.write(str.format("{0:.2f}", bPerc) + '\t')
		uPerc = 100*(unbound / float(total))
		outFile.write(str.format("{0:.2f}", uPerc) + '\t')
		aPerc = 100*(ambiguous / float(total))
		outFile.write(str.format("{0:.2f}", aPerc) + '\n')

outFile.close()



print sys.argv[1]


