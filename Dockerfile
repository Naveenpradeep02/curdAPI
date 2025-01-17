# Use a base image with Maven and JDK 17 for building the app
FROM maven:3.8.5-openjdk-17 AS build

# Copy the project files into the container
COPY . /app

# Set the working directory in the container
WORKDIR /app

# Build the Spring Boot application without running tests
RUN mvn clean package -DskipTests

# Use OpenJDK 11 as the base image for running the application
FROM openjdk:11-jre-slim

# Set the working directory for the application
WORKDIR /app

# Copy the built JAR file from the build stage to the current working directory
COPY --from=build /app/target/employee-management-system.jar /app/employee-management-system.jar

# Expose the port the app will run on (default for Spring Boot is 8080)
EXPOSE 8080

# Run the application using the JAR file
CMD ["java", "-jar", "employee-management-system.jar"]
