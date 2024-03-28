#!/bin/bash

# Update package index
sudo apt update

# Install Maven
sudo apt install -y maven

# Set MAVEN_HOME environment variable
echo "export MAVEN_HOME=/usr/share/maven" >> ~/.bashrc
echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >> ~/.bashrc

# Reload ~/.bashrc
source ~/.bashrc

# Verify Maven installation
mvn -version
