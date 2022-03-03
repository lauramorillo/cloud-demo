#! /bin/bash

gcloud container clusters delete demo-cluster \
    --zone us-central1-f \
    --quiet