#!/bin/bash

echo "##### Generating Client and Server Certificates #####"
sleep 2
echo "##### Generating The Admin Client Certificate #####"
mkdir -p certifications/admin
cd certifications/admin

{

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "EG",
      "L": "Cairo",
      "O": "system:masters",
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
  admin-csr.json | cfssljson -bare admin

}
