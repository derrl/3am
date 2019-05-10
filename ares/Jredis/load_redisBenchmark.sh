#!/bin/bash

#let "datasize = 16*1024*1024"
let "d1 = 256*1024"
let "d2 = 1024*1024"
let "d3 = 4*1024*1024"
let "d4 = 16*1024*1024"
rbhost=/home/hliu91/Jredis/redisBenchmarkhost 
javaname=MultithreadTestRedisCluster.java
javafile=/home/hliu91/Jredis/$javaname

cd /home/hliu91/Jredis

mkdir test_dir_load
cd test_dir_load

cp $javafile .
javac $javaname 


#for threads in 40
for threads in 10 20 40
do
	for datasize in $d1 $d2 $d3 $d4
	do
		let "count = $d4/$datasize"
			curdir=`pwd`
			#./flushall-redis-cluster.sh 
#			mpssh  --user hliu91 --nokeychk -f $rbhost "cd $curdir;pwd"
			mpssh  --user hliu91 --nokeychk -f $rbhost "cd $curdir;java MultithreadTestRedisCluster $threads $datasize $count"
			#mpssh  --user hliu91 --nokeychk -f redisBenchmarkhost "cd /home/hliu91/Jredis;echo  $threads"
	done
done
pwd
