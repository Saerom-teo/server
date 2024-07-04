# Use an official Maven image to build the application
FROM maven:3.8.1-jdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn package -DskipTests

# Use an official Tomcat runtime as a parent image
FROM tomcat:9.0

# Copy the WAR file from the builder stage to the Tomcat webapps directory
COPY --from=builder /app/target/app-saeromteo.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
