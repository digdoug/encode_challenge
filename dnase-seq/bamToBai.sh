#!/bin/bash

#SBATCH --ntasks=2
#SBATCH --mem=50G   # memory per CPU core
#SBATCH --time=24:00:00

cd /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/dnase-seq/bams

module load samtools
samtools index -b DNASE.A549.biorep1.techrep1\(2\).bam
samtools index -b DNASE.A549.biorep1.techrep2\(1\).bam
samtools index -b DNASE.A549.biorep1.techrep3.bam
samtools index -b DNASE.A549.biorep2.techrep1.bam
samtools index -b DNASE.GM12878.biorep1.techrep1.bam
samtools index -b DNASE.GM12878.biorep2.techrep1.bam
samtools index -b DNASE.H1-hESC.biorep1.techrep1.bam
samtools index -b DNASE.H1-hESC.biorep1.techrep2.bam
samtools index -b DNASE.HCT116.biorep1.techrep1.bam
samtools index -b DNASE.HCT116.biorep2.techrep1.bam
samtools index -b DNASE.HeLa-S3.biorep1.techrep2.bam
samtools index -b DNASE.HeLa-S3.biorep1.techrep3.bam
samtools index -b DNASE.HepG2.biorep2.techrep1.bam
samtools index -b DNASE.HepG2.biorep2.techrep3.bam
samtools index -b DNASE.HepG2.biorep2.techrep4.bam
samtools index -b DNASE.IMR90.biorep1.techrep1.bam
samtools index -b DNASE.IMR90.biorep1.techrep2.bam
samtools index -b samtools index -b DNASE.induced_pluripotent_stem_cell.biorep2.techrep1.bam
samtools index -b DNASE.induced_pluripotent_stem_cell.biorep2.techrep2.bam
samtools index -b DNASE.induced_pluripotent_stem_cell.biorep2.techrep3.bam
samtools index -b DNASE.K562.biorep2.techrep10.bam
samtools index -b DNASE.K562.biorep2.techrep12.bam
samtools index -b DNASE.K562.biorep2.techrep13.bam
samtools index -b DNASE.K562.biorep2.techrep14.bam
samtools index -b DNASE.K562.biorep2.techrep15.bam
samtools index -b DNASE.K562.biorep2.techrep16.bam
samtools index -b DNASE.K562.biorep2.techrep17.bam
samtools index -b DNASE.K562.biorep2.techrep18.bam
samtools index -b DNASE.K562.biorep2.techrep19.bam
samtools index -b DNASE.K562.biorep2.techrep1.bam
samtools index -b DNASE.K562.biorep2.techrep20.bam
samtools index -b DNASE.K562.biorep2.techrep2.bam
samtools index -b DNASE.K562.biorep2.techrep3.bam
samtools index -b DNASE.K562.biorep2.techrep4.bam
samtools index -b DNASE.K562.biorep2.techrep5.bam
samtools index -b DNASE.K562.biorep2.techrep6.bam
samtools index -b DNASE.K562.biorep2.techrep7.bam
samtools index -b DNASE.K562.biorep2.techrep8.bam
samtools index -b DNASE.K562.biorep2.techrep9.bam
samtools index -b DNASE.liver.biorep1.techrep1.bam
samtools index -b DNASE.liver.biorep1.techrep2.bam
samtools index -b DNASE.liver.biorep1.techrep3.bam
samtools index -b DNASE.MCF-7.biorep1.techrep1.bam
samtools index -b DNASE.MCF-7.biorep1.techrep4.bam
samtools index -b DNASE.MCF-7.biorep1.techrep5.bam
samtools index -b DNASE.Panc1.biorep1.techrep1.bam
samtools index -b DNASE.Panc1.biorep2.techrep1.bam
samtools index -b DNASE.PC-3.biorep1.techrep1.bam
samtools index -b DNASE.PC-3.biorep1.techrep2.bam
