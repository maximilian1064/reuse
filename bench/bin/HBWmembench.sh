#!/usr/bin/sh
#Benchmarking script for HBW memory
#Lei Yan 01/04/2017



# INIT ICC-ENVs


iccfirstPATH="/global/cluster/intel/compilers_and_libraries_2016.0.109/linux/bin/intel64"
if [ "$( echo ${PATH} | cut -d':' -f1 )" != "${iccfirstPATH}" ]; then
    source $iccvar intel64
fi



# GENERAL BENCHMARKING OPTIONS


#sample num def. 5
if [ -z "${2}" ]; then
    SampleNum=5
else
    SampleNum=${2}
fi
#result file: scenario with reading only
if [ -z "${3}" ]; then
    resultRead="result_read_`date +%m-%d-%Y-%H-%M-%S`"
else
    resultRead=${3}
fi
#result file: scenario with writing after reading
if [ -z "${4}" ]; then
    resultWrite="result_write_`date +%m-%d-%Y-%H-%M-%S`"
else
    resultWrite=${4}
fi



# OPTIONS FOR SINGLE BENCHMARK SET


ClkFreq="-c 1.3G"
ThreadNum="1 2 4 8 16 32 64 128 255"

#def. 2000
if [ -z "${1}" ]; then
    IterNum=2000
else
    IterNum=${1}
fi

#size of L2: 1m per tile on KNL, ignore L2 impact for the moment
distance="2m 4m 8m 16m 32m 64m"

#Option set: Dependcy chain? writing after reading? random access?
#Only test with write/non-write for the moment
OptSet="-w -wd -wr -wdr -d -r -dr"
enWrite="-w"



# BENCHMARKING


enableHbw="numactl -m 4,5,6,7"
rm ${resultRead} ${resultWrite} 2>/dev/null
touch ${resultRead} ${resultWrite}

# overall Bandwidth & Latency
for TNum in ${ThreadNum}
do
    echo -e "--------------------------TNum:${TNum}-------------------------\n"
    for dist in ${distance}
    do
        echo -e "--------------------------TNum:${TNum},Dist:${dist}--------------------------\n"
        for((i=1; i<=${SampleNum}; i=i+1))
        do
            ${enableHbw} ../distgen -t ${TNum} -${IterNum} ${dist} 2>>${resultRead}
            ${enableHbw} ../distgen ${enWrite} -t ${TNum} -${IterNum} ${dist} 2>>${resultWrite}
        done
    done
done





for TNum in ${ThreadNum}
do
    echo ${TNum}
done

#export OMP_PROC_BIND=spread
##export OMP_PLACES=threads
##export OMP_NUM_THREADS=16

##export KMP_AFFINITY=proclist=[0,20,34,66],explicit
##export KMP_AFFINITY=compact

## benchmarking
#enableHbw="numactl -m 4,5,6,7"

##${enableHbw} ../distgen -t 16 -2000 2> result
##${enableHbw} ../distgen -t 32 -2000 2>> result
##${enableHbw} ../distgen -t 64 -2000 2>> result
##${enableHbw} ../distgen -t 128 -2000 2>> result

#unset OMP_PROC_BIND
#export KMP_AFFINITY=proclist=[0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60],explicit
#${enableHbw} ../distgen -t 16 -2000 2> result
#export KMP_AFFINITY=proclist=[0,64,8,72,16,80,24,88,32,96,40,104,48,112,56,120],explicit
#${enableHbw} ../distgen -t 16 -2000 2>> result
#export KMP_AFFINITY=proclist=[0,64,128,192,16,80,144,208,32,96,160,224,48,112,176,240],explicit
#${enableHbw} ../distgen -t 16 -2000 2>> result
#export KMP_AFFINITY=proclist=[0,64,128,192,1,65,129,193,32,96,160,224,33,97,161,225],explicit
#${enableHbw} ../distgen -t 16 -2000 2>> result
#export KMP_AFFINITY=proclist=[0,64,1,65,16,80,17,81,32,96,33,97,48,112,49,113],explicit
#${enableHbw} ../distgen -t 16 -2000 2>> result
