#!/bin/bash
# Deploy orangefs2.9 on Ubuntu16.04 in single machine.
# Author:  lhz6@outlook.com
# Written in 11/07/2018

if [ -d $1 ]; then
	work_dir=$1
else
	work_dir=./
fi

#PVFS_HOME=/opt/orangefs
PVFS_USER=cc
PVFS_HOME=/home/$PVFS_USER/pvfs-main
PVFS_INSTALL=$PVFS_HOME/pvfs-installation
#PVFS_CONF=/home/$PVFS_USER/orangefs.conf
PVFS_CONF=/home/cc/deploy-scripts/pvfs-conf/orangefs-8n8p.conf

rm -rf $PVFS_HOME
mkdir -p $PVFS_HOME/pvfs-storage
mkdir $PVFS_HOME/pvfs-installation
mkdir $PVFS_HOME/pvfs-log

apt install -y automake build-essential bison flex libattr1 libattr1-dev gcc libssl-dev libdb-dev linux-source perl make autoconf linux-headers-`uname -r` zip openssl automake autoconf patch g++  nmon

cd $PVFS_HOME
wget http://download.orangefs.org/current/source/orangefs-2.9.7.tar.gz
tar xzf orangefs-2.9.7.tar.gz

if [ $? -ne 0 ]; then
	exit 1
fi 

cd orangefs-2.9.7
##compile with kernel module check
if lsmod|grep -q orangefs ; then
	echo pvfs kernel module found
#	echo orangefs>>/etc/modules
#	modprobe orangefs
	./configure --prefix=$PVFS_INSTALL --enable-shared --with-db-backend=lmdb
	make && make install
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PVFS_INSTALL/lib' >> /etc/bash.bashrc
else
	echo pvfs kernel not found
	./configure --prefix=$PVFS_INSTALL --with-kernel=/lib/modules/`uname -r`/build --enable-shared --with-db-backend=lmdb
	make && make install
	make kmod
	make kmod_prefix=$PVFS_INSTALL kmod_install
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PVFS_INSTALL/lib' >> /etc/bash.bashrc
fi
#$PVFS_INSTALL/bin/pvfs2-genconfig $PVFS_INSTALL/etc/orangefs-server.conf
cp $PVFS_CONF $PVFS_INSTALL/etc/
chown -R $PVFS_USER:$PVFS_USER $PVFS_HOME


