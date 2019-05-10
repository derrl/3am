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

cd test_dir

echo "">finalRes.txt

#for threads in 10 20 40
for threads in 10 20 40
do
	#mkdir thread$threads
	cd thread$threads
	#for datasize in $d1 $d2 $d3 $d4
	for datasize in $d2
	do
		#mkdir ds$datasize
		cd ds$datasize
		echo "">res.txt	
		for i in {1..10}
		do
			#mkdir test$i
			cd test$i
			for k in {01..28}
			do
				#cat *$thread*$k* |grep time|awk 'BEGIN {min = 655360000011111; max=0}{if ($4+0 > max+0) max=$4} {if ($4+0 < min+0) min=$4} END {if((max-min)/1000000000 < 20) print "max-min= ", (max-min)/1000000000}' >> timeCostPerNode.txt
				cat *$thread*$k* |grep time|awk 'BEGIN {min = 655360000011111; max=0}{if ($4+0 > max+0) max=$4} {if ($4+0 < min+0) min=$4} END {print "max-min= ", (max-min)/1000000000}' >> timeCostPerNode.txt
			done
			cat timeCostPerNode.txt |awk 'BEGIN {count=0} {if($2 <7) sum+=$2} {if($2 <7) count++} END {print "Avg= ", sum/count}' >>../res.txt
			cat timeCostPerNode.txt |awk 'BEGIN {max = 0} {if ( $2+0 > max+0  && $2 < 7) max=$2} END {print "Max= ", max}' >>../res.txt
			#cat timeCostPerNode.txt |awk 'BEGIN {count=0} {if($2 <5) sum+=$2} {if($2 <5) count++} END {print "Avg= ", sum/count}' >>../res.txt
			#cat timeCostPerNode.txt |awk 'BEGIN {max = 0} {if ( $2+0 > max+0  && $2 < 5) max=$2} END {print "Max= ", max}' >>../res.txt
			cd ..
		done
		pwd 
		#cat res.txt|grep Max  
		cat res.txt|grep Max | awk '{sum+=$2} END {print "Avg time cost by Max is ", sum/NR}' 
		cat res.txt|grep Avg | awk '{sum+=$2} END {print "Avg time cost by Avg is ", sum/NR}'
		pwd >> ../../finalRes.txt
		cat res.txt|grep Max  >> ../../finalRes.txt #show the max time cost per test
		cat res.txt|grep Max | awk '{sum+=$2} END {print "Avg time cost is ", sum/NR}' >>../../finalRes.txt
		#cat res.txt|grep Avg | awk '{sum+=$2} END {print "Avg time cost is ", sum/NR}'
		cd ..
	done
	cd ..
done
pwd
