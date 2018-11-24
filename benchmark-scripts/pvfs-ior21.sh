#!/bin/bash
# IOR benchmark script
# Author:  lhz6@outlook.com
# Written in Nov.21.2018

HOSTFILE=/home/cc/benchmark-scripts/benchmark-nodes
IOR=/home/cc/client-main/IOR_main/ior_build/bin/ior 
TARGET=/mnt/pvfs-shared/test
THREADS=168
BLOCK_SIZE=16m
SEGMENT_COUNT=120
WRITE=true
#WRITE=false
NMON_START=/home/cc/benchmark-scripts/nmon-start.sh
IOR_RES=

if $WRITE ; then
#	$NMON_START IOR-write
	IOR_RES=IOR_write_res
	nohup mpirun -np $THREADS --hostfile $HOSTFILE $IOR -w -t 1m -b $BLOCK_SIZE -s $SEGMENT_COUNT -o $TARGET -F -B -e -k > ~/$IOR_RES &
else
#	$NMON_START IOR-read
	IOR_RES=IOR_read_res
	nohup mpirun -np $THREADS --hostfile $HOSTFILE $IOR -r -t 1m -b $BLOCK_SIZE -s $SEGMENT_COUNT -o $TARGET -F -B -e -k > ~/$IOR_RES &
fi
