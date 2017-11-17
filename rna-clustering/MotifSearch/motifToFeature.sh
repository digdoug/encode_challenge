#!/bin/bash
#$1 is the motif file
#$2 is the transcription factor name
#$3 is the bin file you want to use
PROMOTERS="/panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/upstream2000.fa"
MP="~/fsl_groups/fslg_brg"

perl /fslhome/aromdahl/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl $1 $PROMOTERS -bed > $2.promHits.bed
python /fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/MotifSearch/motifBedHits/conversionScript.py $2.promHits.bed > $2.promHits.converted.bed
/fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/bedtools2/bin/intersectBed -wao -a $3 -b $2.promHits.converted.bed > $2.overlap.txt
python /panfs/pan.fsl.byu.edu/scr/grp/fslg_brg/ENCODE_challenge/MotifSearch/annotationsAppend.py $2.overlap.tmp 8
#So now we have a file with the overlap stuff, we need to paste this with the 
paste $3 $2.overlap.tmp > $2.feature.bed
echo "Completed feature creation for $3"



