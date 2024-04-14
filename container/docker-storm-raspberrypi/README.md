### Apache Storm images for Docker

* Linux version: ubuntu 20.04 64 bits
* hardware: Raspberry Pi 

### Build Container one by one
* ```docker build -t <name>/storm-base base```
* ```docker build -t <name>/storm-nimbus nimbus```
* ```docker build -t <name>/storm-worker worker```

### Build all by script, when you use this script, please change username to your username. 
* ```bash build_all.sh```


### test your docker container on your single node
```
sudo docker run -td --rm -p 2181:2181 --network=test zookeeper
sudo docker run -td --rm -p 6627:6627 -p 3772:3772 --network=test storm-nimbus 192.168.1.23
sudo docker run -td --rm -p 8080:8080 --network=test storm-ui 192.168.1.23 192.168.1.23
```
got to the browser, to access 192.168.1.23:8080. 192.168.1.23 is your local IP, you should use your own IP.
