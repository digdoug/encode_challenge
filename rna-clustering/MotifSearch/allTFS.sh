#!/bin/bash
#$1 is the motif file
#$2 is the transcription factor name
set -e

../motifToFeature.sh ATF3.motif ATF3 > ATF.tmp
../motifToFeature.sh ARID31.motif ARID31 > ARID31.tmp
../motifToFeature.sh  CEBPB-ENSG00000172216.motif CEBPB > CEBPB.tmp
../motifToFeature.sh CREB1-ENSG00000118260.motif CREB1 > CREB1.tmp
paste ATF.tmp ARID31.tmp CEBPB.tmp CREB1.tmp > motif.features.csv
