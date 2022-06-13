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

# pre-install synapser
ENV SYNAPSER_PLUGIN_PATH /opt/astor
RUN apt-get install -y git curl
RUN cd /tmp; git clone https://github.com/epicosy/synapser
RUN cd /tmp/synapser; ./install_py38.sh; ./install.sh
