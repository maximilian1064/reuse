#!/usr/bin/sh
#export OMP_PROC_BIND=spread

iccfirstPATH="/global/cluster/intel/compilers_and_libraries_2016.0.109/linux/bin/intel64"
if [ "$( echo ${PATH} | cut -d':' -f1 )" != "${iccfirstPATH}" ]; then
    source $iccvar intel64
fi

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

#export KMP_AFFINITY=compact

export KMP_AFFINITY=proclist=[`./proclist_generator ${1}`],explicit

#export KMP_PLACE_THREADS=4T
#export KMP_AFFINITY=compact
${enableHbw} ../distgen -t ${1} -2000 
#unset KMP_PLACE_THREADS
#unset KMP_AFFINITY
#export OMP_PROC_BIND=spread 
#${enableHbw} ../distgen -t 255 -2000 
