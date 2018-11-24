#!/bin/bash
NMONDIR=/home/cc/nmon_res
DELETE=true
#DELETE=false

for i in {1..8}; do
	ssh server$i "sudo pkill nmon"
	if $DELETE && [ $# -ne 0 ]; then
		ssh server$i "sudo rm -r $NMONDIR/*$1*"
	fi
done
