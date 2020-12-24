#!/bin/bash

echo "##### Generating The kube-scheduler Kubernetes Configuration File #####"
mkdir -p kubeconfig/kube-scheduler_kubeconfig
cd kubeconfig/kube-scheduler_kubeconfig
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../certifications/cert_authority/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=../../certifications/kube_scheduler_client_cert/kube-scheduler.pem \
    --client-key=../../certifications/kube_scheduler_client_cert/kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}
