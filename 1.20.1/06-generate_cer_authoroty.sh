#!/bin/bash
clear
echo "##### Generating Certificates #####"
sleep 2
echo "##### Generating Certificate Authority #####"
mkdir -p certifications/cert_authority
cd certifications/cert_authority

{

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "EG",
      "L": "Cairo",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Cairo"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

}
