#!/bin/bash
#SBATCH --ntasks=2
#SBATCH --mem=125G
#SBATCH --time=7-00:00:00

module load python/2/7
module load r
export R_LIBS="libs/R"
Rscript get_dna_shape.R $1
rm tmp.fa*
./get_stats.py "$1.shapes.txt"
