#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

clear
echo "##### Generating Kubernetes Configuration Files for Authentication #####"
echo "##### Generating The kubelet Kubernetes Configuration File #####"
mkdir -p kubeconfig/worker_kubeconfig
cd kubeconfig/worker_kubeconfig

for instance in worker-{0..1}; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../certifications/cert_authority/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

kubectl config set-credentials system:node:${instance} \
    --client-certificate=../../certifications/workers_client_cert/${instance}.pem \
    --client-key=../../certifications/workers_client_cert/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done

