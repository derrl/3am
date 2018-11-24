#!/bin/bash
# Create redis cluster with server1..server8
# Author:  lhz6@outlook.com
# Written in Nov.10.2018

REDIS_INSTALL=/redis-shared/redis-stable
KEY=~/key/objbechkey.pem
REDIS_DEPLOY_SCRIPT=/home/cc/deploy-scripts/redis-deploy.sh
#REDIS_DEPLOY_SCRIPT=/home/cc/deploy-scripts/test.sh
COMPILE_INSTALL=true
#COMPILE_INSTALL=false

SERVER1_IP=`getent hosts server1|awk '{ print $1 }'`
SERVER2_IP=`getent hosts server2|awk '{ print $1 }'`
SERVER3_IP=`getent hosts server3|awk '{ print $1 }'`
SERVER4_IP=`getent hosts server4|awk '{ print $1 }'`
SERVER5_IP=`getent hosts server5|awk '{ print $1 }'`
SERVER6_IP=`getent hosts server6|awk '{ print $1 }'`
SERVER7_IP=`getent hosts server7|awk '{ print $1 }'`
SERVER8_IP=`getent hosts server8|awk '{ print $1 }'`

for i in {1..8}; do
	echo Server$i deploy
	ssh -oStrictHostKeyChecking=no -t -i $KEY cc@server$i "sudo bash -s" < $REDIS_DEPLOY_SCRIPT
done

if $COMPILE_INSTALL; then
	$REDIS_INSTALL/src/redis-cli --cluster create $SERVER1_IP:7001 $SERVER2_IP:7001 $SERVER3_IP:7001 $SERVER4_IP:7001 $SERVER5_IP:7001 $SERVER6_IP:7001 $SERVER7_IP:7001 $SERVER8_IP:7001
else
	redis-cli --cluster create $SERVER1_IP:7001 $SERVER2_IP:7001 $SERVER3_IP:7001 $SERVER4_IP:7001 $SERVER5_IP:7001 $SERVER6_IP:7001 $SERVER7_IP:7001 $SERVER8_IP:7001
fi

