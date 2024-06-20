# Build a JAR File
FROM maven:3.8.2-jdk-17-slim AS stage1
WORKDIR /home/app
COPY . /home/app/
RUN mvn -f /home/app/pom.xml clean package

# Create an Image
FROM openjdk:17-jdk-alpine
EXPOSE 3000
COPY --from=stage1 /home/app/target/simpliearn-devops-project.jar simpliearn-devops-project.jar
ENTRYPOINT ["sh", "-c", "java -jar /simpliearn-devops-project.jar"]
