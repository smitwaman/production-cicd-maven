## production-cicd-maven

let's design one cicd project with following tools with all script files for application installation and configuration for java source code with following steps.

1. [Git ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Git.sh)for SCM and webhook to jenkins for automation trigger
2. [Jenkins ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Jenkins.sh) with [Java](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Java.sh)for integration
3. [Prometheus ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Prometheus.sh)and [Grafana ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Grafana.sh)for monitoring jenkins
4. [Maven](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Maven.sh)for code compile and build artifact
5. [SonarQube ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/SonarQube.sh)fore quality check 
6. Jenkins-Gmail for status of build
7. [Nexus](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Nexus.sh) to store artifact
8. [Trivy](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Trivy.sh )for OWPS
9. [Docker](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Docker.sh) to create image
10. Push image to registry
11. Deploy cluster using docker swarm
12. monitoring docker swarm using Prometheus and Grafana
13. Slack for message alert


👉 [🔗 Link to Outline File for steps](Outline.md)

👉 [🔗 Link for Docker-Applications-Run](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Run.sh)
