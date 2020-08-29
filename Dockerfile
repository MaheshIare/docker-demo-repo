FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/MaheshIare/docker-demo-repo.git

FROM maven:3.5-jdk-8-alpine
ENV projectid ${project}
WORKDIR /app
COPY --from=0 /app/docker-demo-repo /app
RUN mvn install -Dmaven.skip.test=true

FROM openjdk:8-jre-alpine
ENV artifactidid ${artifactid}
ENV versionid ${version}
WORKDIR /app
COPY --from=1 /app/target/docker-demo-repo-0.0.1.jar /app

RUN echo "Artifact id: ${artifactidid}"
RUN echo "Version: ${versionid}"
RUN echo "project: ${projectid}"
