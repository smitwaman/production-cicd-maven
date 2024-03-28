## Step 4 — Configure Sonar Server in Manage Jenkins

Sonar Setup
Nginx setup
Postgres setup


User Data Script:


```
#!/bin/bash

# Update system
sudo apt update -y

# Configure sysctl settings
sudo tee -a /etc/sysctl.conf > /dev/null <<EOT
vm.max_map_count=262144
fs.file-max=65536
ulimit -n 65536
ulimit -u 4096
EOT


# Install PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo apt install postgresql postgresql-contrib -y
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Configure PostgreSQL for SonarQube
sudo passwd postgres
sudo -u postgres createuser sonar
sudo -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED PASSWORD 'admin123';"
sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;"
```

```
#!/bin/bash
# Install Java 17 and unzip
sudo apt-get install openjdk-17-jdk -y
sudo apt-get install unzip -y
```

```
#!/bin/bash
# Download and configure SonarQube
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.3.0.82913.zip
sudo unzip sonarqube-10.3.0.82913.zip
sudo mv sonarqube-10.3.0.82913 /opt/sonarqube
sudo groupadd sonar
sudo useradd -d /opt/sonarqube -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube -R

# Download SonarQube Community Branch Plugin
cd /opt/sonarqube/extensions/plugins
sudo wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.18.0/sonarqube-community-branch-plugin-1.18.0.jar

# Configure sonar.properties
sudo tee -a /opt/sonarqube/conf/sonar.properties > /dev/null <<EOT
sonar.jdbc.username=sonar
sonar.jdbc.password=admin123
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
sonar.web.javaAdditionalOpts=-javaagent:/opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin-1.18.0.jar=web
sonar.ce.javaAdditionalOpts=-javaagent:/opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin-1.18.0.jar=ce
EOT

# Configure SonarQube as a service
sudo tee /etc/systemd/system/sonar.service > /dev/null <<EOT
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl enable sonar
sudo systemctl start sonar
sudo systemctl status sonar
```

```
# Install and configure Nginx
sudo apt-get install nginx -y
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default

sudo tee /etc/nginx/sites-available/sonarqube > /dev/null <<EOL
server {
    listen 80;
    server_name _;

    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;

    location / {
        proxy_pass http://localhost:9000;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL


sudo ln -s /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/sonarqube
sudo systemctl enable nginx.service
sudo systemctl restart nginx.service

# Configure firewall
sudo ufw enable
sudo ufw allow 22,80,9000,9001/tcp

echo "System reboot in 30 sec"
sleep 30
reboot

```



Grab the Public IP Address of your EC2 Instance, Sonarqube works on Port 9000, sp <Public IP>:9000. Goto your Sonarqube Server. Click on Administration → Security → Users → Click on Tokens and Update Token → Give it a name → and click on Generate Token



Click on Update Token



Copy this Token

Goto Dashboard → Manage Jenkins → Credentials → Add Secret Text. It should look like this



Now, go to Dashboard → Manage Jenkins → Configure System



Click on Apply and Save

The Configure System option is used in Jenkins to configure different server

Global Tool Configuration is used to configure different tools that we install using Plugins

We will install a sonar scanner in the tools.



Add Quality Gate in Sonarqube

click on Administration –> Configuration –> webhooks



Click on Create



Enter a URL like the below image



Let go to our Pipeline and add the Sonar-qube Stage in our Pipeline Script

```
stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Petclinic \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=Petclinic '''
                }
            }
        }
steps {
     steps {
         waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token' 
     }
}

#alternative Sonarqube Analysis
stage ('sonarqube Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'Sonar-token') {
                      sh 'mvn sonar:sonar'
                    }
                }
            }
        }

```
Click on Build now, you will see the stage view like this



To see the report, you can go to Sonarqube Server and go to Projects.



You can see the report has been generated and the status shows as passed. You can see that there are 15K lines. To see a detailed report, you can go to issues.
