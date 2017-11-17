#!/bin/bash

#SBATCH --ntasks=5
#SBATCH --mem=125G   # memory per CPU core
#SBATCH --time=7-00:00:00

module load python/2/7
cd /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/pyDNase-0.2.3/pyDNase/scripts
./dnase_cut_counter.py /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.K562.biorep2.techrep10.bed /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.K562.biorep2.techrep10.bam /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.K562.biorep2.techrep10.cuts
