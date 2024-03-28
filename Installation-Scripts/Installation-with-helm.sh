#!/bin/bash

# Function to install Helm 3 if not already present
install_helm() {
    if ! command -v helm &> /dev/null; then
        echo "Helm 3 not found. Installing Helm 3..."
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        chmod +x get_helm.sh
        ./get_helm.sh
        rm get_helm.sh
        echo "Helm 3 installed successfully."
    else
        echo "Helm 3 is already installed."
    fi
}

# Install Helm 3 if not already present
install_helm

# Install Jenkins
helm install jenkins bitnami/jenkins -n jenkins-namespace --create-namespace --set image.repository=bitnami/jenkins,image.tag=alpine

# Install SonarQube
helm install sonarqube bitnami/sonarqube -n sonarqube-namespace --create-namespace --set image.repository=bitnami/sonarqube,image.tag=alpine

# Install Prometheus
helm install prometheus bitnami/kube-prometheus -n prometheus-namespace --create-namespace --set prometheus.server.image.repository=bitnami/prometheus,image.tag=alpine

# Install Node Exporter
helm install node-exporter bitnami/kube-prometheus-node-exporter -n node-exporter-namespace --create-namespace --set image.repository=bitnami/kube-prometheus-node-exporter,image.tag=alpine

# Install Grafana
helm install grafana bitnami/grafana -n grafana-namespace --create-namespace --set image.repository=bitnami/grafana,image.tag=alpine

# Install Nexus
helm install nexus bitnami/sonatype-nexus -n nexus-namespace --create-namespace --set image.repository=bitnami/sonatype-nexus,image.tag=alpine

# Install PostgreSQL
helm install postgresql bitnami/postgresql -n postgres-namespace --create-namespace --set image.repository=bitnami/postgresql,image.tag=alpine
