#!/bin/bash
# mount pvfs on all clients
# Author:  lhz6@outlook.com
# Written in Nov.16.2018

PVFS_MOUNT_SCRIPT=pvfs-client-deploy.sh
SCRIPT_PATH=~/deploy-scripts
KEY=~/key/objbechkey.pem
USER=cc

for i in {1..8}; do
#	ssh -i $KEY cc@client$i "rm /home/cc/client-main/$PVFS_MOUNT_SCRIPT "
	scp -o StrictHostKeyChecking=no -i $KEY $SCRIPT_PATH/$PVFS_MOUNT_SCRIPT $USER@client$i:~/client-main/$PVFS_MOUNT_SCRIPT
	ssh -i $KEY cc@client$i "sudo /home/cc/client-main/$PVFS_MOUNT_SCRIPT server$i"
	ssh -i $KEY cc@client$i "ls /mnt/pvfs-shared/"
done

