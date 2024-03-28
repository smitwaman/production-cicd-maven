#!/bin/bash

# Run Jenkins container


# Run SonarQube container
docker run --name sonar -p 9000:9000 -d sonarqube:lts-community

# Run Prometheus container
docker run --name prometheus -p 9090:9090 -d prom/prometheus

# Run Grafana container
docker run --name grafana -p 3000:3000  -d grafana/grafana

# Run Nexus container
docker run --name nexus -p 8081:8081 -d sonatype/nexus3:latest

# Run PostgreSQL container
docker run  --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres



# Show status of all containers
docker ps
