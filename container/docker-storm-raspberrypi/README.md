### Apache Storm images for Docker

* Linux version: ubuntu 20.04 64 bits
* hardware: Raspberry Pi 

### Build Container one by one
* ```docker build -t <name>/storm-base base```
* ```docker build -t <name>/storm-nimbus nimbus```
* ```docker build -t <name>/storm-worker worker```

### Build all by script, when you use this script, please change username to your username. 
* ```bash build_all.sh```
