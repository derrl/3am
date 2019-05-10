#!/bin/bash
# Mount PFS on this machine
CURRENT_USER=hliu91
MOUNT_PATH=/mnt/nvme/$CURRENT_USER/pvfs-shared/
PVFS_CLIENT_LOG=/mnt/nvme/hliu91/pvfs2-client.log
TARGET_HOST=ares-stor-04-40g
PORT=3334
ORANGEFS_DIR=/opt/ohpc/pub/orangefs

#Insert pvfs kernel module
sudo insmod `find $ORANGEFS_DIR -name pvfs2.ko`

#Create mount directory
mkdir -p $MOUNT_PATH
chmod 777 $MOUNT_PATH

#Start pvfs client service
sudo $ORANGEFS_DIR/sbin/pvfs2-client -p $ORANGEFS_DIR/sbin/pvfs2-client-core -L $PVFS_CLIENT_LOG

#Mount PFS service
sudo mount -t pvfs2 tcp://$TARGET_HOST:$PORT/orangefs $MOUNT_PATH
if [ $? -eq  0 ]; then 
	echo PFS mounted.
else
	echo Please check your configuration and mount again.
fi
