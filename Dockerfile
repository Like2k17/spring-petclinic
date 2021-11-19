FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install git

RUN apt-get -y install openjdk-11-jre-headless
RUN apt-get -y install openjdk-11-jdk-headless
RUN apt-get -y install maven

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw/ pom.xml/ ./

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]
EXPOSE 8080
