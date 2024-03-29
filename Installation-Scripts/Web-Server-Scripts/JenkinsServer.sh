#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y openjdk-17-jdk wget git maven docker.io docker-compose

# Download Jenkins Debian package
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update apt and install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Ensure Jenkins can access Docker socket
sudo usermod -aG docker jenkins

# Restart Jenkins to apply changes
sudo systemctl restart jenkins

echo "Jenkins setup complete. Jenkins user granted access to Docker socket."
