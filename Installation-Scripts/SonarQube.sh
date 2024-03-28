#!/bin/bash

# Step 1: Download SonarQube
echo "Downloading SonarQube..."
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.2.3.48199.zip

# Step 2: Extract the Tarball
echo "Extracting SonarQube tarball..."
unzip sonarqube-9.2.3.48199.zip

# Step 3: Move SonarQube to the desired installation directory (optional)
echo "Moving SonarQube to installation directory..."
sudo mv sonarqube-9.2.3.48199 /opt/sonarqube

# Step 4: Create a systemd service for SonarQube
echo "Creating SonarQube systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=root
Group=root
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Step 5: Reload systemd and start SonarQube service
echo "Reloading systemd and starting SonarQube service..."
sudo systemctl daemon-reload
sudo systemctl start sonarqube
sudo systemctl enable sonarqube

# Step 6: Verify SonarQube installation
echo "Verifying SonarQube installation..."
sleep 30 # Wait for SonarQube to start up
curl -I http://localhost:9000

echo "SonarQube installation completed successfully."