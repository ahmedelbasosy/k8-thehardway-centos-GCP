#!/bin/bash
echo "##### Bootstrapping the WORKER Nodes #####"
for instance in worker-{0..1}; do
  gcloud compute scp \
  Bootstraping_kubernetes_worker_nodes.sh ${instance}:~/Bootstraping_kubernetes_worker_nodes.sh
  gcloud compute ssh ${instance} --command=~/Bootstraping_kubernetes_worker_nodes.sh
done
