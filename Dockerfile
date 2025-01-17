# Use a base image with JDK 17 for the build stage
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project to the /app directory in the container
COPY . .

# Run Maven build to create the JAR file
RUN mvn clean package -DskipTests

# Start a new stage with OpenJDK 11 runtime image
FROM openjdk:11-jre-slim

# Set the working directory in the final image
WORKDIR /app

# Copy the JAR file from the build stage
# Assuming the JAR file is located in the target directory after Maven build
COPY --from=build /app/target/employee-management-system-*.jar /app/employee-management-system.jar

# Expose the port on which the Spring Boot app will run
EXPOSE 8080

# Command to run the Spring Boot app
CMD ["java", "-jar", "employee-management-system.jar"]
