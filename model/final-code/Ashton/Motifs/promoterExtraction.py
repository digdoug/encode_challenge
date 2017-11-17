#!/bin/bash/python

import sys
import re
import argparse

def main(word):
	tree=st.SuffixTree(word)
	print tree.build_suffix_array()
	
#This function is called when the program is run.  Use the "-h" help function for help
if __name__== "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("promoter", help = "Promoter file to Extract")
	args  = parser.parse_args()
	#outFile = open(args.bedFile + ".converted", 'w')
	with open(args.promoter) as file:
		for line in file:
			if ">" in line:
				try:
					#print "Current line", line.strip()
					rs = re.search("\w*_\w\s*(chr\w+):(\d*)-(\d*)\s*(\d*)\s*(\d*)\s*([\w-]*\s*[^\n]*)", line.strip())
					#Group 1 is actualy the start site.  Sooo use that
					chrStart = (rs.group(2))
					chrEnd = rs.group(3)
					ws = str(rs.group(1)) + '\t' + chrStart + '\t' + chrEnd
					print ws
				except AttributeError:
					print "Unable to catch correctly on the following line"
					print line.strip()
					choice = raw_input("keep (1) or dispose(0)?")
					#if choice:
					#	outFile.write(line.strip())
				
				
	#outFile.close()
				
				
		
