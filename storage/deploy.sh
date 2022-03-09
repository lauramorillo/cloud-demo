#! /bin/bash

####
# BUCKET CONTENT
####

# Use as bucket name the subdomain you want to use to serve.
# First you will need to validate domain ownership 
# https://cloud.google.com/storage/docs/domain-name-verification#verification
BUCKET_NAME=demo-storage.missbytes.com

# Create bucket
gsutil mb gs://${BUCKET_NAME}

#Copy static files
gsutil rsync -r ./img gs://${BUCKET_NAME}/img
gsutil cp *.html gs://${BUCKET_NAME}

# Assign public permission
gsutil iam ch allUsers:objectViewer gs://${BUCKET_NAME}

# Define index and error files
gsutil web set -m index.html -e 404.html gs://${BUCKET_NAME}
