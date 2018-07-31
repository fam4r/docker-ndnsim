FROM ubuntu:16.04

# update system
RUN apt update -y && apt upgrade -y && apt autoremove -y

# base system packages
RUN apt install -y wget curl git vim-gnome tar sudo

# NDN core dependencies
RUN apt install -y python python-setuptools build-essential libsqlite3-dev libcrypto++-dev libboost-all-dev libssl-dev libsqlite3-0 openssl pkg-config

# NS-3 python bindings
RUN apt install -y python-dev python-pygraphviz python-kiwi python-pygoocanvas python-gnome2 python-rsvg ipython

# create user
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

COPY .bashrc /home/ndn
COPY .vimrc /home/ndn

# clone ndnSIM
RUN cd /home/ndn/ && \
    mkdir ndnSIM && \
    cd ndnSIM && \
    git clone https://github.com/named-data-ndnSIM/ns-3-dev.git ns-3 && \
    git clone https://github.com/named-data-ndnSIM/pybindgen.git pybindgen && \
    git clone --recursive https://github.com/named-data-ndnSIM/ndnSIM.git ns-3/src/ndnSIM

# checkout to a working build
# RUN cd /home/ndn/ndnSIM/ns-3/src/ndnSIM && \
#    git checkout 8821d3e61095407b7f59f374e203eeb3b04c62f5 && \
#    cd /home/ndn/ndnSIM

# compiling and running
RUN cd /home/ndn/ndnSIM/ns-3/ && ./waf configure --enable-examples --enable-tests
RUN cd /home/ndn/ndnSIM/ns-3/ && ./waf
RUN cd /home/ndn/ndnSIM/ns-3/ && sudo ./waf install