#!/bin/bash

for f in *.train.labels.tsv
do
	echo $f > temp.del
	var=$(awk -F'.' '{print $1}' temp.del)
	paste $f 1kb.column 2kb.column 5kb.column > $var.bins_promoters.tsv 
	rm temp.del
done	
