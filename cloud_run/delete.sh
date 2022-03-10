#! /bin/bash
PROJECT_ID=$(cat ../project_id)

gcloud run services delete demo \
  --region us-central1 \
  --quiet

gsutil rm -r gs://${PROJECT_ID}_cloudbuild