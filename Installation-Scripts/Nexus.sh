

#!/bin/bash

# Step 1: Download Nexus
echo "Downloading Nexus..."
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Step 2: Extract the Tarball
echo "Extracting Nexus tarball..."
tar -zxvf latest-unix.tar.gz

# Step 3: Move Nexus to desired installation directory (optional)
# Adjust the destination directory according to your preference
echo "Moving Nexus to installation directory..."
mv nexus-*/ /opt/nexus

# Step 4: Set up Nexus as a service (optional)
# This step assumes you're using systemd for service management
echo "Setting up Nexus as a service..."
cat << EOF | sudo tee /etc/systemd/system/nexus.service
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Group=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

# Step 5: Start Nexus service
echo "Starting Nexus service..."
sudo systemctl daemon-reload
sudo systemctl start nexus
sudo systemctl enable nexus

# Step 6: Verify Nexus installation
echo "Verifying Nexus installation..."
sleep 30 # wait for Nexus to start up
curl -I http://localhost:8081

echo "Nexus installation completed successfully."