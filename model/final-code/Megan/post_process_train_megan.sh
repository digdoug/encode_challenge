#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem=124G   # memory per CPU core
#SBATCH --time=7-00:00:00

cd ~/fsl_groups/fslg_brg/compute/ENCODE_challenge/annotations/


for i in A549 GM12878 H1-hESC HCT116 HeLa-S3 HepG2 IMR90 induced_pluripotent_stem_cell K562 liver MCF-7 Panc1 PC-3 SK-N-SH; do cut -f 1,2,3,7,8,9,10,11,12 $i/$i.overlap.train.txt > $i/$i.overlap.train.clean.txt; echo $i; done

for i in A549 GM12878 H1-hESC HCT116 HeLa-S3 HepG2 IMR90 induced_pluripotent_stem_cell K562 liver MCF-7 Panc1 PC-3 SK-N-SH; do sort -buk1,3 $i/$i.overlap.train.clean.txt > $i/$i.overlap.train.clean.final.txt; echo $i; done


