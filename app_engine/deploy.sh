#! /bin/bash

gcloud app create \
  --region us-central

cd ../app && gcloud app deploy \
  --quiet
