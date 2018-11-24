#!/bin/bash
# Redis YCSB benchmark single hosts
# Author:  lhz6@outlook.com
# Written in Nov.22.2018

YCSB_HOME=/home/cc/client-main/ycsb/YCSB
#YCSB_HOME=/home/cc/YCSB
YCSB_BIN=./bin/ycsb
YCSB_WORKLOAD=workloads/workloada-redis 
RES_DIR=/home/cc/ycsb-redis-data-origin
YCSB_RESULT=

THREADS=32
INSERTSTART=0
INSERTCOUNT=500000
OPERATIONCOUNT=500000
RECORDCOUNT=$(($INSERTCOUNT*8))

#echo 'Usage: ./redis-ycsb.sh redis.host host_number'
REDIS_HOST=server2
if [ $# -ne 2 ]; then
	echo 'Usage: ./redis-ycsb.sh redis.host host_number'
	exit 1
else
	REDIS_HOST=$1
	INSERTSTART=$(($INSERTCOUNT * ($2 - 1)))
fi


LOAD=true
RUN=true

ls $YCSB_HOME

mkdir -p $RES_DIR
cd $YCSB_HOME
pwd

if $LOAD ; then
	YCSB_RESULT=$RES_DIR/redis_load_res
#	$YCSB_BIN load redis -s -threads  $THREADS -P  $YCSB_WORKLOAD  -p "redis.host=$REDIS_HOST" -p recordcount=$RECORDCOUNT -p operationcount=$OPERATIONCOUNT 
	$YCSB_BIN load redis -s -threads  $THREADS -P  $YCSB_WORKLOAD  -p "redis.host=$REDIS_HOST" -p operationcount=$OPERATIONCOUNT -p insertstart=$INSERTSTART  -p insertcount=$INSERTCOUNT  -p recordcount=$RECORDCOUNT
#	nohup $YCSB_BIN load redis -s -threads  $THREADS -P  $YCSB_WORKLOAD  -p "redis.host=$REDIS_HOST" -p recordcount=$RECORDCOUNT -p operationcount=$OPERATIONCOUNT > $YCSB_RESULT &
#####	./bin/ycsb load redis -s -threads $THREADS -P workloads/workloada-redis  >  ~/redis-load-res
fi

if $RUN ; then
	YCSB_RESULT=$RES_DIR/redis_run_res
#	$YCSB_BIN run  redis -s -threads  $THREADS -P  $YCSB_WORKLOAD -p "redis.host=$REDIS_HOST" -p recordcount=$RECORDCOUNT  -p operationcount=$OPERATIONCOUNT
	$YCSB_BIN run redis -s -threads  $THREADS -P  $YCSB_WORKLOAD  -p "redis.host=$REDIS_HOST" -p operationcount=$OPERATIONCOUNT -p insertstart=$INSERTSTART  -p insertcount=$INSERTCOUNT  -p recordcount=$RECORDCOUNT
#	nohup $YCSB_BIN run  redis -s -threads  $THREADS -P  $YCSB_WORKLOAD -p "redis.host=$REDIS_HOST" -p recordcount=$RECORDCOUNT -p operationcount=$OPERATIONCOUNT > $YCSB_RESULT &
#####	./bin/ycsb run redis -s -threads $THREADS -P workloads/workloada-redis  > ~/redis-run-res
fi
