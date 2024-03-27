#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Git if not already installed
if ! command_exists git; then
  echo "Installing Git..."
  sudo apt-get update
  sudo apt-get install -y git
  echo "Git version: $(git --version)"
else
  echo "Git is already installed. Skipping..."
fi

# Install Java if not already installed
if ! command_exists java; then
  echo "Installing Java..."
  sudo apt-get update
  sudo apt-get install -y default-jdk
  echo "Java version: $(java -version)"
else
  echo "Java is already installed. Skipping..."
fi

# Install Maven if not already installed
if ! command_exists mvn; then
  echo "Installing Maven..."
  sudo apt-get update
  sudo apt-get install -y maven
  echo "Maven version: $(mvn -v)"
else
  echo "Maven is already installed. Skipping..."
fi

# Install Helm if not already installed
if ! command_exists helm; then
  echo "Installing Helm..."
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  echo "Helm version: $(helm version)"
else
  echo "Helm is already installed. Skipping..."
fi

# Install AWS CLI if not already installed
if ! command_exists aws; then
  echo "Installing AWS CLI..."
  sudo apt-get update
  sudo apt-get install -y awscli
  echo "AWS CLI version: $(aws --version)"
else
  echo "AWS CLI is already installed. Skipping..."
fi

# Install Docker if not already installed
if ! command_exists docker; then
  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-get install -y docker.io
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "Docker version: $(docker --version)"
else
  echo "Docker is already installed. Skipping..."
fi

# Install Docker Compose if not already installed
if ! command_exists docker-compose; then
  echo "Installing Docker Compose..."
  sudo apt-get update
  sudo apt-get install -y docker-compose
  echo "Docker Compose version: $(docker-compose --version)"
else
  echo "Docker Compose is already installed. Skipping..."
fi

# Install Docker Swarm if not already installed
if ! command_exists docker-swarm; then
  echo "Installing Docker Swarm..."
  sudo apt-get update
  sudo apt-get install -y docker-swarm
  echo "Docker Swarm version: $(docker swarm version)"
else
  echo "Docker Swarm is already installed. Skipping..."
fi

# Install Terraform if not already installed
if ! command_exists terraform; then
  echo "Installing Terraform..."
  sudo apt-get update
  sudo apt-get install -y terraform
  echo "Terraform version: $(terraform -v)"
else
  echo "Terraform is already installed. Skipping..."
fi

# Install boto3 using pip3 if not already installed
if ! command_exists python3; then
  echo "Python 3 is not installed. Please install it manually."
else
  if ! python3 -c "import boto3" >/dev/null 2>&1; then
    echo "Installing boto3..."
    sudo apt-get update
    sudo apt-get install -y python3-pip
    pip3 install boto3
    echo "boto3 version: $(pip3 show boto3 | grep Version)"
  else
    echo "boto3 is already installed. Skipping..."
  fi
fi

# Install Nettools if not already installed
if ! command_exists netstat; then
  echo "Installing Nettools..."
  sudo apt-get update
  sudo apt-get install -y net-tools
  echo "Nettools installed successfully."
else
  echo "Nettools is already installed. Skipping..."
fi

# Install Unzip if not already installed
if ! command_exists unzip; then
  echo "Installing Unzip..."
  sudo apt-get update
  sudo apt-get install -y unzip
  echo "Unzip installed successfully."
else
  echo "Unzip is already installed. Skipping..."
fi

# Install Tar if not already installed
if ! command_exists tar; then
  echo "Installing Tar..."
  sudo apt-get update
  sudo apt-get install -y tar
  echo "Tar installed successfully."
else
  echo "Tar is already installed. Skipping..."
fi

echo "All tools have been installed."