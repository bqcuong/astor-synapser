FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# install required softwares
RUN apt update \
    && apt install -y wget curl git python vim unzip bzip2 xz-utils \
    openjdk-8-jdk \
    openssh-client patch build-essential
    
COPY jdk-7u80-linux-x64.tar.gz /tmp/jdk-7u80-linux-x64.tar.gz
RUN tar xvzf /tmp/jdk-7u80-linux-x64.tar.gz -C /tmp/
RUN mv /tmp/jdk1.7.0_80 /usr/lib/jvm/jdk1.7.0_80/

ENV JAVA7_HOME /usr/lib/jvm/jdk1.7.0_80
ENV JAVA8_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /opt/astor
COPY astor.jar /opt/astor
COPY astor.sh /opt/astor
COPY jtestex7.jar /opt/astor
