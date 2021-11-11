FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install git

RUN apt-get -y install openjdk-11-jre-headless
RUN apt-get -y install openjdk-11-jdk-headless
RUN apt-get -y install maven
#RUN git clone https://github.com/spring-projects/spring-petclinic.git

WORKDIR /app

COPY /spring-petclinic/.mvn/ .mvn
COPY /spring-petclinic/mvnw/ /spring-petclinic/pom.xml/ ./

COPY /spring-petclinic/src ./src

CMD ["./mvnw", "spring-boot:run"]
