#!/bin/bash
# Create redis cluster  on Ares
# Author:  lhz6@outlook.com
# Written in Apr.29.2019

REDIS_CLIENT=/home/hliu91/integration/redis-3.2.13/src/redis-cli
CLUSTER_NODE_LIST=/home/hliu91/integration/redis-cluster-nodes

kkkk=0
for i in `cat $CLUSTER_NODE_LIST`
do
	SERVER[$kkkk]="`getent hosts $i|awk '{ print $1 }'`"
#	echo ${SERVER[$kkkk]}
	let kkkk++
done

for i in {0..14}; do
	echo "${SERVER[$i]} flush"
	$REDIS_CLIENT -h ${SERVER[$i]} -p 7001 flushall
	$REDIS_CLIENT -h ${SERVER[$i]} -p 7002 flushall
done
