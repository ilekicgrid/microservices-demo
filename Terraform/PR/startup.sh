#!/bin/bash

# Apply Terraform configurations and check if it was successful
terraform apply --auto-approve
if [ $? -eq 0 ]; then
    echo "Terraform apply completed successfully."
    gcloud auth activate-service-account --key-file=/Users/vdjurovic/Downloads/GCP_Keys/gd-gcp-gridu-devops-t1-t2-8f6b8b5512c0.json
    # Proceed with getting credentials and applying Kubernetes configurations
    gcloud container clusters get-credentials vdjurovic-cluster --region us-central1 --project gd-gcp-gridu-devops-t1-t2
    kubectl apply -f sock-shop.yaml
else
    echo "Terraform apply failed."
    # Handle the error case here, perhaps with a retry or exit
    exit 1
fi
