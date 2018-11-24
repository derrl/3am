#!/bin/bash
#generate a serious number of pfs server hosts configuration

for j in {1..8};do
	for i in {0..3};do
		echo server$[8*$i+$j]
	done 
done

