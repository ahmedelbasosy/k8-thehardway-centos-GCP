#!/bin/bash
echo "##### Installing gcloud SDK #####"
sudo yum install wget yum-utils git -y
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-321.0.0-linux-x86_64.tar.gz
tar xvf google-cloud-sdk-*
./google*/install.sh

echo "####################################"

gcloud version

echo "####################################"

echo "##### Installing cfssl #####"

wget https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssl \
     https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssljson

chmod +x cfssl cfssljson
sudo mv cfssl cfssljson /usr/local/bin/
cfssl version

echo "####################################"

echo "#### Installing Kubectl #####"
curl -o kubectl https://storage.googleapis.com/kubernetes-release/release/v1.20.1/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client

echo "####################################"

gcloud init







