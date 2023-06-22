# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages (Java, Gradle, etc.)
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk gradle

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle build files to the container
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
COPY gradle ./gradle

# Download and install the Gradle wrapper
RUN ./gradlew wrapper

# Copy the source code to the container
COPY src ./src

# Build the JAR file
RUN ./gradlew build

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "build/libs/my-app-1.0-SNAPSHOT.jar"]

