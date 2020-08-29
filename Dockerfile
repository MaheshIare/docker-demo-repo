
FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/docker-demo-repo /app (2)

RUN mvn clean install -Dmaven.skip.test=true(3)