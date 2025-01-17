FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Run Maven build
RUN mvn clean package -DskipTests

# Second stage: Run the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file built by Maven into the container
COPY --from=build /app/target/employee-management-system.jar 

# Expose the port the app will run on (default for Spring Boot is 8080)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "employee-management-system.jar"]
