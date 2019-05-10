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

mkdir test_dir
cd test_dir



#for threads in 40
for threads in 10 20 40
do
	mkdir thread$threads
	cd thread$threads
	#for datasize in $d1 $d2 $d3 $d4
	for datasize in $d2
	do
		mkdir ds$datasize
		cd ds$datasize
		let "count = $d4/$datasize*40/$threads"
		for i in {1..10}
		do
			/home/hliu91/Jredis/flushall-redis-cluster.sh >/dev/null
			mkdir test$i
			cd test$i
			curdir=`pwd`
           		cp $javafile .
			javac $javaname 
#			mpssh  --user hliu91 --nokeychk -f $rbhost "cd $curdir;pwd"
			mpssh  --user hliu91 --nokeychk -f $rbhost "cd $curdir;java MultithreadTestRedisCluster $threads $datasize $count"
			#mpssh  --user hliu91 --nokeychk -f redisBenchmarkhost "cd /home/hliu91/Jredis;echo  $threads"
			cd ..
		done
		cd ..
	done
	cd ..
done
pwd
