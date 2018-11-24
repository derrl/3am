#!/bin/bash
# auto flush memory cache
# Author:  lhz6@outlook.com

sync; echo 3 > /proc/sys/vm/drop_caches
if [ $# -ne 0 ] && [ $1=="loop" ]; then 
	while true; do
		sync
	 	echo 1 > /proc/sys/vm/drop_caches
		sleep 0.2
	done &
fi

if [ $# -ne 0 ] && [ $1=="kill" ]; then 
	echo kill auto flush cache
	pkill auto-flush-cache
fi
