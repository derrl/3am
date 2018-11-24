#!/bin/bash
# This script is to send file to server1...server8.
# After distribute orangefs to all servers, initialize pvfs data space.
# Author:  lhz6@outlook.com
# Written in NOV.10.2018	

OBJECT=~/pvfs-main
KEY=~/key/objbechkey.pem
DESTINATION=~/
SSH_USER=cc

for i in {2..8}; do
	echo send $OBJECT to server$i 
	scp -i $KEY -r $OBJECT $SSH_USER@server$i:$DESTINATION 
	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PVFS_INSTALLATION/lib' >> /etc/bash.bashrc'"
done

#Initialize orangefs data space and start pvfs service on server1..server8
PVFS_INSTALLATION=~/pvfs-main/pvfs-installation
PVFS_CONF=~/pvfs-main/pvfs-installation/etc/orangefs-8n8p.conf


for i in {1..8}; do
	echo Initiallze server$i pvfs data space
	ssh -i $KEY $SSH_USER@server$i "sudo $PVFS_INSTALLATION/sbin/pvfs2-server -f $PVFS_CONF -a server$i"
	ssh -i $KEY $SSH_USER@server$i "sudo $PVFS_INSTALLATION/sbin/pvfs2-server $PVFS_CONF -a server$i"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server -f $PVFS_CONF -a server$i'"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server $PVFS_CONF -a server$i'"
done

	
