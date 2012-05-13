#!/bin/bash
#
#PBS -l nodes=1:r301:ppn=8
#PBS -l walltime=2:00:00
#PBS -N 301_radix.omp
#PBS -m bea
#PBS -e out_301/omp.err
#PBS -o out_301/omp.out

cd $PBS_O_WORKDIR

NUM_EXECS=5
G=(2 4 8)
SIZES=(256 4096 65536 1048576 16777216)
THREADS=(4 8 16)

for g in ${G[@]}; do
	
	for size in ${SIZES[@]}; do

		for threads in ${THREADS[@]}; do

			mkdir -p results_301/omp
			output=results_301/omp/g${g}_s${size}_t${threads}
			rm -rf $output && touch $output

			for try in `seq 1 $NUM_EXECS`; do
				echo "running try $try, g=$g, size=$size, threads=$threads"
				bin/radix.omp $size $g $threads >> $output
			done
		done
	done
done
