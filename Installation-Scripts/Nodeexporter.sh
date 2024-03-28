#!/bin/bash

# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz

# Extract Node Exporter
tar -xzf node_exporter-1.2.2.linux-amd64.tar.gz

# Move Node Exporter binary to /usr/local/bin directory
sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/

# Clean up downloaded files
rm -rf node_exporter-1.2.2.linux-amd64.tar.gz node_exporter-1.2.2.linux-amd64

# Create Node Exporter service file
sudo tee /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Node Exporter service
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Check Node Exporter service status
sudo systemctl status node_exporter
