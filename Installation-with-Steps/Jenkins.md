### Here are different scenarios for jenkins installation

you can install Jenkins on server using Docker, Kubernetes, and server.

for installation you can visit Jenkins official website on following link-

##  [➡️ 👣](https://www.jenkins.io/doc/book/installing/kubernetes/)


Here I will go for Jenkins using Docker. It made simple for us to use our system's docker socket in Jenkins

Linux
Open up a terminal window.

Create a bridge network in Docker using the following docker network create command:
```
docker network create jenkins
```
In order to execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image using the following docker run command:
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

