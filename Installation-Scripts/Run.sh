#!/bin/bash

# Run Jenkins container
docker run -d --name jenkins -p 8080:8080 jenkins/jenkins

# Run SonarQube container
docker run -d — name sonar -p 9000:9000 sonarqube:lts-community

# Run Prometheus container
docker run -d --name prometheus -p 9090:9090 prom/prometheus

# Run Grafana container
docker run -d --name grafana -p 3000:3000 grafana/grafana

# Run Nexus container
docker run -d — name nexus -p 8081:8081 sonatype/nexus3:latest

# Run PostgreSQL container
docker run -d --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 postgres



# Show status of all containers
docker ps
