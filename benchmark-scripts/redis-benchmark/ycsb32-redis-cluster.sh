#!/bin/bash
# YCSB parallel benchmark on many clients.
# Author:  lhz6@outlook.com
# Written in Nov.22.2018

WORKLOAD_FILE=/home/cc/client-main/ycsb/YCSB/workloads/workloada-redis
USER=cc
YCSB_REDIS_SCRIPT_DIR=/home/cc/benchmark-scripts/redis-benchmark
YCSB_SCRIPT=./redis-ycsb32.sh

for i in {2..8}; do
	scp $WORKLOAD_FILE $USER@client$i:$WORKLOAD_FILE
	ssh client$i "mkdir -p  $YCSB_REDIS_SCRIPT_DIR"
	scp $YCSB_REDIS_SCRIPT_DIR/redis-ycsb32.sh $USER@client$i:$YCSB_REDIS_SCRIPT_DIR/
done

mkdir /home/cc/ycsb-redis-res
for i in {1..8}; do 
	nohup ssh -t cc@client$i "cd $YCSB_REDIS_SCRIPT_DIR ; $YCSB_SCRIPT  server$i  $i "  > /home/cc/ycsb-redis-res/ycsb-redis-client$i &

#####	ssh -t client$i "cd /home/cc/client-main/ycsb/YCSB ; mvn -pl com.yahoo.ycsb:redis-binding -am clean package" 
done

