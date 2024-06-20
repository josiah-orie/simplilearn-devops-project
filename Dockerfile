## Build a JAR File
#FROM maven:3.8.2-jdk-8-slim AS stage1
#WORKDIR /app
#COPY . /app/
#RUN mvn -f /app/pom.xml clean package
#
#
## Use an official OpenJDK runtime as a parent image
#FROM openjdk:17-jdk-alpine
#
## Set the working directory in the container
#WORKDIR /app
#
## Copy the application's JAR file to the container
#COPY target/simpliearn-devops-project.jar /app/simpliearn-devops-project.jar
#
## Make port 8080 available to the world outside this container
#EXPOSE 3000
#
## Run the JAR file
#ENTRYPOINT ["java", "-jar", "/app/simpliearn-devops-project.jar"]

# Build a JAR File
#FROM maven:3.9-sapmachine-17 AS stage1
#WORKDIR /home/app
#COPY . /home/app/
#RUN mvn -f /home/app/pom.xml clean package
#
## Create an Image
#FROM openjdk:17-jdk-alpine
#EXPOSE 3000
#COPY --from=stage1 /home/app/target/simpliearn-devops-project.jar simpliearn-devops-project.jar
#ENTRYPOINT ["sh", "-c", "java -jar /hsimpliearn-devops-project.jar"]

# Use an official Maven image to build the project
FROM maven:3.9-sapmachine-17 AS build

# Set the working directory
WORKDIR /home/app

# Copy the pom.xml and any other necessary files
COPY pom.xml /home/app/

# Download dependencies (this step will be cached by Docker)
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY src /home/app/src

# Build the application
RUN mvn clean package

# Use a lightweight JDK image to run the application
FROM openjdk:17-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /home/app/target/simpliearn-devops-project-0.0.1-SNAPSHOT.jar /app/simpliearn-devops-project-0.0.1-SNAPSHOT.jar

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/simpliearn-devops-project-0.0.1-SNAPSHOT.jar"]
