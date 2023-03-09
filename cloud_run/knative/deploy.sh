#! /bin/bash
PROJECT_ID=$(cat ../../project_id)
VERSION=1
TAG=gcr.io/${PROJECT_ID}/demo-repo:gke${VERSION}

docker build ../../app -t ${TAG}
docker push ${TAG}

sed -i "s/\[YOUR_PROJECT\]/$PROJECT_ID/" app.yaml

gcloud run services replace app.yaml \
  --region us-central1 \
  --quiet

gcloud run services add-iam-policy-binding pizza-demo \
    --region us-central1 \
    --member="allUsers" \
    --role="roles/run.invoker"