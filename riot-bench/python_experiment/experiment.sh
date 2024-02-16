#!/bin/bash

# configure phyiscal network
bash network_generator/simulation_network/setup.sh 15 50 50 50

# clean environment
redis-cli flushall
#cat container_name.txt | while read line; do kubeclean $line; done;

home="/home/cc/storm/"

app0="ETLTopologySYS"
app1="IoTPredictionTopologySYS"
app2="IoTPredictionTopologyTAXI"
app3="ETLTopologyTAXI"
app4="IoTTrainTopologySYS"
app5="IoTTrainTopologyTAXI"

for app in $app0 $app1 $app2 $app3 $app4 $app5
do
echo $app
# remove application
kubectl exec nimbus -- ${home}bin/storm kill $app
done

sleep 120
sleep $[ 60 - $(date +%s) % 60  ]

# create application
scale="10"
baseline=$1
# remove application
#kubectl exec nimbus -- /bin/bash ${home}riot-bench/python_experiment/scripts/run_${app}.sh $scale beaver
kubectl exec nimbus -- /bin/bash ${home}riot-bench/python_experiment/scripts/run_ETL_sys.sh 1.2 $baseline
sleep 10
kubectl exec nimbus -- /bin/bash ${home}riot-bench/python_experiment/scripts/run_PREDICT_sys.sh 0.6 $baseline 
sleep 10
kubectl exec nimbus -- /bin/bash ${home}riot-bench/python_experiment/scripts/run_ETL_taxi.sh 1.2 $baseline 
sleep 10
kubectl exec nimbus -- /bin/bash ${home}riot-bench/python_experiment/scripts/run_PREDICT_taxi.sh 0.6 $baseline 
sleep 10

sleep 300
echo "`date` $baseline" >> start_time.log
# start to control CPU resource

# clear application data
LOG="data/"
rm ${LOG}perf.log
rm /tmp/skopt*

redis-cli flushall

ps aux | grep performance | awk '{print $2}' | xargs  kill -9

sleep $[ 60 - $(date +%s) % 60  ]

LOG_FILE="data/perf.log"
for i in {1..125}
do
sleep 56
python3.7 scripts/perf.py >> ${LOG_FILE} &

sleep $[ 60 - $(date +%s) % 60  ]
done

