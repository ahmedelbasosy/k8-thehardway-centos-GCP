#!/bin/bash

gcloud compute scp rbac_for_Kubelet_Authorization.sh controller-0:~/
gcloud compute ssh controller-0 --command=~/rbac_for_Kubelet_Authorization.sh
