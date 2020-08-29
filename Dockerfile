FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/MaheshIare/docker-demo-repo.git

FROM maven:3.5-jdk-8-alpine
ARG project 
WORKDIR /app
COPY --from=0 /app/${project} /app
RUN mvn install -Dmaven.skip.test=true

RUN echo "parent pom version: ${parent.version}"
RUN echo "parent artifact id : ${parent.artifactId}"

FROM openjdk:8-jre-alpine
ARG artifactid
WORKDIR /app
COPY --from=1 /app/target/${artifactid}-${parent.version}.jar /app