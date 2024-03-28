#!/bin/bash

# Step 1: Download Prometheus
echo "Downloading Prometheus..."
wget https://github.com/prometheus/prometheus/releases/download/v2.33.0/prometheus-2.33.0.linux-amd64.tar.gz

# Step 2: Extract the Tarball
echo "Extracting Prometheus tarball..."
tar -zxvf prometheus-2.33.0.linux-amd64.tar.gz

# Step 3: Move Prometheus to the desired installation directory (optional)
echo "Moving Prometheus to installation directory..."
sudo mv prometheus-2.33.0.linux-amd64 /opt/prometheus

# Step 4: Create a Prometheus user and group
echo "Creating Prometheus user and group..."
sudo useradd -rs /bin/false prometheus

# Step 5: Set permissions
echo "Setting permissions..."
sudo chown -R prometheus:prometheus /opt/prometheus

# Step 6: Create a Prometheus configuration file (prometheus.yml)
echo "Creating Prometheus configuration file..."
cat <<EOF | sudo tee /opt/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

# Step 7: Create a systemd service for Prometheus
echo "Creating Prometheus systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml

[Install]
WantedBy=multi-user.target
EOF

# Step 8: Reload systemd and start Prometheus service
echo "Reloading systemd and starting Prometheus service..."
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

# Step 9: Verify Prometheus installation
echo "Verifying Prometheus installation..."
curl -I http://localhost:9090

echo "Prometheus installation completed successfully."