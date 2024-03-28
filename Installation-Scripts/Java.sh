#!/bin/bash

# Update package index
sudo apt update

# Install Java 17
sudo apt install -y openjdk-17-jdk

# Set JAVA_HOME environment variable
echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# Reload ~/.bashrc
source ~/.bashrc

# Verify Java installation
java -version
