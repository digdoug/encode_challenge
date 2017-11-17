#!/bin/bash
#SBATCH --ntasks=6
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00


module load r
cd /fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/scripts/Ashton 
#Rscript WGCNA.modules.R 
Rscript WGCNA.refineModules.R 
