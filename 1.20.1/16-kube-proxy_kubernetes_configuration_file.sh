#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

echo "##### Generating The kube-proxy Kubernetes Configuration File #####"
mkdir -p kubeconfig/kube_proxy_kubeconfig
cd kubeconfig/kube_proxy_kubeconfig

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../certifications/cert_authority/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=../../certifications/kube_proxy_client_cert/kube-proxy.pem \
    --client-key=../../certifications/kube_proxy_client_cert/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
