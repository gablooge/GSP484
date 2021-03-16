#!/bin/bash
# Task 1
# git clone https://github.com/GoogleCloudPlatform/gke-tracing-demo
cd gke-tracing-demo
cd terraform

gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a

PROJECT_ID=$(gcloud config get-value project)

terraform init

terraform plan -out=tfplan -var "project=$PROJECT_ID" -var "zone=us-central1-a"
terraform apply tfplan 

kubectl apply -f tracing-demo-deployment.yaml

# echo http://$(kubectl get svc tracing-demo -n default -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# gcloud pubsub subscriptions pull --auto-ack --limit 10 tracing-demo-cli

# setelah dapet IP
curl http://$(kubectl get svc tracing-demo -n default -o jsonpath='{.status.loadBalancer.ingress[0].ip}')?string=HelloWorld
