#!/bin/bash

# Update package index
sudo apt update

# Install Git
sudo apt install -y git

# Verify Git installation
git --version
