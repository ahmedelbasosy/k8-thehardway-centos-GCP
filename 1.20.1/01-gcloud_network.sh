#!/bin/bash
echo "# Creating Custom VPC#"
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

echo "# Creating Custom Subnet#"
gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24

echo "# Creating Internal Firewall Rules #"
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

echo "# Creating External Firewall Rules #"
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

######################

echo "# Creating a Public IP #"
gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)

######################

./04-verification.sh
