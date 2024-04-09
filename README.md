## Artifact for the article "High-throughput Real-time Edge Stream Processing with Topology-Aware Resource Matching" 

In this Git repository, you will find the code for running the experiments, and the instructions to run the experiments and obtain the results.

### Directory description

* _container_ 
    * contains all the scripts to build container and set up all containerized apache storm system to Kubernetes. 
* _CustomSchedule_
    * contains all the source code to place the operator of edge stream processing application to physical edge node.
* _riot-bench_
    * contains four IoT applications based on common IoT patterns for data pre-processing, statistical summarization, and predictive analytics. We include this code because we fixed several error for the original source code and add code to use Redis measuring the end-to-end latency to improve the system performance. 
* _riot-bench/experiment_
    * contains all the essential source code required to conduct experiments, extract outcomes, and produce graphical representations of the data;
* _riot-bench/experiment/scheduling_
    * you'll find the complete source code that implements Beaver's methodology, facilitating the generation of a mapping strategy to allocate tasks across nodes.


## Running the experiments

### Hardware Requirements
* Any modern x86 or x64 CPU is appropriate to execute the experiments.
At least 4 GB of RAM for running the experiments, more details in the Instructions section.

### Software Requirements
* Operating system
    * Ubuntu 18.04/20.04
* Install Python 3, Java 1.8
    ```
    apt update
    apt install python3
    apt install jdk-openjdk-8
    ```

    * See [Docker 20.10.7](https://docs.docker.com/engine/install/ubuntu/) Installation

    * See [Kubernetes 1.23.0](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) Installation

    * See [Promethues](https://github.com/prometheus-operator/kube-prometheus) Installation

    * Install maven (3.6.1), using apt command (recommended), if maven's version is too high, you can download from [here](https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz). 

    ```
    apt install maven
    ```
    * Install [MQTT](https://mosquitto.org/download/) and [Redis](https://redis.io/docs/install/install-redis/) for RIOT benchmark

### Instruction
* Environment Setup and Installation
    * To begin, download the [Apache Storm Source Code](https://archive.apache.org/dist/storm/apache-storm-2.1.0/). 
    ```
    wget https://archive.apache.org/dist/storm/apache-storm-2.1.0/apache-storm-2.1.0-src.tar.gz
    tar -zxvf apache-storm-2.1.0-src.tar.gz
    mv apache-storm-2.1.0-src.tar.gz storm
    cd $HOME/storm
    ```

    * Clone the EdgeStreamProcessing Git repository to your local machine using the command and extract the files into the _$HOME/storm_ directory to simplify the reproduction process. 
    
    ```
    git clone https://github.com/pengkang12/EdgeStreamProcessing.git
    mv EdgeStreamProcessing/* $HOME/storm
    ```

* To deploy the operator to the designated edge node, the new scheduler requires compilation. Navigate to the _CustomScheduler_ directory and execute the command. To compile the necessary components. Following the compilation, transfer the generated JAR file from _CustomScheduler/target/_ to the  _$HOME/storm/lib/_ directory for integration. 

```
cd CustomScheduler
mvn clean compile package -DskipTests
cp CustomScheduler/target/*.jar $HOME/storm/lib/
```

* Edit configuration file _$HOME/storm/conf/storm.yaml_ to use Custom scheduler. Add the following content to configuration file.

```
    storm.scheduler: "sys.cloud.tagawarescheduler.TagAwareScheduler"
```

* Build container for running Apache Storm
    * check the file _container/docker-storm/README.md_

* Using Kubernetes to manage Apache Storm cluster
    * check the file _container/kube-storm/README.md_

## Install MQTT 
```
sudo apt update -y && sudo apt install mosquitto mosquitto-clients -y

sudo nano /etc/mosquitto/conf.d/default.conf
```
Inside the newly opened text editor paste the following instructions:
```
allow_anonymous false
password_file /etc/mosquitto/passwd
```

Then, close the text editor (CTRL + X / Y / Enter) and restart Mosquitto via:

```
sudo systemctl restart mosquitto
```

You need to modify these two files: 
```
riot-bench/modules/tasks/src/main/resources/tasks.properties
riot-bench/modules/tasks/src/main/resources/tasks_TAXI.properties
```
change IP to your IP address
```
IO.MQTT_PUBLISH.APOLLO_URL=tcp://Your-MQTT-ip-address:1883
IO.MQTT_SUBSCRIBE.APOLLO_URL=tcp://Your-MQTT-ip-address:1883
```
## Install Redis

```
sudo apt install redis-server
```
Modify this file, change hostname to your redis hostname.
```
riot-bench/modules/storm/src/main/java/in/dream_lab/bm/stream_iot/storm/genevents/logging/JRedis.java
```

## Run all experiment to collect data

To execute the experiments you must use the following command: 

```
bash ./experiment/run.sh 
```

This command will create four application in a sequential way to reproduce the experiments and execute them. The script file (run.sh) automate the execution of the experiments and have 3 main steps. In the first step, the four applications will be created using file run run\_ETL\_sys.sh, run\_ETL\_taxi.sh, run\_PREDICT\_sys.sh, and run\_PREDICT\_taxi.sh (all file located at the ./experiment/scripts/ directory). In the second step, after the creating of the Edge stream processing application, the data for generating the plots and the tables will be collected (files ./experiment/scripts/perf.py). Finally, in the last step, the data can be extracted by using ./riot-bench/experiment/scripts/read\_metric\_data.py. It takes 2 hours to run the entire workflow.

### Attention
* If you want to run this experiment on Arm Architecture, such as Raspberry Pi Device. We recommend you change Apache Storm from version 2.1.0 to version 1.2.4. Apache Storm (Version >= 2.0) can't run at Arm Architecture. Otherwise, you need to build one of library for Arm architecture. 
