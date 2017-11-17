#!/bin/bash
#SBATCH --ntasks=5
#SBATCH --mem=125G   # memory per CPU core
#SBATCH --time=7-00:00:00
module load python/2/7
cd /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/pyDNase-0.2.3/pyDNase/scripts
./dnase_cut_counter.py -A /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.A549.biorep1.techrep3.bed /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.A549.biorep1.techrep3.bam /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams/DNASE.A549.biorep1.techrep3.test.cuts
