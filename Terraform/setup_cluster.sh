#!/bin/bash

# Function to handle failure based on specific error message
handle_installation_error() {
    release_name=$1
    if [[ $? -ne 0 ]]; then
        # Capture the error message
        error_message=$(helm install $release_name 2>&1)

        # Check if the error message is about re-using a name
        if echo $error_message | grep -q "cannot re-use a name that is still in use"; then
            echo "Warning: $release_name is already installed or in use. Continuing..."
        else
            echo "Error: Installation of $release_name failed. Exiting script."
            exit 1
        fi
    fi
}

# Add Helm repositories and update
echo "Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install kube-prometheus
echo "Installing kube-prometheus..."
helm install -n monitoring kube-prometheus prometheus-community/kube-prometheus-stack --create-namespace
handle_installation_error "kube-prometheus"

# Install tempo
echo "Installing tempo..."
helm install tempo grafana/tempo-distributed -n monitoring
handle_installation_error "tempo"

# Install loki
echo "Installing loki..."
helm install loki grafana/loki -n monitoring
handle_installation_error "loki"

# Port-forward Grafana service
echo "Setting up port-forwarding for Grafana..."
kubectl port-forward -n monitoring service/kube-prometheus-grafana 80

echo "All installations and port-forwarding completed successfully."
