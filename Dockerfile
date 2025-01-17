# Use a base image with JDK 17 (or your preferred version)
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the build stage
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Build the project (skip tests for now)
RUN mvn clean package -DskipTests

# Use a lighter base image with JRE for running the app
FROM openjdk:11-jre-slim

# Set the working directory for the runtime stage
WORKDIR /app

# Copy the JAR file built by Maven from the build stage
COPY --from=build /app/target/employee-management-system.jar /app/employee-management-system.jar

# Expose port 8080 to allow access to the application
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "/app/employee-management-system.jar"]
