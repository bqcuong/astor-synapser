FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# install required softwares
RUN apt update \
    && apt install -y wget curl git python vim unzip bzip2 xz-utils \
    openjdk-8-jdk \
    openssh-client patch build-essential
    
COPY ./ /opt/astor
WORKDIR /opt/astor

RUN tar xvzf jdk-7u80-linux-x64.tar.gz -C /tmp/
RUN mv /tmp/jdk1.7.0_80 /usr/lib/jvm/jdk1.7.0_80/
RUN rm jdk-7u80-linux-x64.tar.gz

ENV JAVA7_HOME /usr/lib/jvm/jdk1.7.0_80
ENV JAVA8_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV SYNAPSER_PLUGIN_PATH /opt/astor