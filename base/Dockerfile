FROM ubuntu:16.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# update system and install
# - base system packages
# - NDN core dependencies
# - NS-3 python bindings
RUN apt update -y && apt install -y \
		build-essential \
		git \
		libboost-all-dev \
		libcrypto++-dev \
		libsqlite3-0 \
		libsqlite3-dev \
		libssl-dev \
		ipython \
		openssl \
		pkg-config \
		python \
		python-dev \
		python-gnome2 \
		python-kiwi \
		python-pygoocanvas \
		python-pygraphviz \
		python-rsvg \
		python-setuptools \
		&& apt autoremove -y \
	 	&& rm -rf /var/lib/apt/lists/*

# create user
RUN useradd --create-home \
						--shell /bin/bash \
						--user-group \
						ndn

# RUN export uid=1000 gid=1000 && \
#    mkdir -p /home/ndn && \
#    mkdir -p /etc/sudoers.d/ && \
#    echo "ndn:x:${uid}:${gid}:ndn,,,:/home/ndn:/bin/bash" >> /etc/passwd && \
#    echo "ndn:x:${uid}:" >> /etc/group && \
#    echo "ndn ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ndn && \
#    chmod 0440 /etc/sudoers.d/ndn && \
#    chown ${uid}:${gid} -R /home/ndn
#RUN chpasswd && adduser ndn sudo

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
