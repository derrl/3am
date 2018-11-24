#!/bin/bash
# Install Mellanox infiniband drivers 
# Author:  lhz6@outlook.com
# Written in Nov.11.2018

IB_CONF_FILE=./ib0.cfg

lspci |grep Mellanox
apt install  linux-headers-`uname -r`
apt-get install -y dkms infiniband-diags libibverbs* ibacm librdmacm* libmlx4* libmlx5* mstflint libibcm.* libibmad.* libibumad* opensm srptools libmlx4-dev librdmacm-dev rdmacm-utils ibverbs-utils perftest vlan ibutils
apt-get install  -y libtool autoconf automake build-essential ibutils ibverbs-utils rdmacm-utils infiniband-diags perftest librdmacm-dev libibverbs-dev libmlx4-1 numactl libnuma-dev autoconf automake gcc g++ git libtool pkg-config
apt-get install -y libnl-3-200 libnl-route-3-200 libnl-route-3-dev libnl-utils
echo mlx4_ib >> /etc/modules
echo ib_umad >> /etc/modules
echo ib_cm >> /etc/modules
echo ib_ucm >> /etc/modules
echo rdma_ucm >> /etc/modules
modprobe mlx4_ib
modprobe ib_umad
modprobe ib_cm 
modprobe ib_ucm
modprobe rdma_ucm
mkdir /opt/mft
cd /opt/mft
wget http://www.mellanox.com/downloads/MFT/mft-4.10.0-104-x86_64-deb.tgz
tar xzf mft-4.10.0-104-x86_64-deb.tgz
cd mft-4.10.0-104-x86_64-deb
./install.sh
mst start
#mlxconfig -y -d /dev/mst/mt4099_pciconf0 set LINK_TYPE_P1=2 LINK_TYPE_P2=2
ibstat
ibv_devinfo

#cp $IB_CONF_FILE /etc/network/interfaces.d/
#/etc/init.d/networking restart
ifconfig
