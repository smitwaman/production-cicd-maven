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


👉 Installation of Jenkins cluster to kubernetes using Helm Chart

To install Jenkins using Helm charts, follow these steps:

1. **Install Helm:**
   If you haven't already installed Helm, you need to do so. You can follow the official Helm documentation for installation instructions: https://helm.sh/docs/intro/install/

2. **Add Jenkins Helm Repository:**
   Add the official Jenkins Helm repository to Helm:

   ```bash
   helm repo add jenkins https://charts.jenkins.io
   helm repo update
   ```

3. **Install Jenkins:**
   Install Jenkins using the Helm chart:

   ```bash
   helm install jenkins jenkins/jenkins
   ```

   This command will install Jenkins using the default configuration provided by the Helm chart.

4. **Access Jenkins:**
   After the installation is complete, Jenkins will be accessible through a NodePort service. To find out the port:

   ```bash
   kubectl get svc jenkins
   ```

   Note down the port mapped to `http` or `https`. You can access Jenkins using the IP address of any node in your Kubernetes cluster and the mapped port.

5. **Unlock Jenkins:**
   To unlock Jenkins, you need to retrieve the initial administrator password. You can do this by running:

   ```bash
   kubectl exec -it $(kubectl get pods -l "app.kubernetes.io/component=jenkins-master" -o jsonpath="{.items[0].metadata.name}") -- /bin/cat /var/jenkins_home/secrets/initialAdminPassword
   ```

   Copy the printed password and use it to unlock Jenkins by following the on-screen instructions.

6. **Configure Jenkins:**
   Follow the Jenkins setup wizard to complete the initial configuration. This includes installing recommended plugins, creating an admin user, and configuring the Jenkins URL.

7. **Access Jenkins Dashboard:**
   Once the setup is complete, you can access the Jenkins dashboard using the IP address of any node in your Kubernetes cluster and the port you noted down earlier.

8. **Optional: Customize Jenkins Installation:**
   You can customize the Jenkins installation by providing configuration values via a `values.yaml` file or directly through the Helm command using `--set` flags. Refer to the Jenkins Helm chart documentation for available configuration options: https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins

That's it! You've successfully installed Jenkins on your Kubernetes cluster using Helm charts.




👉 Installation of Jenkins using yaml files.
We can make jenkins cluster using 

[✍️jenkins-deployment.yaml ](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Jenkins-Cluster/jenkins-deployment.yaml)
 

[✍️jenkins-service.yaml](https://github.com/smitwaman/production-cicd-maven/blob/main/Installation-Scripts/Jenkins-Cluster/jenkins-service.yaml)

### Jenkins Installation on Kubernetes using Deployment and Service YAML files:

1. **Create Deployment YAML:**
   - Create a `jenkins-deployment.yaml` file with the following content:
     ```yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: jenkins
     spec:
       replicas: 1
       selector:
         matchLabels:
           app: jenkins
       template:
         metadata:
           labels:
             app: jenkins
         spec:
           containers:
             - name: jenkins
               image: jenkins/jenkins
               ports:
                 - containerPort: 8080
                   name: http
     ```

2. **Create Service YAML:**
   - Create a `jenkins-service.yaml` file with the following content:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: jenkins
     spec:
       type: NodePort
       selector:
         app: jenkins
       ports:
         - protocol: TCP
           port: 8080
           targetPort: 8080
           nodePort: 30000  # Choose a suitable nodePort
     ```

3. **Apply YAML Files:**
   - Apply the YAML files to create the Jenkins deployment and service:
     ```bash
     kubectl apply -f jenkins-deployment.yaml
     kubectl apply -f jenkins-service.yaml
     ```

4. **Access Jenkins:**
   - Get the external IP of any node in your Kubernetes cluster:
     ```bash
     kubectl get nodes -o wide
     ```
   - Use the external IP along with the nodePort (e.g., `http://node-ip:30000`) to access Jenkins.
   - Follow the on-screen instructions to complete the Jenkins setup.

That's it! You've successfully installed Jenkins on EC2, with Docker, and on Kubernetes using deployment and service YAML files.
