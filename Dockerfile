# Use a lightweight Java runtime as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file to the container
COPY target/springboot-backend-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the application listens on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
