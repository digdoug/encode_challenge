#! /usr/bin/env python
import sys
import re

fileIn = open(sys.argv[1],"r")
fileOut = open(sys.argv[2],"w")

fileOut.write("NCBI\tCHR\tSTART\tEND\n")

search = r"^>(NM_\d+)_up_\d000_(chr[A-Za-z0-9]{1,2})\w+[fr]\schr\w+:(\d+)-(\d+)$"
replace = r"\1\t\2\t\3\t\4"

for line in fileIn:
	line = line.strip()
	newLine = re.sub(search,replace,line)
	fileOut.write(newLine+'\n')
	

fileIn.close()
fileOut.close()
