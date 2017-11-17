#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem=100G   # memory per CPU core
#SBATCH --time=7-00:00:00

cd /fslhome/ctm34/fsl_groups/fslg_brg/compute/ENCODE_challenge/chip-seq/labels

./remove_ambig.py ARID3A.train.labels.tsv~ ARID3A.nonambig.txt
./remove_ambig.py ATF2.train.labels.tsv ATF2.nonambig.txt
./remove_ambig.py ATF3.train.labels.tsv ATF3.nonambig.txt
./remove_ambig.py ATF7.train.labels.tsv ATF7.nonambig.txt
./remove_ambig.py CEBPB.train.labels.tsv CEBPB.nonambig.txt
./remove_ambig.py CREB1.train.labels.tsv CREB1.nonambig.txt
./remove_ambig.py CTCF.train.labels.tsv CTCF.nonambig.txt
./remove_ambig.py E2F1.train.labels.tsv E2F1.nonambig.txt
./remove_ambig.py E2F6.train.labels.tsv E2F6.nonambig.txt
./remove_ambig.py EGR1.train.labels.tsv EGR1.nonambig.txt
./remove_ambig.py EP300.train.labels.tsv EP300.nonambig.txt
./remove_ambig.py FOXA1.train.labels.tsv FOXA1.nonambig.txt
./remove_ambig.py FOXA2.train.labels.tsv FOXA2.nonambig.txt
./remove_ambig.py GABPA.train.labels.tsv GABPA.nonambig.txt
./remove_ambig.py GATA3.train.labels.tsv GATA3.nonambig.txt
./remove_ambig.py HNF4A.train.labels.tsv HNF4A.nonambig.txt
./remove_ambig.py JUND.train.labels.tsv JUND.nonambig.txt
./remove_ambig.py MAFK.train.labels.tsv MAFK.nonambig.txt
./remove_ambig.py MAX.train.labels.tsv MAX.nonambig.txt
./remove_ambig.py MYC.train.labels.tsv MYC.nonambig.txt
./remove_ambig.py NANOG.train.labels.tsv NANOG.nonambig.txt
./remove_ambig.py REST.train.labels.tsv REST.nonambig.txt
./remove_ambig.py RFX5.train.labels.tsv RFX5.nonambig.txt
./remove_ambig.py SPI1.train.labels.tsv SPI1.nonambig.txt
./remove_ambig.py SRF.train.labels.tsv SRF.nonambig.txt
./remove_ambig.py STAT3.train.labels.tsv STAT3.nonambig.txt
./remove_ambig.py TAF1.train.labels.tsv TAF1.nonambig.txt
./remove_ambig.py TCF12.train.labels.tsv TCF12.nonambig.txt
./remove_ambig.py TCF7L2.train.labels.tsv TCF7L2.nonambig.txt
./remove_ambig.py TEAD4.train.labels.tsv TEAD4.nonambig.txt
./remove_ambig.py YY1.train.labels.tsv YY1.nonambig.txt
./remove_ambig.py ZNF143.train.labels.tsv ZNF143.nonambig.txt



