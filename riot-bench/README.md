## This is modified RIoTBench: A Real-time IoT Benchmark for Distributed Stream Processing Platforms 

### We fixed some bugs and errors. 

### Application  benchmarks 
| App. Name  | Code |
| ------------- | ------------- |
| Extraction, Transform and Load  dataflow  | ETL   |
| Statistical Summarization dataflow  | STATS   |
| Model Training dataflow  | TRAIN   |
| Predictive Analytics dataflow   | PRED   |


### Extraction, Transform and Load  dataflow (ETL)
 ![FCAST](https://github.com/anshuiisc/FIG/blob/master/ETL-1.png)
### Statistical Summarization dataflow (STATS) 
 ![FCAST](https://github.com/anshuiisc/FIG/blob/master/stats-1.png)
### Predictive Analytics dataflow (PRED)  
 ![FCAST](https://github.com/anshuiisc/FIG/blob/master/pred-1.png)
### Model Training dataflow (TRAIN)
 ![FCAST](https://github.com/anshuiisc/FIG/blob/master/Train-1.png)


- Steps to run benchmark's
- Once cloned  run 
    ```
   mvn clean compile package -DskipTests
    ```
- To submit jar microbenchmarks- 
 ```
 storm jar <stormJarPath>   in.dream_lab.bm.stream_iot.storm.topo.micro.MicroTopologyDriver  C  <TopoName>  <inputDataFilePath used by CustomEventGen and spout>   PLUG-<expNum>  <rate as 1x,2x>  <outputLogPath>   <tasks.properties File Path>   <microTaskName>
 
 
 ```
- For microTaskName please refer  switch logic in  MicroTopologyFactory class in package   "in.dream_lab.bm.stream_iot.storm.topo.micro"   


