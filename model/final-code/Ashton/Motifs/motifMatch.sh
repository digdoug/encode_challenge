#!/bin/bash
#SBATCH --ntasks=6
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00


perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl EP300-ENSG00000100393.motif upstream2000.fa -bed > ./motifBedHits/EP300.bed.hits.txt
perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl CEBPB-ENSG00000172216.motif upstream2000.fa -bed > ./motifBedHits/CEBPB.bed.hits.txt

perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl CREB1-ENSG00000118260.motif upstream2000.fa -bed > ./motifBedHits/CREB1.bed.hits.txt
perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl CTCf-ENSG00000102974.motif upstream2000.fa -bed > ./motifBedHits/CTCf.bed.hits.txt

perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl E2F1-ENSG00000101412.motif upstream2000.fa -bed > ./motifBedHits/E2F1.bed.hits.txt

perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl E2F6-ENSG00000169016.motif upstream2000.fa -bed > ./motifBedHits/E2F6.bed.hits.txt
perl ~/fsl_groups/fslg_brg/bin/HOMER/bin/scanMotifGenomeWide.pl EGR1-ENSG00000120738.motif upstream2000.fa -bed > ./motifBedHits/EGR1.bed.hits.txt



