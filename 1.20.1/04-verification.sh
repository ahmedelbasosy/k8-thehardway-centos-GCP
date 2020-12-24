#!/bin/bash
######################
clear

echo "##### List the firewall rules in the kubernetes-the-hard-way VPC network: #####"
gcloud compute firewall-rules list --filter="network:kubernetes-the-hard-way"

######################

echo "##### List of Public IP Address #####"
gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"

######################

echo "##### Verification #####"
gcloud compute instances list --filter="tags.items=kubernetes-the-hard-way"

######################
