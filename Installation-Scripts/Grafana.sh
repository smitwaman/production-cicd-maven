#!/bin/bash

# Step 1: Download Grafana
echo "Downloading Grafana..."
wget https://dl.grafana.com/oss/release/grafana-8.0.0.linux-amd64.tar.gz

# Step 2: Extract the Tarball
echo "Extracting Grafana tarball..."
tar -zxvf grafana-8.0.0.linux-amd64.tar.gz

# Step 3: Move Grafana to the desired installation directory (optional)
echo "Moving Grafana to installation directory..."
sudo mv grafana-8.0.0 /opt/grafana

# Step 4: Create a Grafana configuration directory
echo "Creating Grafana configuration directory..."
sudo mkdir -p /etc/grafana

# Step 5: Copy the default configuration file
echo "Copying default configuration file..."
sudo cp /opt/grafana/conf/sample.ini /etc/grafana/grafana.ini

# Step 6: Create a systemd service for Grafana
echo "Creating Grafana systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/grafana.service
[Unit]
Description=Grafana Service
After=network-online.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=/opt/grafana
ExecStart=/opt/grafana/bin/grafana-server -homepath /opt/grafana

[Install]
WantedBy=multi-user.target
EOF

# Step 7: Reload systemd and start Grafana service
echo "Reloading systemd and starting Grafana service..."
sudo systemctl daemon-reload
sudo systemctl start grafana
sudo systemctl enable grafana

# Step 8: Verify Grafana installation
echo "Verifying Grafana installation..."
curl -I http://localhost:3000

echo "Grafana installation completed successfully."