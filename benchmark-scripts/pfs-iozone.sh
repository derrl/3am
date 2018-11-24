#!/bin/bash
# Iozone benchmark on server1 ... server8
# Author:  lhz6@outlook.com
# Written in Nov.18.2018

KEY=~/key/objbechkey.pem
USER=cc
IOZONE_PATH=/home/cc/client-main/iozone3_484/src/current/iozone
PVFS_MOUNT=/mnt/pvfs-shared
WRITE=true
START_NMON=/home/cc/benchmark-scripts/nmon-start.sh
NMON_TEST=false
KILL_BENCHMARK=false
THREADS=32

if $KILL_BENCHMARK; then
	read -p 'Do you really want to kill the benchmark???("yes" or "no")' USER_DECISION
	if [ $USER_DECISION = "yes" ]; then
		echo Kill iozone benchmark.
		for i in {1..8}; do
			ssh -i $KEY $USER@client$i "sudo pkill iozone"
			ssh -i $KEY $USER@server$i "sudo pkill nmon"
			if $WRITE; then
				ssh -i $KEY $USER@server$i "sudo rm -rf /home/cc/nmon_res/*iozone0*"
			else
				ssh -i $KEY $USER@server$i "sudo rm -rf /home/cc/nmon_res/*iozone1*"
			fi
		done
	fi
else
	if $NMON_TEST ; then
		if $WRITE; then
			$START_NMON iozone0
		else
			$START_NMON iozone1
		fi
	fi
	
	echo Starting server1 iozone benchmark.
	mkdir $PVFS_MOUNT/client1 2>/dev/null
	if $WRITE; then
		cd $PVFS_MOUNT/client1
		nohup  $IOZONE_PATH -i 0 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone0-client1.xls > ./client1-iozone0 &
	else
		cd $PVFS_MOUNT/client1
		nohup  $IOZONE_PATH -i 0 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone1-client1.xls > ./client1-iozone1 &
	fi
	
	for i in {2..8}; do
		echo Starting server$i iozone benchmark.
		ssh -oStrictHostKeyChecking=no -i $KEY $USER@client$i "mkdir $PVFS_MOUNT/client$i"
		if $WRITE; then
#			ssh -i $KEY $USER@client$i "cd $PVFS_MOUNT/client$i && nohup sudo $IOZONE_PATH -i 0 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone0-client$i.xls > client"$i"-iozone0 &"
			nohup ssh -i $KEY $USER@client$i "cd $PVFS_MOUNT/client$i && sudo $IOZONE_PATH -i 0 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone0-client$i.xls > client"$i"-iozone0 " &
		else
#			ssh -i $KEY $USER@client$i "cd $PVFS_MOUNT/client$i && nohup sudo $IOZONE_PATH -i 1 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone1-client$i.xls > client"$i"-iozone1 &"
			nohup ssh -i $KEY $USER@client$i "cd $PVFS_MOUNT/client$i && sudo $IOZONE_PATH -i 1 -e -I -r 1m -s 2g -t $THREADS  -w -Rb iozone1-client$i.xls > client"$i"-iozone1 " &
		fi
	
	done
fi	
