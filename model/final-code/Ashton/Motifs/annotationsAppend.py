#!/bin/bash/python

import sys
import re
import argparse
import collections

def main(word):
	tree=st.SuffixTree(word)
	print tree.build_suffix_array()
	
def peek(fstream):
	position = fstream.tell()
	line = fstream.readline()
	fstream.seek(position)
	return fstream, line.strip()
	
	
#This function is called when the program is run.  Use the "-h" help function for help
if __name__== "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("bedFile", help = "Bed file to search")
	parser.add_argument("index", type=int, help = "Which column has the relevant nucleotide data to sum.")
	parser.add_argument("-t", "--header", help = "Specify if you would like to include a header in the outprint")
	args  = parser.parse_args()
	boundsMap = collections.OrderedDict()
	chrm = ""
	start = ""
	end =""
	#print args.header
	matchingLines = False
	fstream = open(args.bedFile, 'r')
	line = fstream.readline().strip()
	if args.header:
		print args.header
	while line:
		try:
			if not matchingLines:
				current_line = line.strip().split('\t')
				chrm = current_line[0]
				start = current_line[1]
				end =  current_line[2]
				nCount = int(current_line[args.index])
			else:
				current_line = line.strip().split('\t')
				nCount += int(current_line[args.index])

				
			fstream, nextLine = peek(fstream)
			#print
			#print "Next line", nextLine
			#print "Current line", line
			nll = nextLine.split('\t')
				
			if chrm == nll[0] and nll[1] == start:
				matchingLines = True
				
			else:
				matchingLines = False
				#print chrm + '\t' + start + '\t' + end + '\t' + str(nCount)
				print str(nCount)
			line = fstream.readline().strip()
		except KeyError:
			print "This shouldn't happen"
			print line.strip()
			sys.exit()
			
	
		
	fstream.close()

	#outFile.close()
				
