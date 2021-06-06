#
# Build stage
#
FROM maven:3.6.3-jdk-11-slim AS build

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml install -Dquarkus.package.uber-jar=true -DskipTests=true

#
# Package stage
#

FROM openjdk:11-jre-slim

COPY --from=build /home/app/target/rules-show-and-tell-1.0-SNAPSHOT-runner.jar /usr/local/lib/rules-show-and-tell-1.0-SNAPSHOT-runner.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/rules-show-and-tell-1.0-SNAPSHOT-runner.jar"]
EXPOSE 8080
