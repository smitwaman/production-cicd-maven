#!/bin/bash

# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.30.1/prometheus-2.30.1.linux-amd64.tar.gz

# Extract Prometheus
tar -xzf prometheus-2.30.1.linux-amd64.tar.gz

# Move Prometheus files to /usr/local/bin directory
sudo mv prometheus-2.30.1.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.30.1.linux-amd64/promtool /usr/local/bin/

# Clean up downloaded files
rm -rf prometheus-2.30.1.linux-amd64.tar.gz prometheus-2.30.1.linux-amd64

# Create Prometheus configuration directory
sudo mkdir /etc/prometheus

# Copy Prometheus configuration file
sudo cp prometheus.yml /etc/prometheus/

# Create Prometheus data directory
sudo mkdir /var/lib/prometheus

# Create Prometheus user and set permissions
sudo useradd --no-create-home --shell /bin/false prometheus
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

# Create Prometheus service file
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Check Prometheus service status
sudo systemctl status prometheus
