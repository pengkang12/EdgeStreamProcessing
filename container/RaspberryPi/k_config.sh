#!/bin/bash

# specify kubernetes' version you want to install.
version=1.24

curl -fsSL https://pkgs.k8s.io/core:/stable:/v${version}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${version}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

echo "apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 "

apt install -y kubeadm=${version}.1-1.1 kubelet=${version}.1-1.1 kubectl=${version}.1-1.1 --allow-downgrades 
