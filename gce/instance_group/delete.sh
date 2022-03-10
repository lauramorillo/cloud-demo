#! /bin/bash

# Delete forwarding
gcloud compute forwarding-rules delete demo-forwarding-rule \
  --global \
  --quiet

# Delete the target proxy
gcloud compute target-http-proxies delete demo-proxy \
  --quiet

# Delete the url map
gcloud compute url-maps delete demo-map \
  --quiet

# Delete backend service
gcloud compute backend-services delete demo-backend-service \
  --global \
  --quiet

# Delete IP address
gcloud compute addresses delete demo-address  \
  --global \
  --quiet

# Delente instance group
gcloud compute instance-groups managed delete demo-group \
  --zone us-central1-f \
  --quiet

# Delete instance-template
gcloud compute instance-templates delete demo-template \
  --quiet

# Delete firewall rule
gcloud compute firewall-rules delete demo-allow-http-8080 \
  --quiet

# Delete health check
gcloud compute health-checks delete demo-health-check \
  --quiet