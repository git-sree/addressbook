# Stage 1: Build the application using maven
FROM maven:3.8.4-openjdk-11-slim AS build-app

WORKDIR /app

copy pom.xml .

copy src ./src

run mvn clean package

# Stage 2: Deploy application into tomcat
FROM tomcat:8.5.78-jdk11-openjdk-slim

COPY --from=build-app /app/target/*.war /usr/local/tomcat/webapps/

expose 8080

CMD ["catalina.sh", "run"]
