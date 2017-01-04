#!/usr/bin/sh
#Benchmarking script for HBW memory
#Lei Yan 01/04/2017

# init ICC and ENVs
source $iccvar intel64
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=32

# benchmarking
enableHbw="numactl -m 4,5,6,7"

${enableHbw} ../distgen -t 16 -1000

