FROM bqcuongas/java:latest

# install required softwares
RUN apt update \
    && apt install -y wget curl vim zsh patch \
    unzip bzip2 xz-utils \
    git \
    python3 python3-pip \
    maven
    
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
    
COPY ./ /opt/astor
WORKDIR /opt/astor

ENV SYNAPSER_PLUGIN_PATH /opt/astor
