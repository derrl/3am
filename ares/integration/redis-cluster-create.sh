#!/bin/bash
# Create redis cluster  on Ares
# Author:  lhz6@outlook.com
# Written in Apr.29.2019

REDIS_CLIENT=/home/hliu91/integration/redis-3.2.13/src/redis-trib.rb

REDIS_DEPLOY_SCRIPT=/home/hliu91/integration/redis-deploy.sh

kkkk=0
for i in `cat redis-cluster-nodes`
do
	SERVER[$kkkk]="`getent hosts $i|awk '{ print $1 }'`"
	echo ${SERVER[$kkkk]}
	let kkkk++
done

for i in {0..7}; do
	echo ${SERVER[$i]} deploy
	ssh -oStrictHostKeyChecking=no -t  ${SERVER[$i]} "bash -s" < $REDIS_DEPLOY_SCRIPT
done

#$REDIS_CLIENT --cluster create \
$REDIS_CLIENT create --replicas 1 \
	${SERVER[0]}:7001  ${SERVER[0]}:7002 \
	${SERVER[1]}:7001  ${SERVER[1]}:7002 \
	${SERVER[2]}:7001  ${SERVER[2]}:7002 \
	${SERVER[3]}:7001  ${SERVER[3]}:7002 \
	${SERVER[4]}:7001  ${SERVER[4]}:7002 \
	${SERVER[5]}:7001  ${SERVER[5]}:7002 \
	${SERVER[6]}:7001  ${SERVER[6]}:7002 \
	${SERVER[7]}:7001  ${SERVER[7]}:7002 
	#${SERVER[8]}:7001  ${SERVER[8]}:7002 \
	#${SERVER[9]}:7001  ${SERVER[9]}:7002 \
	#${SERVER[10]}:7001 ${SERVER[10]}:7002 \
	#${SERVER[11]}:7001 ${SERVER[11]}:7002 \
	#${SERVER[12]}:7001 ${SERVER[12]}:7002 \
	#${SERVER[13]}:7001 ${SERVER[13]}:7002 \
	#${SERVER[14]}:7001 ${SERVER[14]}:7002 \
	#${SERVER[14]}:7001 ${SERVER[14]}:7002 

#	redis-cli --cluster create $SERVER1_IP:7001 $SERVER2_IP:7001 $SERVER3_IP:7001 $SERVER4_IP:7001 $SERVER5_IP:7001 $SERVER6_IP:7001 $SERVER7_IP:7001 $SERVER8_IP:7001
