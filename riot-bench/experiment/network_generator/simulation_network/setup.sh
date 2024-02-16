core1="192.168.122.132"
worker1="192.168.122.130" 
worker2="192.168.122.131" 
edge1="192.168.122.148"
edge2="192.168.122.149"
edge3="192.168.122.133"
edge4="192.168.122.22" 
edge5="192.168.122.235" 

home="/home/cc/storm/riot-bench/python_experiment/schedule_policy/network_generator/simulation_network/"

for host in  "worker1" "edge1" "edge2" "worker2" "edge4" "edge5"
#$for host in "edge1"
do

scp ${home}${host}Net.sh $host:~/.
#scp ${home}setup_kube.sh $host:~/.
#echo "syscloud" | ssh -tt $host sudo rm -rf /etc/cni/net.d
#echo "syscloud" | ssh -tt $host sudo bash ~/setup_kube.sh 

# delay increase 5ms 25ms for each layer, first 15, 50
# bandwidth increase 5Mb, 30Mb for each time, initialize 10, 50
echo "syscloud" | ssh -tt $host bash ~/${host}Net.sh $1 $2 $3 $4 
done

