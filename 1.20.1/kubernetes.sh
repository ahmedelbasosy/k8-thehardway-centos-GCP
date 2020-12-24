#!/bin/bash
curl -fsSL https://get.docker.com -o get-docker.sh
chmod +x get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $USER
echo " Kubernetes preparation On CentOS 7 "
sleep 3

echo "############# Kubernetes Installation ############"
sleep 2

echo "### Step 1: Configure Repos and Installing Software ###"

sudo /bin/yum-config-manager --add-repo https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64

echo "### Step 2: Disable SELinux and Swap ###"

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/'

sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

echo "### step 3: Installing Software and Enabling Service ###"

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now docker
sudo systemctl enable --now kubelet

echo "### Step 4: Configure System ###"

sudo cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system
sudo lsmod | grep br_netfilter
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sleep 3

echo "##### DONE #####"
