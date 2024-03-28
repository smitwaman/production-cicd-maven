#!/bin/bash

# Step 1: Download Java 17 tarball
echo "Downloading Java 17 tarball..."
wget https://download.java.net/java/17/latest/legacy/server/jdk-17_linux-x64_bin.tar.gz

# Step 2: Extract the tarball
echo "Extracting Java 17 tarball..."
tar -zxvf jdk-17_linux-x64_bin.tar.gz

# Step 3: Move Java 17 to the desired installation directory (optional)
echo "Moving Java 17 to installation directory..."
sudo mv jdk-17 /usr/lib/jvm/java-17

# Step 4: Update alternatives to set Java 17 as the default
echo "Updating alternatives to set Java 17 as the default..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-17/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-17/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-17/bin/javac

# Step 5: Verify Java 17 installation
echo "Verifying Java 17 installation..."
java -version

echo "Java 17 installation completed successfully."