#! /usr/bin/env python
import sys
if len(sys.argv) != 3:
	print """ERROR: CORRECT FORMAT\n
	./remove_ambig.py transcriptionfactor.train.labels.tsv transcriptionfactor.noambig.txt
	"""
	sys.exit()

inputF = open(sys.argv[1],'r')
outputF = open(sys.argv[2],'w')

header = inputF.readline()
outputF.write(header)
line = inputF.readline()
while line != "":
	line = line.strip().split()
	count = 3 #three because the first three columns are chr, start, and stop
	bound = False
	ambig = False
	while count < len(line):
		if line[count] == 'B':
			bound = True
			count = len(line)
		#	outputF.write("\t".join(line) + "\n")
		elif line[count] == 'A':
			ambig = True
		count += 1
	if bound == True or ambig == False: 
		outputF.write("\t".join(line) + "\n")
	line = inputF.readline()
inputF.close()
outputF.close()
