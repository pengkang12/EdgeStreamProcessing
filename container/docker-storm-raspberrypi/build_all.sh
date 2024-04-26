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



nimbus_tag=`docker image ls | grep ${username}/storm | grep latest | grep nimbus | awk '{print $3}'`
ui_tag=`docker image ls | grep ${username}/storm | grep latest | grep ui | awk '{print $3}'`
worker_tag=`docker image ls | grep ${username}/storm | grep latest | grep worker | awk '{print $3}'`
zookeeper_tag=`docker image ls | grep ${username}/storm | grep latest | grep zookeeper | awk '{print $3}'`
mqtt_tag=`docker image ls | grep ${username}/storm | grep latest | grep mqtt | awk '{print $3}'`

docker tag $nimbus_tag ${username}/rasp-storm-nimbus:latest
docker tag $ui_tag ${username}/rasp-storm-ui:latest
docker tag $worker_tag ${username}/rasp-storm-worker:latest

docker tag $zookeeper_tag ${username}/rasp-zookeeper:latest
docker tag $mqtt_tag ${username}/rasp-mqtt:latest


docker push ${username}/rasp-storm-nimbus:latest
docker push ${username}/rasp-storm-ui:latest
docker push ${username}/rasp-storm-worker:latest

docker push ${username}/rasp-zookeeper:latest
docker push ${username}/rasp-mqtt:latest


