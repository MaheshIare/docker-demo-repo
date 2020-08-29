FROM alpine/git
ARG giturl 
WORKDIR /app
RUN git clone ${giturl} 
RUN echo "GIT URL in docker file: ${giturl}"

FROM maven:3.5-jdk-8-alpine
ARG projectname 
RUN echo "Project name in docker file: ${projectname}"
WORKDIR /app
COPY --from=0 /app/${projectname} /app
ENV VERSION $(mvn -q help:evaluate -Dexpression=project.version -DforceStdout=true)
RUN echo "POM Version: ${VERSION}"
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
ARG artifactid
RUN echo "Artifact id in docker file: ${artifactid}"
RUN echo "Version id in docker file: ${VERSION}"
ENV finalartifact ${artifactid}-${VERSION}.jar 
WORKDIR /app
COPY --from=1 /app/target/${finalartifact} /app

RUN echo "Final artifact in docker file: ${finalartifact}"