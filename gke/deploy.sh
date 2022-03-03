#! /bin/bash

# Run always first docker auth configuration
# gcloud auth configure-docker us-central1-docker.pkg.dev

PROJECT_ID=[YOUR_PROJECT]
VERSION=1
TAG=gcr.io/${PROJECT_ID}/demo-repo:gke${VERSION}

docker build ../app -t ${TAG}
docker push ${TAG}

gcloud container clusters create demo-cluster --zone us-central1-f
gcloud container clusters get-credentials demo-cluster --zone us-central1-f

kubectl apply -f ./deployment.yaml
kubectl apply -f ./service.yaml
kubectl apply -f ./ingress.yaml
