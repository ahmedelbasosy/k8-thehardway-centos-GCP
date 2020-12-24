#!/bin/bash
clear
./01-gcloud_network.sh
./02-controllers.sh
./03-workers.sh
./04-verification.sh
sleep 45
./05-configure_ssh_access.sh
./06-generate_cer_authoroty.sh
./07-admin_client_cert.sh
./08-workers_client_cert.sh
./09-controller_manager_client_cert.sh
./10-kube_proxy_client_cert.sh
./11-kube_scheduler_client_cert.sh
./12-kube_api_server_cert.sh
./13-service_account_key_pair.sh
./14-distribute_cert.sh
#./15-kubelet_kubernetes_configuration_file.sh
#./16-kube-proxy_kubernetes_configuration_file.sh
#./17-kube-controller-manager_kubernetes_configuration_file.sh
#./18-kube-scheduler_kubernetes_configuration_file.sh
#./19-admin_kubernetes_configuration_file.sh
#./20-disribute_Configuration_files.sh
#./21-data_encryption_keys.sh
#./22-Bootstrapping_etcd_cluster.sh
