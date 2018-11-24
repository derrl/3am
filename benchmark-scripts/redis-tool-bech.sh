#!/bin/bash

COUNT=1000000
THREADS=32

# data size count in bytes
DATA_SIZE=1000000

for i in {1..8}; do
	ssh client$i "mkdir /home/cc/redis-bench-res"
	nohup ssh client$i "redis-benchmark -h server$i -p 7001 -c $THREADS -d $DATA_SIZE -n $COUNT -t set" > /home/cc/redis-bench-res/redis-set-client$i &
done
