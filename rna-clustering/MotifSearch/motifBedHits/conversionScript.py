#!/bin/bash/python

import sys
import re
import argparse
from sets import Set

def main(word):
	tree=st.SuffixTree(word)
	print tree.build_suffix_array()
	
#This function is called when the program is run.  Use the "-h" help function for help
if __name__== "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("bedFile", help = "Bed file to be modified")
	args  = parser.parse_args()
	#outFile = open(args.bedFile + ".converted", 'w')
	checkSet = Set()
	with open(args.bedFile) as file:
		for line in file:
			try:
				#print "Current line", line.strip()
				rs = re.search("\w*_\w\s*(chr\w+):(\d*)-(\d*)\s*(\d*)\s*(\d*)\s*([\w-]*\s*[^\n]*)", line.strip())
				#Group 1 is actualy the start site.  Sooo use that
				chrStart = int(rs.group(2))
				#print chrStart
				motifStart = int(rs.group(4))
				motifEnd = int(rs.group(5))
				#print motifStart, motifEnd
				ws = str(rs.group(1)) + '\t' + str(chrStart + motifStart) + '\t' + str(chrStart + motifEnd) + '\t' + str(rs.group(4))+'\t' + str(rs.group(5))
				#raw_input(ws)
				if ws not in checkSet:
					print ws
					checkSet.add(ws)
			except AttributeError:
				print "Unable to catch correctly on the following line"
				print line.strip()
				choice = raw_input("keep (1) or dispose(0)?")
				#if choice:
				#	outFile.write(line.strip())
				
				
	#outFile.close()
				
				
		
