#! /bin/bash

# Run always first docker auth configuration
# gcloud auth configure-docker us-central1-docker.pkg.dev

PROJECT_ID=$(cat ../../project_id)
VERSION=1
TAG=gcr.io/${PROJECT_ID}/demo-repo:gke${VERSION}

docker build ../../app -t ${TAG}
docker push ${TAG}

gcloud container clusters create-auto demo-auopilot \
  --region us-central1

gcloud container clusters get-credentials demo-cluster --zone us-central1-f

kubectl apply -f ../deployment.yaml
kubectl apply -f ../service.yaml
kubectl apply -f ../ingress.yaml
