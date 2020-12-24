#!/bin/bash

echo "##### Bootstrapping the etcd Cluster #####"

for instance in controller-{0..1}; do
  gcloud compute scp \
  Bootstrapping_etcd_script_CentOs.sh ${instance}:~/Bootstrapping_etcd_script_CentOs.sh
  gcloud compute ssh ${instance} --command=~/Bootstrapping_etcd_script_CentOs.sh
done

clear
echo "##### Verifying ETCD Cluster Status #####"

for instance in controller-{0..1}; do
echo ${instance} Status:
sleep 2
gcloud compute ssh ${instance} --command='sudo ETCDCTL_API=3 /usr/local/bin/etcdctl  member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem'
done

