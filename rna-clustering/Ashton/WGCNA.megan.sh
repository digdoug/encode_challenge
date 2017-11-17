#!/bin/bash
#SBATCh --ntasks=1
#SBATCh --mem=300G
#SBATCH --time=3-00:00:00
module load r
cd /fslhome/meganm22/fsl_groups/fslg_brg/compute/ENCODE_challenge/rna-scripts-too
Rscript WGCNA.R
