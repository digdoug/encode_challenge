#!/usr/bin/env python

import sys
from pyensembl import EnsemblRelease

f = open("module-test.csv",'r')

data = EnsemblRelease(77)
data.download()
data.index()


for line in f:
    line = line.strip()
    line = line.split(',')
    print line[0]
    print data.gene_by_id(line[0])
