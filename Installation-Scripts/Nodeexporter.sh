#!/bin/bash

# Step 1: Download Node Exporter
echo "Downloading Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz

# Step 2: Extract the Tarball
echo "Extracting Node Exporter tarball..."
tar -zxvf node_exporter-1.2.2.linux-amd64.tar.gz

# Step 3: Move Node Exporter to the desired installation directory (optional)
echo "Moving Node Exporter to installation directory..."
sudo mv node_exporter-1.2.2.linux-amd64 /opt/node_exporter

# Step 4: Create a systemd service for Node Exporter
echo "Creating Node Exporter systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Step 5: Reload systemd and start Node Exporter service
echo "Reloading systemd and starting Node Exporter service..."
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Step 6: Verify Node Exporter installation
echo "Verifying Node Exporter installation..."
curl -I http://localhost:9100

echo "Node Exporter installation completed successfully."