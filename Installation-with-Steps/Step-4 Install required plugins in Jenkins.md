
Step 4

1. Install necessery Plugins
2. Add tokens in Jenkins required for API.
   - git
   - docker
   - sonar
   - kubernetes
3. Configure all necesery slave servers and server in Jenkins for pipeline if necessery for your cofiguration.
   - Jenkins-slave
   - Docker
   - Kubernetes
   - Argocd
   - SMTP for gmail
 
4.1 — Install Plugin

Goto Manage Jenkins →Plugins → Available Plugins →

Install below plugins
1. Docker
2. maven
3. pipeline 





4B — Configure Java and Maven in Global Tool Configuration

Goto Manage Jenkins → Tools → Install JDK and Maven3 → Click on Apply and Save



4C — Create a Job

Label it as Real-World CI-CD, click on Pipeline and OK.



Enter this in Pipeline Script,

```
pipeline {
    agent any 
    tools{
        jdk 'jdk17'
        maven 'maven3'
    }
     stages{
        stage("Git Checkout"){
            steps{
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/Aj7Ay/Petclinic.git'
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
     }
}
The stage view would look like this,
```

