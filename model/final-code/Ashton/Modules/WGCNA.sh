#!/bin/bash
#SBATCh --ntasks=12
#SBATCh --mem=300G
#SBATCH --time=1-00:00:00
module load r
export ALLOW_WGCNA_THREADS=10
cd /fslhome/aromdahl/fsl_groups/fslg_brg/compute/ENCODE_challenge/scripts/Ashton 
#Rscript WGCNA.adjacency.R
Rscript WGCNA.cytoscape.R
