#! /bin/bash

gcloud run deploy demo \
    --source ../app \
    --region us-central1 \
    --port 8080 \
    --allow-unauthenticated \
    --quiet