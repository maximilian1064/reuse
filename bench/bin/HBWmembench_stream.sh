#!/usr/bin/sh
#Benchmarking script for HBW memory
#Using STREAM 
#Lei Yan 01/11/2017

# INIT ICC-ENVs


iccfirstPATH="/global/cluster/intel/compilers_and_libraries_2016.0.109/linux/bin/intel64"
if [ "$( echo ${PATH} | cut -d':' -f1 )" != "${iccfirstPATH}" ]; then
    source $iccvar intel64
fi


# GENERAL BENCHMARKING OPTION


# result file
if [ -z "${4}" ]; then
    resultSTREAM="result_STREAM_`date +%m-%d-%Y-%H-%M-%S`"
else
    resultRead=${4}
fi

#def. 16m 
if [ -z "${2}" ]; then
    ArraySize=16
else
    ArraySize=${2}
fi

#def. 1 
if [ -z "${3}" ]; then
    SampleNum=1
else
    SampleNum=${3}
fi


# OPTIONS FOR SINGLE BENCHMARK SET


ThreadNum="1 2 4 8 16 32 64 128 255"

#def. 2000
if [ -z "${1}" ]; then
    IterNum=2000
else
    IterNum=${1}
fi

#size of L2: 1m per tile on KNL, ignore L2 impact for the moment
#distance="2m 4m 8m 16m 32m 64m"


# BENCHMARKING


enableHbw="numactl -m 4,5,6,7"
rm ${resultSTREAM} 2>/dev/null
touch ${resultSTREAM} 
echo -e "---------------------------STREAM RESULT-----------------------------\n" >>${resultSTREAM}

if [ -x proclist_generator ]; then
    gcc --std=c99 proclist_generator.c -o proclist_generator
fi

# overall Bandwidth & Latency
for TNum in ${ThreadNum}
do
    echo -e "--------------------------TNum:${TNum}-------------------------\n" >>${resultSTREAM}
    export KMP_AFFINITY=proclist=[`./proclist_generator ${TNum}`],explicit
    #for dist in ${distance}
    #do
    #apply runtime options
    icc -O2 -openmp -DNTIMES=${IterNum} -DSTREAM_ARRAY_SIZE=$((${TNum}*${ArraySize}*1000000)) STREAM/stream.c -o stream_c
    #echo -e "--------------------------TNum:${TNum},Dist:${dist}--------------------------\n" >>${resultSTREAM}
    for((i=1; i<=${SampleNum}; i=i+1))
    do
        ${enableHbw} ./stream_c >>${resultSTREAM}
    done
    #done
done
