# Use official Tomcat image as base
FROM tomcat:9.0-jdk8

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy war file to Tomcat webapps directory
COPY target/blog-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
