#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00


module load r
cd /fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/scripts/Ashton 
Rscript WGCNA.tom.R 
