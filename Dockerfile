FROM maven:3.9.9-eclipse-temurin-23 AS build

ADD . /home/project
RUN mvn -f /home/project/pom.xml clean package -DskipTests

FROM eclipse-temurin:23-jre

EXPOSE 8080/tcp

ARG JAR_FILE=/home/project/target/*.war
COPY --from=build ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar","/app.jar"]
