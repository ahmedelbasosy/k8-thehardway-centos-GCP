#!/bin/bash

echo "##### Generating The Scheduler Client Certificate #####"

mkdir -p certifications/kube_scheduler_client_cert
cd certifications/kube_scheduler_client_cert
{

cat > kube-scheduler-csr.json <<EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "EG",
      "L": "Cairo",
      "O": "system:kube-scheduler",
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
  -profile=kubernetes \
  kube-scheduler-csr.json | cfssljson -bare kube-scheduler

}
