FROM ubuntu:20.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

ENV DEBIAN_FRONTEND=noninteractive

# update system and install
# - base system packages
# - NDN core dependencies
# - NS-3 python bindings
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime \
    && apt update -y && apt install -y \
        build-essential \
        castxml \
        gir1.2-goocanvas-2.0 \
        gir1.2-gtk-3.0 \
        git \
        libboost-all-dev \
        libgirepository1.0-dev \
        libsqlite3-dev \
        libssl-dev \
        python3-dev \
        python3-gi \
        python3-gi-cairo \
        python3-pip \
        python3-pygccxml \
        python3-pygraphviz \
        python3-setuptools \
        && pip3 install kiwi \
        && apt autoremove -y \
        && rm -rf /var/lib/apt/lists/*

# create user
RUN useradd --create-home \
			--shell /bin/bash \
			--user-group \
			ndn

USER ndn
ENV HOME /home/ndn

# utility env vars
ENV NDNSIM_PATH ${HOME}/ndnSIM
ENV NS3_PATH ${NDNSIM_PATH}/ns-3

# clone ns-3 pybindgen ndnSIM
RUN mkdir -p ${NDNSIM_PATH}
WORKDIR ${NDNSIM_PATH}
RUN git clone https://github.com/named-data-ndnSIM/ns-3-dev.git ns-3 && \
    git clone https://github.com/named-data-ndnSIM/pybindgen.git pybindgen && \
    git clone --recursive https://github.com/named-data-ndnSIM/ndnSIM.git ns-3/src/ndnSIM
