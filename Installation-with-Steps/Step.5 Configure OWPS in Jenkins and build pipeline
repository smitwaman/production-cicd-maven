Step 5 — Install OWASP Dependency Check Plugins

GotoDashboard → Manage Jenkins → Plugins → OWASP Dependency-Check. Click on it and install it without restarting.



First, we configured the Plugin and next, we had to configure the Tool

Goto Dashboard → Manage Jenkins → Tools →



Click on Apply and Save here.

Now go configure → Pipeline and add this stage to your pipeline

```
stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

stage("Build"){ steps{ sh " mvn clean install" } } 
```
The final pipeline would look like this,

```
pipeline {
    agent any     
    tools{
        jdk 'jdk17'
        maven 'maven3'
    } 
     environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages{
        stage("Git Checkout"){
            steps{
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/smitwaman/Production-pipeline.git'
            }
        }
        stage("Compile"){
            steps{
                sh "mvn clean compile"
            }
        }  
         stage("Test Cases"){
            steps{
                sh "mvn test"
            }
        } 
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=sonar \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=sonar '''
                }
            }
        }
        stage("Build"){
            steps{
                sh " mvn clean install"
            }
        }

       stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

    } 
} 
```

The stage view would look like this,



You will see that in status, a graph will also be generated


