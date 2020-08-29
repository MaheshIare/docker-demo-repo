FROM alpine/git
ARG url 
WORKDIR /app
RUN git clone ${url} 

FROM maven:3.5-jdk-8-alpine
ARG project-name 
WORKDIR /app
COPY --from=0 /app/${project} /app
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
ARG artifact-id
ARG version
ENV final-artifact ${artifact-id}-${version}.jar 
WORKDIR /app
COPY --from=1 /app/target/${final-artifact} /app

RUN echo "Artifact id: ${artifact-id}"
RUN echo "Project id: ${project}"
RUN echo "Version id: ${version}"
RUN echo "Final artifact: ${final-artifact}"