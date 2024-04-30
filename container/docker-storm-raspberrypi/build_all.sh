#!/bin/bash

# build Apache Storm images for Docker
# change to your username
username="kevin2333"

docker image rm -f `docker image ls | grep ${username} | awk '{print $3}'`
docker image rm -f `docker image ls | grep none | awk '{print $3}'`

docker build -t ${username}/storm-base base
# 
docker build -t ${username}/rasp-storm-nimbus nimbus
docker build -t ${username}/rasp-storm-worker worker
docker build -t ${username}/rasp-storm-ui ui 
docker build -t ${username}/rasp-zookeeper zookeeper
docker build -t ${username}/rasp-mqtt mqtt

docker push ${username}/rasp-storm-base:latest

docker push ${username}/rasp-storm-nimbus:latest
docker push ${username}/rasp-storm-ui:latest
docker push ${username}/rasp-storm-worker:latest
docker push ${username}/rasp-zookeeper:latest
docker push ${username}/rasp-mqtt:latest


