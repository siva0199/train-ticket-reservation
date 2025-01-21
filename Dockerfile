# Use Maven base image with OpenJDK 21
FROM maven:3.9-defaultjdk-21 AS build 

# Set the working directory in the container
WORKDIR /app

# Clone the GitHub repository into the container
RUN git clone https://github.com/siva0199/train-ticket-reservation.git .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:21-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the packaged jar from the build stage to the container
COPY --from=build /app/target/train-ticket-reservation-*.jar app.jar

# Expose the port your application runs on (e.g., 8080)
EXPOSE 8080

# Run the Java application
ENTRYPOINT ["java", "-jar", "app.jar"]
