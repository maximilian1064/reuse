#!/usr/bin/sh
#Benchmarking script for HBW memory
#Lei Yan 01/04/2017

# init ICC and ENVs
source $iccvar intel64
export OMP_PROC_BIND=spread
#export OMP_PLACES=threads
#export OMP_NUM_THREADS=16

#export KMP_AFFINITY=proclist=[0,20,34,66],explicit
#export KMP_AFFINITY=compact

# benchmarking
enableHbw="numactl -m 4,5,6,7"

#${enableHbw} ../distgen -t 16 -2000 2> result
#${enableHbw} ../distgen -t 32 -2000 2>> result
#${enableHbw} ../distgen -t 64 -2000 2>> result
#${enableHbw} ../distgen -t 128 -2000 2>> result

unset OMP_PROC_BIND
export KMP_AFFINITY=proclist=[0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60],explicit
${enableHbw} ../distgen -t 16 -2000 2> result
export KMP_AFFINITY=proclist=[0,64,8,72,16,80,24,88,32,96,40,104,48,112,56,120],explicit
${enableHbw} ../distgen -t 16 -2000 2>> result
export KMP_AFFINITY=proclist=[0,64,128,192,16,80,144,208,32,96,160,224,48,112,176,240],explicit
${enableHbw} ../distgen -t 16 -2000 2>> result
export KMP_AFFINITY=proclist=[0,64,128,192,1,65,129,193,32,96,160,224,33,97,161,225],explicit
${enableHbw} ../distgen -t 16 -2000 2>> result
export KMP_AFFINITY=proclist=[0,64,1,65,16,80,17,81,32,96,33,97,48,112,49,113],explicit
${enableHbw} ../distgen -t 16 -2000 2>> result
