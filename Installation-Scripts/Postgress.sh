#!/bin/bash

# Step 1: Download PostgreSQL
echo "Downloading PostgreSQL..."
wget https://ftp.postgresql.org/pub/source/v13.4/postgresql-13.4.tar.gz

# Step 2: Extract the Tarball
echo "Extracting PostgreSQL tarball..."
tar -zxvf postgresql-13.4.tar.gz

# Step 3: Install build dependencies
echo "Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y build-essential zlib1g-dev libreadline-dev libssl-dev

# Step 4: Configure, make, and install PostgreSQL
echo "Configuring, making, and installing PostgreSQL..."
cd postgresql-13.4
./configure
make
sudo make install

# Step 5: Create a PostgreSQL user and database for SonarQube
echo "Creating PostgreSQL user and database for SonarQube..."
sudo -u postgres createuser sonarqube
sudo -u postgres createdb sonarqube

# Step 6: Configure PostgreSQL for SonarQube
echo "Configuring PostgreSQL for SonarQube..."
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /usr/local/pgsql/data/postgresql.conf
echo "host    sonarqube       sonarqube       127.0.0.1/32            md5" | sudo tee -a /usr/local/pgsql/data/pg_hba.conf
echo "host    sonarqube       sonarqube       ::1/128                 md5" | sudo tee -a /usr/local/pgsql/data/pg_hba.conf

# Step 7: Start PostgreSQL service
echo "Starting PostgreSQL service..."
sudo service postgresql start

# Step 8: Verify PostgreSQL installation and configuration
echo "Verifying PostgreSQL installation and configuration..."
psql -U sonarqube -d sonarqube -c "SELECT version();"

echo "PostgreSQL installation and configuration completed successfully."