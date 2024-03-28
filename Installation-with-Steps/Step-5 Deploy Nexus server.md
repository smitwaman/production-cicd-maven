Deploy Nexus server or install Nexus on EC2 using Userdata or script directly.

## Installation of Nexus application on server.


User Data Script:

```
#!/bin/bash
yum install java-1.8.0-openjdk.x86_64 wget -y   
mkdir -p /opt/nexus/   
mkdir -p /tmp/nexus/                           
cd /tmp/nexus/
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O nexus.tar.gz
sleep 10
EXTOUT=`tar xzvf nexus.tar.gz`
NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
sleep 5
rm -rf /tmp/nexus/nexus.tar.gz
cp -r /tmp/nexus/* /opt/nexus/
sleep 5
useradd nexus
chown -R nexus.nexus /opt/nexus 
cat <<EOT>> /etc/systemd/system/nexus.service
[Unit]                                                                          
Description=nexus service                                                       
After=network.target                                                            
                                                                  
[Service]                                                                       
Type=forking                                                                    
LimitNOFILE=65536                                                               
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start                                  
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop                                    
User=nexus                                                                      
Restart=on-abort                                                                
                                                                  
[Install]                                                                       
WantedBy=multi-user.target                                                      

EOT

echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
systemctl daemon-reload
systemctl start nexus
systemctl enable nexus

```


Here, is post installation activity after successful installation of Nexus on Nexus server.

Now we would do the post installation steps for Nexus. First we need to SSH into the nexus server to confirm the service is running.


The next step is to access the web interface for Nexus. Open your web browser and navigate to the Nexus web interface. Typically, Nexus Repository Manager employs port 8081. So the url would take this format;
```
http://nexus_server_ip:8081

```
Upon navigating to the Nexus web interface, locate and select the “Sign In” option. Here, you’ll be prompted to enter the admin password, which is conveniently stored in a specific file path displayed on the Nexus sign-in dashboard. Execute the following command on your Nexus server terminal to access this password:

```
sudo cat /opt/nexus/sonatype-work/nexus3/admin.password 

```
Copy the password from the terminal output, and paste it into the provided box on the Nexus sign-in page. Subsequently, click on “Sign In.”




Upon successful sign-in, you will be prompted to create a new password for heightened security. For simplicity and modularity within your pipeline code, consider using a password like “admin123.” Follow these steps:

Enter the copied password or the one you’ve chosen into the appropriate field.
Click on “Sign In.”
Now, create a new password when prompted. Make sure to note this password for future use.
Choose the radio button for “Disable anonymous access” to enhance security.
Click on “Finish” to complete the initial setup.
From our architecture, we are going to upload artifacts to nexus and also download dependencies from nexus. So the next step is to create the repositories where the nexus server will upload the artifact to. To do this;

Access Nexus Web Interface:

Navigate to the Nexus web interface.
Click on the settings icon, usually represented as a gear or wrench, in the top-right corner.
Navigate to Repositories Section:
In the left navigation pane, select “Repositories.”


Create Maven2 (Hosted) Repository for Artifacts:

Click on “Create repository.”
Choose the repository format as “maven2 (hosted).”
Set a unique name, for example, “vprofile-release.”
Leave other settings as default.
Click “Create repository.”


Create Maven2 (Hosted) Repository for Snapshots:

Follow the same steps as above but create another “maven2 (hosted)” repository.
Name it, for instance, “vprofile-snapshots.”
Change version policy to Snapshot.
Leave other settings as default.
Click “Create repository.”


Create Maven2 (Proxy) Repository for Dependencies:

Once again, click on “Create repository.”
Select the repository format as “maven2 (proxy).”
Choose a distinct name like “vpro-maven-central”
Specify the Remote Storage Location (URL of the Maven repository from which dependencies will be proxied).
Leave other settings as default.
Click “Create repository.”


Create Maven2 (Group) Repository:

For the group repository that combines all three types, click on “Create repository.”
This time, select the repository format as “maven2 (group).”
Assign a name like “vpro-maven-group.”
Include the previously created hosted and proxy repositories in the “Member repositories” section.
Leave other settings as default.
Click “Create repository.”




By following these steps, we’ve created the necessary repositories in Nexus for storing artifacts, handling snapshots, downloading dependencies, and grouping them together. Note down the names of each repository as you’ll use them in your pipeline code for integration with Nexus.





