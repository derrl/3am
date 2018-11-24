#!/bin/bash
# insert kernel modules and mount pvfs on client
# Author:  lhz6@outlook.com
# Written in Nov.10.2018
# Usage: ./deploy-scripts.sh [server hostname/ip_address]

PVFS_INSTALLATION=/home/cc/client-main/pvfs-installation/
#PVFS_INSTALLATION=/home/cc/pvfs-main/pvfs-installation/
SERVER_HOST=
PORT=3334
if [ $# -ne 0 ]; then 
	SERVER_HOST=$1
else
	SERVER_HOST=server1
fi	

echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/cc/pvfs-installation/lib" >> /etc/bash.bashrc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PVFS_INSTALLATION/lib
pkill pvfs2
umount /mnt/pvfs-shared
rmdir /mnt/pvfs-shared
mkdir /mnt/pvfs-shared
chmod 777 /mnt/pvfs-shared
rmmod pvfs2.ko
insmod `find $PVFS_INSTALLATION -name pvfs2.ko`
$PVFS_INSTALLATION/sbin/pvfs2-client -p $PVFS_INSTALLATION/sbin/pvfs2-client-core
mount -t pvfs2 tcp://$SERVER_HOST:$PORT/orangefs /mnt/pvfs-shared
if [ $? -eq  0 ]; then 
	echo Pvfs mounted.
else
	echo Please check your configuration and mount again.
fi


