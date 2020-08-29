FROM alpine/git
ARG url 
WORKDIR /app
RUN git clone ${url} 

RUN echo "GIT URL in docker file: ${url}"

FROM maven:3.5-jdk-8-alpine
ARG project-name 
RUN echo "Project name in docker file: ${project-name}"
WORKDIR /app
COPY --from=0 /app/${project-name} /app
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
ARG artifact-id
ARG version
RUN echo "Artifact id in docker file: ${artifact-id}"
RUN echo "Version id in docker file: ${version}"
ENV final-artifact ${artifact-id}-${version}.jar 
WORKDIR /app
COPY --from=1 /app/target/${final-artifact} /app

RUN echo "Final artifact in docker file: ${final-artifact}"