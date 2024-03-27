## production-cicd-maven

let's design one cicd project with following tools with all script files for application installation and configuration for java source code with following steps.

1. Git for SCM and webhook to jenkins for automation trigger
2. Jenkins for integration
3. Prometheus and Grafana for monitoring jenkins
4. Maven for code compile and build artifact
5. SonarQube fore quality check 
6. Jenkins-Gmail for status of build
7. Nexus to store artifact
8. Trivy for OWPS
9. Docker to create image
10. Push image to registry
11. Deploy cluster using docker swarm
12. monitoring docker swarm using Prometheus and Grafana
13. Slack for message alert
