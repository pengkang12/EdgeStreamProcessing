#!/bin/bash

/opt/zookeeper/bin/zkServer.sh start

exec "$@"
