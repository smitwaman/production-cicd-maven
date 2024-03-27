Lets crete your ready app server with following prerequisites app
1. git
2. java
3. maven
4. helm
5. aws-cli
6. Docker
7. Docker compose
8. Docker swarm
9. terraform
10. boto3
11. pip3
12. tar
13. unzip
14. net-tools

We can install them manually as per requirement or use following script to install them

[For script link click here](install.sh)


1. **Create the script file:**
   

   ```bash
   nano install.sh
   ```

   This will open the `nano` text editor. Copy and paste the script provided in the previous response into this file.

   To save the file in `nano`, press `Ctrl` + `O`, then press `Enter` to confirm. To exit `nano`, press `Ctrl` + `X`.

2. **Make the script executable:**

   Before you can execute the script:

   ```bash
   chmod +x install.sh
   ```

   This command gives the script executable permissions.

3. **Execute the script:**

   To run the script and install the tools:

   ```bash
   ./install.sh
   ```
Finally our appserver ready with prerequisites tools
Now next Create GitHub repository and clone it to your appserver