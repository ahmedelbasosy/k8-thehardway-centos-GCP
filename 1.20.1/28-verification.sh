#!/bin/bash

echo ##### List Worker Nodes #####
gcloud compute ssh controller-0 \
  --command "kubectl get nodes --kubeconfig admin.kubeconfig"


