#!/bin/bash
echo "##### Bootstrapping the Control Plane Cluster #####"
for instance in controller-{0..1}; do
  gcloud compute scp \
  Bootstrapping_kubernetes_control_plane_script_CentOs.sh ${instance}:~/Bootstrapping_kubernetes_control_plane_script_CentOs.sh
  gcloud compute ssh ${instance} --command=~/Bootstrapping_kubernetes_control_plane_script_CentOs.sh
done
