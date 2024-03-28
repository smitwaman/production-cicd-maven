## Lets configure SMTP mail server in your Jenkins for email notification.

Configuring mail server in Jenkins ( Gmail )
Install Email Extension Plugin in Jenkins

Once the plugin is installed in Jenkins, click on manage Jenkins –> configure system there under the E-mail Notification section configure the details as shown in the below image



This is to just verify the mail configuration

Now under the Extended E-mail Notification section configure the details as shown in the below images







By using the below code I can send customized mail.

```
post {
     always {
        emailext attachLog: true,
            subject: "'${currentBuild.result}'",
            body: "Project: ${env.JOB_NAME}<br/>" +
                "Build Number: ${env.BUILD_NUMBER}<br/>" +
                "URL: ${env.BUILD_URL}<br/>",
            to: 'sparx531@gmail.com',   #change mail here
            attachmentsPattern: 'trivy.txt'
        }
    }

