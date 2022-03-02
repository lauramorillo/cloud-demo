#! /bin/bash
VM_NAME=demov1 

gcloud compute firewall-rules create ${VM_NAME}-allow-http-8080 \
    --allow tcp:8080 \
    --source-ranges 0.0.0.0/0 \
    --target-tags ${VM_NAME} \
    --description "Allow port 8080 access to server"

gcloud compute instances create ${VM_NAME} \
    --machine-type=e2-micro \
    --metadata-from-file startup-script=./startup.sh \
    --zone us-central1-f \
    --tags ${VM_NAME}