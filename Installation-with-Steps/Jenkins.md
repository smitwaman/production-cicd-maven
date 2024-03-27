### Here are different scenarios for jenkins installation

you can install Jenkins on server using Docker, Kubernetes, and server.

for installation you can visit Jenkins official website on following link-

##  [➡️ 👣](https://www.jenkins.io/doc/book/installing/kubernetes/)



🎯 [Script for Jenkins installation on Installation-Scripts/Jenkins.sh ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Jenkins.sh)

We can install with following script and configure Docker Socket,later.


 
👉 With following steps you can install Jenkins with Docker Socket setting


1. **Install Jenkins:**
   You can install Jenkins using the official Debian/Ubuntu package repository. Here's how to do it on Ubuntu:

   ```bash
   wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
   sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
   sudo apt update
   sudo apt install -y openjdk-17-jdk jenkins
   ```

2. **Start Jenkins:**
   After installation, start the Jenkins service:

   ```bash
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   ```

3. **Install Docker:**
   Install Docker if it's not already installed on your server:

   ```bash
   sudo apt update
   sudo apt install -y docker.io
   ```

4. **Configure Jenkins to Use Docker Socket:**
   To allow Jenkins to communicate with the Docker daemon, you need to add the Jenkins user to the `docker` group and modify Jenkins systemd service file.

   a. Add Jenkins user to the Docker group:

      ```bash
      sudo usermod -aG docker jenkins
      ```

   b. Edit the Jenkins systemd service file:

      ```bash
      sudo systemctl edit jenkins
      ```

      Add the following lines to the editor and save the file:

      ```
      [Service]
      Environment="DOCKER_HOST=unix:///var/run/docker.sock"
      ```

   c. Reload the systemd daemon:

      ```bash
      sudo systemctl daemon-reload
      ```

5. **Restart Jenkins:**
   Restart the Jenkins service for the changes to take effect:

   ```bash
   sudo systemctl restart jenkins
   ```

6. **Verify Configuration:**
   You can verify if Jenkins can communicate with the Docker daemon by running a simple test job that executes Docker commands.

7. **Access Jenkins:**
   Open a web browser and navigate to `http://your-server-ip:8080` to access Jenkins.
   
8. **Unlock Jenkins:**
   Follow the on-screen instructions to unlock Jenkins and complete the setup.

By following these steps, we'll have Jenkins installed on your server and configured to use the system Docker socket, allowing you to build and deploy Docker containers directly from Jenkins.


👉 Here I will go for Jenkins using Docker. It made simple for us to use our system's docker socket in Jenkins

Linux
1. Open up a terminal window.

2. Create a bridge network in Docker using the following docker network create command:
```
docker network create jenkins
```
3. In order to execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image using the following docker run command:
```
docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2
```

