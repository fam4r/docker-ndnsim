FROM ubuntu:16.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# update system and install base system packages
RUN apt update -y && apt install -y \
		curl \
		git \
		sudo \
		tar \
		vim-gnome \
		wget && \
	apt autoremove -y

# update system and install NDN core dependencies
RUN apt update -y && apt install -y \
		build-essential \
		libboost-all-dev \
		libcrypto++-dev \
		libsqlite3-0 \
		libsqlite3-dev \
		libssl-dev \
		openssl \
		pkg-config \
		python \
		python-setuptools && \
	apt autoremove -y

# update system and install NS-3 python bindings
RUN apt update -y && apt install -y \
		ipython \
		python-dev \
		python-gnome2 \
		python-kiwi \
		python-pygoocanvas \
		python-pygraphviz \
		python-rsvg && \
	apt autoremove -y

# create user and add little configs
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ndn && \
    mkdir -p /etc/sudoers.d/ && \
    echo "ndn:x:${uid}:${gid}:ndn,,,:/home/ndn:/bin/bash" >> /etc/passwd && \
    echo "ndn:x:${uid}:" >> /etc/group && \
    echo "ndn ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ndn && \
    chmod 0440 /etc/sudoers.d/ndn && \
    chown ${uid}:${gid} -R /home/ndn

RUN chpasswd && adduser ndn sudo

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

# checking out to used build (ndnSIM v2.5)
WORKDIR ${NS3_PATH}
RUN git checkout 05158549275e897c7d17922bdeada483b2b8ab11
WORKDIR ${NDNSIM_PATH}/pybindgen
RUN git checkout 0466ae3508076ccfb803a16c0eeffc2ed3fc32c3
WORKDIR ${NS3_PATH}/src/ndnSIM/
RUN git checkout 65c490630e1a2e9cdebaf505de8729838c000821
WORKDIR ${NS3_PATH}/src/ndnSIM/NFD
RUN git checkout 3bebd1190b1c45f8acaa0fe1d3a3100651a062e4
WORKDIR ${NS3_PATH}/src/ndnSIM/ndn-cxx
RUN git checkout e1ae096efd8ad503ce7dbd616ee174afaed6c66b

# prepare environment for ndnSIM
ENV PKG_CONFIG /usr/local/lib/pkgconfig:${NS3_PATH}/build/src/core
ENV LD_LIBRARY_PATH /usr/local/lib

# configuring, compiling and installing ndnSIM
WORKDIR ${NS3_PATH}
# optionally change visualizer default speed
#RUN sed -e 's/speed_adj = gtk.Adjustment(1.0/speed_adj = gtk.Adjustment(0.4/g' -i ./src/visualizer/visualizer/core.py
RUN	./waf configure && \
	./waf && \
	sudo ./waf install
