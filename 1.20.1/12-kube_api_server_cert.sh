#!/bin/bash

echo "##### Generating The Kubernetes API Server Certificate #####"
mkdir -p certifications/kube_api_server_cert
cd certifications/kube_api_server_cert
{

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "EG",
      "L": "Cairo",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Cairo"
    }
  ]
}
EOF


cfssl gencert \
  -ca=../cert_authority/ca.pem \
  -ca-key=../cert_authority/ca-key.pem \
  -config=../cert_authority/ca-config.json \
  -hostname=10.32.0.1,10.240.0.10,10.240.0.11,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes

}
