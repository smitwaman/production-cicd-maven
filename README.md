## [production-cicd-maven](https://github.com/smitwaman/production-cicd-maven.git)

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

- Before start of pipeline, clone the repository to your local machine.

  ```
  git clone https://github.com/smitwaman/production-cicd-maven.git

  ```
 

 👉 [💻🛠️ AppServer](Stage-1-appserver.md)

 Run following commands for installation of basic-tools on your server.


   ```
cd Installation-Scripts
chmod +x Install.sh
./Install.sh

  ```


 👉 [🔗 Link for Applications-Run-Docker](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Run.sh)

 Run following commands to run applications using Docker on your server.
  ```
cd Installation-Scripts
chmod +x Run.sh
./Run.sh
  ```

 👉 [🔗 Link for Applications-Installation-with-Helm](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Installation-with-helm.sh)

 Run following commands for installation of applications on your server with helm.
  ```
cd Installation-Scripts
chmod +x Installation-with-helm.sh
./Installation-with-helm.sh
  ```

 👉 [🔗 Lets Start configuration](Outline.md)





