#!/bin/bash
#$1 is the converted bed file
#$2 is the transcription factor name
#$3 is the bin file you want to use
#$4 is the column to extract from

/fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/bedtools2/bin/intersectBed -wao -a $3 -b $1 > $2.overlap.tmp

