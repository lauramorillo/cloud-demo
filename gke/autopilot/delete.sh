#! /bin/bash
PROJECT_ID=$(cat ../../project_id)

gcloud container clusters delete demo-autopilot \
  --region us-central1 \
  --quiet

# Clean repository
image=gcr.io/${PROJECT_ID}/demo-repo
for digest in $(gcloud container images list-tags $image --limit=unlimited --format='get(digest)'); do
(
  set -x
  gcloud container images delete -q --force-delete-tags "${image}@${digest}"
)
done
