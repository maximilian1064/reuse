#!/usr/bin/sh
#Benchmarking script for HBW memory
#Lei Yan 01/04/2017

#CONTENTS:
#HBW enabled; DDR disabled
#random access disabled; dependency chain access disabled; print stats per iterations disabled;
#Overall bandwidth testing enabled; Single tile/core bandwidth testing disabled; Subnuma node bandwidth testing disabled


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

if [ -x proclist_generator ]; then
    gcc --std=c99 proclist_generator.c -o proclist_generator
fi

# overall Bandwidth & Latency
for TNum in ${ThreadNum}
do
    echo -e "--------------------------TNum:${TNum}-------------------------\n" >>${resultRead}
    echo -e "--------------------------TNum:${TNum}-------------------------\n" >>${resultWrite}
    export KMP_AFFINITY=proclist=[`./proclist_generator ${TNum}`],explicit
    for dist in ${distance}
    do
        echo -e "--------------------------TNum:${TNum},Dist:${dist}--------------------------\n" >>${resultRead}
        echo -e "--------------------------TNum:${TNum},Dist:${dist}--------------------------\n" >>${resultWrite}
        for((i=1; i<=${SampleNum}; i=i+1))
        do
            ${enableHbw} ../distgen -t ${TNum} -${IterNum} ${dist} 2>>${resultRead}
            ${enableHbw} ../distgen ${enWrite} -t ${TNum} -${IterNum} ${dist} 2>>${resultWrite}
        done
    done
done
