#! /bin/bash
PROJECT_ID=[YOUR_PROJECT]

gcloud run services delete demo \
    --region us-central1 \
    --quiet

gsutil rm -r gs://${PROJECT_ID}_cloudbuild