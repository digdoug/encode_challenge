#!/bin/bash
#$1 is the motif file
#$2 is the transcription factor name
set -e

./motifToFeature.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/FOXA1-complete.motif FOXA1 FOXA1.train.labels.tsv > FOXA1.motifs_in_promoter.tsv
./motifToFeature.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/FOXA2-complete.motif FOXA2 FOXA2.train.labels.tsv > FOXA2.motifs_in_promoter.tsv
./motifToFeature.sh  /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/GABPA-complete.motif GABPA GABPA.train.labels.tsv > GABPA.motifs_in_promoter.tsv
./motifToFeature.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/GATA3-complete.motif GATA3.train.labels.tsv > GATA3.motifs_in_promoter.tsv

./motifToFeature.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/HNF4A-complete.motif HNF4A.train.labels.tsv > HNF4A.motifs_in_promoter.tsv

./motifToFeature.sh /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/MotifFiles/JUND-complete.motif JUND.train.labels.tsv > JUND.motifs_in_promoter.tsv



