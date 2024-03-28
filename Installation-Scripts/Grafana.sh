#!/bin/bash

# Add Grafana repository and import GPG key
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Update package index
sudo apt-get update

# Install Grafana
sudo apt-get install -y grafana

# Start Grafana service
sudo systemctl start grafana-server

# Enable Grafana to start on boot
sudo systemctl enable grafana-server

# Check Grafana service status
sudo systemctl status grafana-server
