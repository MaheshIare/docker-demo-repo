
FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/MaheshIare/docker-demo-repo.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/docker-demo-repo /app
RUN mvn install -Dmaven.skip.test=true

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=1 /app/target/${project.artifactId}-${project.version}.jar /app