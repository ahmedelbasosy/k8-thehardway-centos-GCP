#!/bin/bash

echo "##### Generating The Service Account Key Pair #####"

mkdir -p certifications/service_account_key_pair
cd certifications/service_account_key_pair
{

cat > service-account-csr.json <<EOF
{
  "CN": "service-accounts",
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
  -profile=kubernetes \
  service-account-csr.json | cfssljson -bare service-account

}
