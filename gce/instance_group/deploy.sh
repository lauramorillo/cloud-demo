#! /bin/bash

# Create a template for the instances containing the startup script that
# starts the application
gcloud compute instance-templates create demo-template \
  --machine-type=e2-micro \
  --metadata-from-file startup-script=../startup.sh \
  --tags demo \
  --preemptible \
  --region us-central1 \
  --network=default \
  --subnet=default \

# Create a managed instance group from the template instance
gcloud compute instance-groups managed create demo-group \
  --zone us-central1-f \
  --size 2 \
  --template demo-template

# Define autoscaling policy for the managed instance group
gcloud compute instance-groups managed set-autoscaling demo-group \
  --max-num-replicas 20 \
  --min-num-replicas 2 \
  --target-cpu-utilization 0.60 \
  --zone us-central1-f

# Assign a named port
gcloud compute instance-groups set-named-ports demo-group \
  --named-ports http:8080 \
  --zone us-central1-f

# Create firewall rule to allow traffic to our app
gcloud compute firewall-rules create demo-allow-http-8080 \
  --network=default \
  --allow tcp:8080 \
  --source-ranges 0.0.0.0/0 \
  --target-tags demo \
  --description "Allow port 8080 access to server"

# Reserve the load balancer IP address
gcloud compute addresses create demo-address  \
  --ip-version=IPV4 \
  --network-tier=PREMIUM \
  --global

# Create a HTTP health check to monitor load balanced instances
gcloud compute health-checks create http demo-health-check \
  --request-path='/' \
  --use-serving-port

# Define backend service
gcloud compute backend-services create demo-backend-service \
  --load-balancing-scheme=EXTERNAL \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=demo-health-check \
  --global

# Add backend service
gcloud compute backend-services add-backend demo-backend-service \
  --balancing-mode=UTILIZATION \
  --instance-group=demo-group \
  --instance-group-zone=us-central1-f \
  --global

# Define the url map for the backend service created
gcloud compute url-maps create demo-map \
  --default-service=demo-backend-service

# Create the target proxy
gcloud compute target-http-proxies create demo-proxy \
  --url-map=demo-map

# Create forwarding rule pointing to reserved address
gcloud compute forwarding-rules create demo-forwarding-rule \
  --load-balancing-scheme=EXTERNAL \
  --address=demo-address \
  --ports=80 \
  --target-http-proxy=demo-proxy \
  --global