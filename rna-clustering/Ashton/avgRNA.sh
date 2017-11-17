#!/bin/bash
WRITE=../../rna-seq/Averaged
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.A549.biorep1.tsv -i2 ../../rna-seq/gene_expression.A549.biorep2.tsv > $WRITE/A549.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.GM12878.biorep1.tsv -i2 ../../rna-seq/gene_expression.GM12878.biorep2.tsv > $WRITE/GM12878.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.H1-hESC.biorep1.tsv -i2 ../../rna-seq/gene_expression.H1-hESC.biorep2.tsv > $WRITE/H1-hESC.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.HCT116.biorep1.tsv -i2 ../../rna-seq/gene_expression.HCT116.biorep2.tsv > $WRITE/HCT116.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.HeLa-S3.biorep1.tsv -i2 ../../rna-seq/gene_expression.HeLa-S3.biorep2.tsv > $WRITE/HeLa-S3.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.HepG2.biorep1.tsv -i2 ../../rna-seq/gene_expression.HepG2.biorep2.tsv > $WRITE/HepG2.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.IMR90.biorep1.tsv -i2 ../../rna-seq/gene_expression.IMR90.biorep2.tsv > $WRITE/IMR90.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.induced_pluripotent_stem_cell.biorep1.tsv -i2 ../../rna-seq/gene_expression.induced_pluripotent_stem_cell.biorep2.tsv > $WRITE/induced_pluripotent_stem_cell.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.K562.biorep1.tsv -i2 ../../rna-seq/gene_expression.K562.biorep2.tsv > $WRITE/K562.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.liver.biorep1.tsv -i2 ../../rna-seq/gene_expression.liver.biorep2.tsv > $WRITE/liver.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.MCF-7.biorep1.tsv -i2 ../../rna-seq/gene_expression.MCF-7.biorep2.tsv > $WRITE/MCF-7.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.PC-3.biorep1.tsv -i2 ../../rna-seq/gene_expression.PC-3.biorep2.tsv > $WRITE/PC-3.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.SK-N-SH.biorep1.tsv -i2 ../../rna-seq/gene_expression.SK-N-SH.biorep2.tsv > $WRITE/SK-N-SH.tsv
python rna_seq_merge.py -m -i1 ../../rna-seq/gene_expression.Panc1.biorep1.tsv -i2 ../../rna-seq/gene_expression.Panc1.biorep2.tsv > $WRITE/Panc1.tsv
