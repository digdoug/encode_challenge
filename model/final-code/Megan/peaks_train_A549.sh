#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem=124G   # memory per CPU core
#SBATCH --time=7-00:00:00

cd ~/fsl_groups/fslg_brg/compute/ENCODE_challenge/annotations/A549

./motifToFeature.sh A549 ../train_regions.blacklistfiltered.bed 



