#!/bin/bash
# IOR benchmark script on ares
# Writen by Hanzhang Liu Apr.29.2019

USER=hliu91
HOSTFILE=/home/hliu91/integration/benchmark-nodes
IOR=/home/hliu91/integration/IOR_main/ior_build/bin/ior
TARGET=/mnt/nvme/$USER/pvfs-shared/test
THREADS=160
BLOCK_SIZE=16m
SEGMENT_COUNT=128
WRITE=true
#WRITE=false
#NMON_START=/home/cc/benchmark-scripts/nmon-start.sh
IOR_RES=

if $WRITE ; then
	#$NMON_START IOR-write
	IOR_RES=IOR_write_res_$THREADS
	nohup mpirun -np $THREADS --hostfile $HOSTFILE $IOR -w -t 1m -b $BLOCK_SIZE -s $SEGMENT_COUNT -o $TARGET -F -B -e -k > ~/$IOR_RES &
else
	#$NMON_START IOR-read
	IOR_RES=IOR_read_res_$THREADS
	nohup mpirun -np $THREADS --hostfile $HOSTFILE $IOR -r -t 1m -b $BLOCK_SIZE -s $SEGMENT_COUNT -o $TARGET -F -B -e -k > ~/$IOR_RES &
fi
