#!/bin/bash

# Step 1: Download Maven
echo "Downloading Maven..."
wget https://downloads.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz

# Step 2: Extract the Tarball
echo "Extracting Maven tarball..."
tar -zxvf apache-maven-3.8.4-bin.tar.gz

# Step 3: Set Environment Variables
echo "Setting up environment variables..."
export MAVEN_HOME=$(pwd)/apache-maven-3.8.4
export PATH=$MAVEN_HOME/bin:$PATH

# Step 4: Verify Installation
echo "Verifying Maven installation..."
mvn -version

echo "Maven installation completed successfully."