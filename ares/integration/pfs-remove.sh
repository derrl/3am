#!/bin/bash
# This bash script is to remove orangefs  services in ares
# Author:  lhz6@outlook.com
# Written in Apr.28.2019

SSH_USER=hliu91
PVFS_LOG_DIR=/mnt/hdd/$SSH_USER/orangefs/log
PVFS_STORAGE_DIR=/mnt/hdd/$SSH_USER/orangefs/storage


for i in {01..16}; do
	HOSTNM=ares-stor-$i
	echo Kill pvfs2 server on $HOSTNM
	ssh  -oStrictHostKeyChecking=no $SSH_USER@ares-stor-$i-40g "pkill pvfs2"
	echo remove pvfs log on $HOSTNM
	ssh  $SSH_USER@ares-stor-$i-40g "rm -rf $PVFS_LOG_DIR"
	echo remove pvfs storage on $HOSTNM
	ssh  $SSH_USER@ares-stor-$i-40g "rm -rf $PVFS_STORAGE_DIR"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server -f $PVFS_CONF -a server$i'"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server $PVFS_CONF -a server$i'"
done

