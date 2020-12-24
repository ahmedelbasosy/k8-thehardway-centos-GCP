#!/bin/bash
echo "##### Generating The kube-controller-manager Kubernetes Configuration File #####"

mkdir -p kubeconfig/kube-controller-manager_kubeconfig
cd kubeconfig/kube-controller-manager_kubeconfig


{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../certifications/cert_authority/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=../../certifications/controller_manager_client_cert/kube-controller-manager.pem \
    --client-key=../../certifications/controller_manager_client_cert/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}
