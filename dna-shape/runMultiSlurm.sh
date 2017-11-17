#!/bin/bash
X=0
TOTAL=8843011
WINDOW=100000
while [ $X -lt $TOTAL ]
do
	PBS=$1_$X.txt
	#TEMP=output/$1_$X_temp.txt
	#cp runMultiClassTemp.sh $PBS
	tail -n $((TOTAL-X)) $1 | head -n $WINDOW >> $PBS
							        
	sbatch -C avx runMultiClassTemp.sh $PBS
	X=$((X+WINDOW))					
done
