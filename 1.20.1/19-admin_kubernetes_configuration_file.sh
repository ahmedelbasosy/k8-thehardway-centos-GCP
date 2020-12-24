#!/bin/bash
echo "##### Generating The admin Kubernetes Configuration File #####"

mkdir kubeconfig/kube-admin_kubeconfig
cd kubeconfig/kube-admin_kubeconfig

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../certificate/cert_authority/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=../../certificate/admin_cert/admin.pem \
    --client-key=../../certificate/admin_cert/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}

