#!/bin/bash

#SBATCH --ntasks=24
#SBATCH --mem=125G   # memory per CPU core
#SBATCH --time=7-00:00:00

cd /fslhome/meganm22/fsl_groups/fslg_brg/compute/ENCODE_challenge/chip-seq/labels

./stats_chip_seq_labels.py ARID3A.train.labels.tsv~ ARID3A.stats.txt
./stats_chip_seq_labels.py ATF2.train.labels.tsv ATF2.stats.txt
./stats_chip_seq_labels.py ATF3.train.labels.tsv ATF3.stats.txt
./stats_chip_seq_labels.py ATF7.train.labels.tsv ATF7.stats.txt
./stats_chip_seq_labels.py CEBPB.train.labels.tsv CEBPB.stats.txt
./stats_chip_seq_labels.py CREB1.train.labels.tsv CREB1.stats.txt
./stats_chip_seq_labels.py CTCF.train.labels.tsv CTCF.stats.txt
./stats_chip_seq_labels.py E2F1.train.labels.tsv E2F1.stats.txt
./stats_chip_seq_labels.py E2F6.train.labels.tsv E2F6.stats.txt
./stats_chip_seq_labels.py EGR1.train.labels.tsv EGR1.stats.txt
./stats_chip_seq_labels.py EP300.train.labels.tsv EP300.stats.txt
./stats_chip_seq_labels.py FOXA1.train.labels.tsv FOXA1.stats.txt
./stats_chip_seq_labels.py FOXA2.train.labels.tsv FOXA2.stats.txt
./stats_chip_seq_labels.py GABPA.train.labels.tsv GABPA.stats.txt
./stats_chip_seq_labels.py GATA3.train.labels.tsv GATA3.stats.txt
./stats_chip_seq_labels.py HNF4A.train.labels.tsv HNF4A.stats.txt
./stats_chip_seq_labels.py JUND.train.labels.tsv JUND.stats.txt
./stats_chip_seq_labels.py MAFK.train.labels.tsv MAFK.stats.txt
./stats_chip_seq_labels.py MAX.train.labels.tsv MAX.stats.txt
./stats_chip_seq_labels.py MYC.train.labels.tsv MYC.stats.txt
./stats_chip_seq_labels.py NANOG.train.labels.tsv NANOG.stats.txt
./stats_chip_seq_labels.py REST.train.labels.tsv REST.stats.txt
./stats_chip_seq_labels.py RFX5.train.labels.tsv RFX5.stats.txt
./stats_chip_seq_labels.py SPI1.train.labels.tsv SPI1.stats.txt
./stats_chip_seq_labels.py SRF.train.labels.tsv SRF.stats.txt
./stats_chip_seq_labels.py STAT3.train.labels.tsv STAT3.stats.txt
./stats_chip_seq_labels.py TAF1.train.labels.tsv TAF1.stats.txt
./stats_chip_seq_labels.py TCF12.train.labels.tsv TCF12.stats.txt
./stats_chip_seq_labels.py TCF7L2.train.labels.tsv TCF7L2.stats.txt
./stats_chip_seq_labels.py TEAD4.train.labels.tsv TEAD4.stats.txt
./stats_chip_seq_labels.py YY1.train.labels.tsv YY1.stats.txt
./stats_chip_seq_labels.py ZNF143.train.labels.tsv ZNF143.stats.txt



