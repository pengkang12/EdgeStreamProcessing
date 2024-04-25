#!/bin/bash

# specify kubernetes' version you want to install.
version=1.25

mkdir /etc/apt/keyrings/

curl -fsSL https://pkgs.k8s.io/core:/stable:/v${version}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${version}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update

echo "apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 "

apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 --allow-downgrades 

echo "please run the following command to build kubernete cluster"
echo "sudo kubeadm init  --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors=... |sudo  tee /var/log/kubeinit.log"
