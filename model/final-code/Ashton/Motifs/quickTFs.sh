#!/bin/bash
#$1 is the motif file
#$2 is the transcription factor name
set -e
#1/7
#currently only instituting phase 1--> get the overlap bed files.
#This means the output files for each are empty and meaningless.

./completePartials.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/motifBedHits/CTCF.hits.converted.bed CTCF CTCF.train.labels.tsv

./completePartials.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/motifBedHits/E2F1.hits.converted.bed E2F1 E2F1.train.labels.tsv

./completePartials.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/motifBedHits/EP300.hits.converted.bed EP300 EP300.train.labels.tsv


