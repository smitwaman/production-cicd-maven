Step 2 — Install Jenkins, Docker and Trivy

## 2A — To Install Jenkins

Connect to your console, and enter these commands to Install Jenkins.

```
sudo vi jenkins.sh # or use userdata 
```


```
sudo apt-get update

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install openjdk-17-jdk -y
sudo apt install openjdk-17-jre -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
#save and exit
sudo chmod 777 jenkins.sh
./jenkins.sh
```


Once Jenkins is installed, you will need to go to your AWS EC2 Security Group and open Inbound Port 8080, since Jenkins works on Port 8080.



Now, grab your Public IP Address


<EC2 Public IP Address:8080>


sudo cat /var/lib/jenkins/secrets/initialAdminPassword


Unlock Jenkins using an administrative password and install the required plugins.



Jenkins will now get installed and install all the libraries.



Jenkins Getting Started Screen



## 2B — Install Docker

```
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
sudo chmod 777 /var/run/docker.sock 
sudo docker ps

```
After the docker installation, we create a sonarqube container (Remember added 9000 port in the security group)

```

docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

```


```
username admin
password admin

```



## 2C — Install Trivy

```
vi trivy.sh

```


#Enter these
```
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y
#SAVE AND EXIt
sudo chmod 777 trivy.sh
./trivy.sh

```
Next, we will log in to Jenkins and start to configure our Pipeline in Jenkins
