#!/bin/bash
# Start nmon on server1 to server8.
# Author:  lhz6@outlook.com
# Written in Nov.18.2018

RESULT_DIR=/home/cc/nmon_res/
RESULT_NAME=
SECOND=10
COUNT=360
#COUNT=180
#COUNT=24
KEY=~/key/objbechkey.pem
USER=cc

if [ $# -ne 1 ]; then
	echo Usage: ./nmon-start.sh Test-name
	exit 1
fi

#echo Total runtime will be $(($SECOND*$COUNT)) seconds.
echo Total runtime will be $(($SECOND*$COUNT/60)) minutes.

for i in {1..8}; do
#####	ssh -oStrictHostKeyChecking=no -i $KEY $USER@server$i "sudo apt install -y nmon"
	ssh -oStrictHostKeyChecking=no -i $KEY $USER@server$i "sudo pkill nmon"
	echo Start nmon on server$i
	if [ ! -d $RESULT_DIR ]; then
		echo Create result directory 
#####		ssh -i $KEY $USER@server$i "sudo rm -rf $RESULT_DIR"
		ssh -i $KEY $USER@server$i "sudo mkdir $RESULT_DIR 2>/dev/null"
		ssh -i $KEY $USER@server$i "sudo chown cc:cc -R $RESULT_DIR"
	fi

	if [ $# -ne 0 ]; then
		RESULT_NAME="nmon-server$i-$1"
		echo Store results named $RESULT_NAME.
		ssh -i $KEY $USER@server$i "sudo mkdir $RESULT_DIR$RESULT_NAME 2>/dev/null"
		ssh -i $KEY $USER@server$i "sudo chown cc:cc -R $RESULT_DIR$RESULT_NAME"
		ssh -t -i $KEY $USER@server$i "sudo nmon -f -t -s $SECOND -c $COUNT -m $RESULT_DIR$RESULT_NAME" 
	else
		echo Store results name default.
		ssh -i $KEY $USER@server$i "sudo nmon -f -t -s $SECOND -c $COUNT -m $RESULT_DIR "
	fi
done
