#!/bin/bash
kkkk=0
for i in `cat redis-cluster-nodes`
do
	SERVER[$kkkk]="`getent hosts $i|awk '{ print $1 }'`"
	echo ${SERVER[$kkkk]}
	let kkkk++
done
