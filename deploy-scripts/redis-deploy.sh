#!/bin/bash
# Deploy redis service on single machine
# Author:  lhz6@outlook.com
# Written in Nov.10.2018

REDIS_HOME=/redis-shared/
REDIS_PORT=7001
COMPILE_INSTALL=true
#COMPILE_INSTALL=false
KEY=~/key/objbechkey.pem

echo Deploy redis on `hostname`.
apt install -y make gcc libc6-dev tcl nmon
pkill redis-server
rm -rf $REDIS_HOME 
mkdir -p $REDIS_HOME$REDIS_PORT
cd /redis-shared
if $COMPILE_INSTALL; then
	if grep -q server-1 /etc/hostname; then 
		echo redis install on server1
		wget http://download.redis.io/redis-stable.tar.gz
		tar xzf redis-stable.tar.gz
		cd redis-stable
		make && make install
	else
		echo Copy redis dir from server1
		scp -o StrictHostKeyChecking=no -i $KEY -r cc@server1:"$REDIS_HOME"redis-stable $REDIS_HOME
	fi
else
	echo apt install redis
	apt install -y redis-server redis-tools
fi
echo "# bind 127.0.0.1"  > $REDIS_HOME$REDIS_PORT/node.conf
echo "protected-mode no"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "port $REDIS_PORT"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "pidfile /var/run/redis_$REDIS_PORT.pid"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "cluster-enabled yes"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "appendonly yes"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "appendfsync always"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "cluster-config-file nodes-$REDIS_PORT.conf"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo "cluster-node-timeout 15000"  >> $REDIS_HOME$REDIS_PORT/node.conf
echo Install finished
if $COMPILE_INSTALL; then
	nohup "$REDIS_HOME"redis-stable/src/redis-server $REDIS_HOME$REDIS_PORT/node.conf  >> $REDIS_HOME$REDIS_PORT/`hostname`-redis.log &
else
	echo Starting service...
	nohup redis-server $REDIS_HOME$REDIS_PORT/node.conf  >> $REDIS_HOME$REDIS_PORT/`hostname`-redis.log &
	sleep 1
fi
if [ $? -eq 0 ]; then
        echo redis service started on `hostname` port $REDIS_PORT.
else
	echo Error: redis service is not started!
fi
