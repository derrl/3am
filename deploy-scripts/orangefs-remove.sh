#!/bin/bash
# This bash script is to remove orangefs in server2..server8
# Author:  lhz6@outlook.com
# Written in Nov.10.2018

SSH_KEY=~/key/objbechkey.pem 
SSH_USER=cc

PVFS_MAIN=/home/$SSH_USER/pvfs-main/
PVFS_STORAGE=/home/$SSH_USER/pvfs-main/pvfs-storage
PVFS_LOG=/home/$SSH_USER/pvfs-main/pvfs-log

echo remove pvfs storage on server1
#sudo pkill pvfs2-server
sudo pkill pvfs2
sudo rm -rf $PVFS_STORAGE
mkdir $PVFS_STORAGE

echo remove pvfs log on server1
sudo rm -rf $PVFS_LOG
mkdir $PVFS_LOG

for i in {2..8}; do
	echo remove pvfs on server$i
#	ssh -i $SSH_KEY -l $SSH_USER server$i "sudo pkill pvfs2-server"
	ssh -i $SSH_KEY -l $SSH_USER server$i "sudo pkill pvfs2"
	ssh -i $SSH_KEY -l $SSH_USER server$i "sudo rm -rf $PVFS_MAIN"
#	ssh -i $SSH_KEY -l $SSH_USER server$i "rm -rf $PVFS_MAIN"
done
