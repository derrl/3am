#!/bin/bash
REDIS_PORT=7001
REDIS_HOST=server1

apt install -y redis-server redis-tools
redis-cli -c -h $REDIS_HOST -p $REDIS_PORT
