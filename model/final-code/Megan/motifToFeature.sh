#!/bin/bash
#$1 is the cell line name
#$2 is the ladder/train/test regions file

/fslhome/meganm22/fsl_groups/fslg_brg/compute/ENCODE_challenge/bedtools2/bin/intersectBed -wao -a $2 -b DNASE.$1.conservative.narrowPeak.txt > $1.overlap.train.txt



