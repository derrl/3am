#!/bin/bash
# Initialize pvfs data space and service.
# Author:  lhz6@outlook.com
# Written in Apr.28.2019

#Initialize orangefs data space and start pvfs services on servers
SSH_USER=hliu91

PVFS_INSTALLATION=/opt/ohpc/pub/orangefs
PVFS_CONF=/home/hliu91/integration/orangefs-16nodes.conf 
PVFS_LOG_DIR=/mnt/hdd/$SSH_USER/orangefs/log

echo $PVFS_LOG_DIR
for i in {01..16}; do
	echo Initiallze ares-stor-$i pvfs data space
	ssh  -oStrictHostKeyChecking=no $SSH_USER@ares-stor-$i-40g "rm -rf /mnt/hdd/hliu91/orangefs"
	ssh   $SSH_USER@ares-stor-$i-40g "$PVFS_INSTALLATION/sbin/pvfs2-server -f $PVFS_CONF -a ares-stor-$i-40g"
	ssh  $SSH_USER@ares-stor-$i-40g "mkdir -p $PVFS_LOG_DIR"
	ssh  $SSH_USER@ares-stor-$i-40g "$PVFS_INSTALLATION/sbin/pvfs2-server $PVFS_CONF -a ares-stor-$i-40g"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server -f $PVFS_CONF -a server$i'"
#	ssh -i $KEY $SSH_USER@server$i "sudo su - -c '$PVFS_INSTALLATION/sbin/pvfs2-server $PVFS_CONF -a server$i'"
done

