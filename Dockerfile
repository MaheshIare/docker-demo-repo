POM_VERSION=$(mvn -q help:evaluate -Dexpression=project.version -DforceStdout=true)
RUN echo "POM Version: $POM_VERSION"
RUN echo "parent pom version: ${parent.version}"

FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/MaheshIare/docker-demo-repo.git

FROM maven:3.5-jdk-8-alpine
ARG project 
WORKDIR /app
COPY --from=0 /app/${project} /app
RUN mvn install -Dmaven.skip.test=true

FROM openjdk:8-jre-alpine
ARG artifactid
ARG version 
WORKDIR /app
COPY --from=1 /app/target/${artifactid}-${POM_VERSION}.jar /app