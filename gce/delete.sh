#! /bin/bash
VM_NAME=demov1 

gcloud compute firewall-rules delete ${VM_NAME}-allow-http-8080 \
    --quiet

gcloud compute instances delete ${VM_NAME} \
    --zone us-central1-f \
    --quiet