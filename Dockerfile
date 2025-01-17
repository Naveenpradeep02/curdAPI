# Use a base image with JDK 11 (or any version you prefer)
FROM Maven:3.8.5-openjdk-17 As build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the JAR file built by Maven/Gradle into the container
COPY --from=build /target/employee-management-system.jar /app/employee-management-system.jar

# # Expose the port the app will run on (default for Spring Boot is 8080)
EXPOSE 8080

# # Run the application
CMD ["java", "-jar", "employee-management-system.jar"]
