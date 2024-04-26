#!/bin/bash
# this code is tested at ubuntu 20.04-64 bit for raspberry pi 4
# specify kubernetes' version you want to install.
version=1.25

mkdir /etc/apt/keyrings/

curl -fsSL https://pkgs.k8s.io/core:/stable:/v${version}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${version}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt upgrade

echo "apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 "

apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 --allow-downgrades 

# install container
apt install -y containerd containernetworking-plugins

# Set up containerd with cgroup
cat <<EOF | sudo tee /etc/containerd/config.toml
version = 2
[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
    [plugins."io.containerd.grpc.v1.cri".containerd]
      [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true
EOF
# Forwarding IPv4 and letting iptables see bridged traffic
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# install cluster networking
wget https://github.com/flannel-io/flannel/releases/download/v0.19.2/flanneld-arm64
sudo chmod +x flanneld-arm64
sudo cp flanneld-arm64 /usr/local/bin/flanneld
sudo mkdir -p /var/lib/k8s/flannel/networks

# 
sudo swapoff -a

echo "-------------------------------------------------------------"
echo "please run the following command to build kubernete cluster"
echo "sudo systemctl restart containerd.service"
echo "sudo kubeadm init  --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors=... |sudo  tee /var/log/kubeinit.log"
echo "Build the network cluster for kubernetes"
echo "kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml"
