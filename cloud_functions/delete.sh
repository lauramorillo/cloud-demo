#! /bin/bash

gcloud functions delete servePizza \
    --region us-central1 \
    --quiet
