#! /bin/bash
PROJECT_ID=[YOUR_PROJECT]

gcloud container clusters delete demo-cluster \
  --zone us-central1-f \
  --quiet

# Clean repository
image=gcr.io/${PROJECT_ID}/demo-repo
for digest in $(gcloud container images list-tags $image --limit=unlimited --format='get(digest)'); do
(
  set -x
  gcloud container images delete -q --force-delete-tags "${image}@${digest}"
)
done
