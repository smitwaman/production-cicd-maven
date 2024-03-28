# Use a base image with Java and Maven pre-installed
FROM maven:3.8.4-jdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper files
COPY .mvn .mvn

# Copy the Maven project descriptor files
COPY pom.xml .

# Copy the source code
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Use the official Tomcat image as the base image for runtime
FROM tomcat:9.0.59-jdk11

# Copy the WAR file built in the previous stage to the webapps directory of Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/

# Expose the port on which Tomcat will run
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
