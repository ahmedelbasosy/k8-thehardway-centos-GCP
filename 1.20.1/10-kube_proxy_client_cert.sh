#!/bin/bash

echo "##### Generating The Kube Proxy Client Certificate #####"
mkdir -p certifications/kube_proxy_client_cert
cd certifications/kube_proxy_client_cert
{

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "EG",
      "L": "Cairo",
      "O": "system:node-proxier",
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
   kube-proxy-csr.json | cfssljson -bare kube-proxy

}
