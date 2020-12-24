#!/bin/bash
clear
echo "##### Distribute the Client and Server Certificates #####"

cd certifications/workers_client_cert
for instance in worker-{0..1}; do
  gcloud compute scp ../cert_authority/ca.pem  ${instance}:~/
  gcloud compute scp ${instance}-key.pem ${instance}.pem ${instance}:~/
done

echo "##### Distribute Ther Server Certs #####"

for instance in controller-{0..1}; do
  gcloud compute scp \
  ../cert_authority/ca.pem ../cert_authority/ca-key.pem \
  ../kube_api_server_cert/kubernetes-key.pem ../kube_api_server_cert/kubernetes.pem \
  ../service_account_key_pair/service-account-key.pem ../service_account_key_pair/service-account.pem ${instance}:~/
done
