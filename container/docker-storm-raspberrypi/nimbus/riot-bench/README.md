## This is modified RIoTBench: A Real-time IoT Benchmark for Distributed Stream Processing Platforms 

### We fixed some bugs and errors. 

### Application  benchmarks 
| App. Name  | Code |
| ------------- | ------------- |
| Extraction, Transform and Load  dataflow  | ETL   |
| Statistical Summarization dataflow  | STATS   |
| Model Training dataflow  | TRAIN   |
| Predictive Analytics dataflow   | PRED   |

- Check Apache storm version, modules/pom.xml, apache storm version is same with your apache storm

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


