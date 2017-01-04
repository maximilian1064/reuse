#!/usr/bin/sh
#export OMP_PROC_BIND=spread


enableHbw="numactl -m 4,5,6,7"

#${enableHbw} ../distgen -t 16 -2000 2> result
#${enableHbw} ../distgen -t 32 -2000 2>> result
#${enableHbw} ../distgen -t 64 -2000 2>> result
#${enableHbw} ../distgen -t 128 -2000 2>> result

#${enableHbw} ../distgen -w -t 16 -2000 2>> result
#${enableHbw} ../distgen -w -d -t 16 -2000 2>> result
#${enableHbw} ../distgen -d -t 16 -2000 2>> result

#export KMP_AFFINITY=proclist=[0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60],explicit


#${enableHbw} ../distgen -t 16 -2000 2>result
#${enableHbw} ../distgen -t 16 -2000 8m 2>>result
#${enableHbw} ../distgen -t 16 -2000 4m 2>>result
#${enableHbw} ../distgen -t 16 -2000 2m 2>>result
#${enableHbw} ../distgen -t 16 -2000 1m 2>>result
#${enableHbw} ../distgen -t 16 -2000 512k 2>>result
#${enableHbw} ../distgen -t 16 -2000 256k 2>>result

thread_num=64

#export KMP_AFFINITY=compact
proc_position="`numactl -H | grep cpus | 
awk '(NF>3) {for (i = 4; i <= NF; i++) printf "%d,", $i}' | sed 's/.$//'|
cut -d',' -f1-64`"

export KMP_AFFINITY=proclist=[${proc_position}],explicit
${enableHbw} ../distgen -t 64 -2000 2>result
