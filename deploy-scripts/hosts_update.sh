#!/bin/bash
### This script is to send hosts file and ssh key to all the server nodes, then update in the file /etc/hosts.
### Usage: ./host_update.sh hosts_file
# Author:  lhz6@outlook.com
# Written in Nov.08.2018

KEY=~/key/objbechkey.pem

if [ $# -ne 1 ]; then
	echo "ERROR: Please input hosts with single file."
	echo "Usage: ./host_update.sh hosts_file"
	exit 1
else
	echo "" >> /etc/hosts
	cat $1  >> /etc/hosts
	for i in {2..8}; do
		echo server$i
#		ssh -oStrictHostKeyChecking=no -i $KEY cc@server$i "mkdir ~/key"
#		scp -i $KEY $KEY cc@server$i:~/key/

		scp -oStrictHostKeyChecking=no -i $KEY /home/cc/.ssh/id_rsa cc@server$i:~/.ssh/
		scp -i $KEY /home/cc/.ssh/id_rsa.pub cc@server$i:~/.ssh/
		scp -i $KEY $KEY cc@server$i:~/key/
		scp -i $KEY $1 cc@server$i:
		ssh -t -i $KEY cc@server$i "sudo su - -c 'cat >>/etc/hosts'" < $1
	done
	for i in {1..8}; do
		echo client$i
#		ssh -oStrictHostKeyChecking=no -i $KEY cc@client$i "mkdir ~/key"
#		scp -i $KEY $KEY cc@client$i:~/key/
		scp -oStrictHostKeyChecking=no -i $KEY /home/cc/.ssh/id_rsa cc@client$i:~/.ssh/
		scp -i $KEY /home/cc/.ssh/id_rsa.pub cc@client$i:~/.ssh/
		scp -i $KEY $1 cc@client$i:
		ssh -oStrictHostKeyChecking=no -t -i $KEY cc@client$i "sudo su - -c 'cat >/etc/hosts'" < $1
	done

fi
