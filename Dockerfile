
FROM alpine/git as clone (1)
WORKDIR /app
RUN git clone https://github.com/MaheshIare/docker-demo-repo.git

FROM maven:3.5-jdk-8-alpine as build (2)
WORKDIR /app
COPY --from=clone /app/docker-demo-app /app (3)

RUN mvn install -Dmaven.skip.test=true (4)