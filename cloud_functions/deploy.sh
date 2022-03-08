#! /bin/bash

gcloud functions deploy servePizza \
  --runtime nodejs16 \
  --trigger-http \
  --region us-central1 \
  --allow-unauthenticated \
  --source ../app