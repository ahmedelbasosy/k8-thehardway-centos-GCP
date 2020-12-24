#!/bin/bash
clear
echo "##### Distribute the Kubernetes Configuration Files #####"

for instance in worker-{0..1}; do
  gcloud compute scp kubeconfig/worker_kubeconfig/${instance}.kubeconfig \
   kubeconfig/kube_proxy_kubeconfig/kube-proxy.kubeconfig ${instance}:~/
done

echo "##### Distribute Controllers kubeconfig Files #####"


for instance in controller-{0..1}; do
  gcloud compute scp \
  kubeconfig/kube-admin_kubeconfig/admin.kubeconfig \
  kubeconfig/kube-controller-manager_kubeconfig/kube-controller-manager.kubeconfig \
  kubeconfig/kube-scheduler_kubeconfig/kube-scheduler.kubeconfig ${instance}:~/
done

