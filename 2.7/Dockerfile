FROM emrevoid/ndnsim-os:ubuntu-16.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# utility env vars
ENV NDNSIM_PATH ${HOME}/ndnSIM
ENV NS3_PATH ${NDNSIM_PATH}/ns-3

# checking out to used build (ndnSIM v2.7)
WORKDIR ${NS3_PATH}
RUN git pull --all \
		&& git checkout b0fdcee5a94a2a48ecb58e1f35b8f89e7340f440
WORKDIR ${NDNSIM_PATH}/pybindgen
RUN git pull --all \
		&& git checkout 823d8b2b7dee470b930ab9ef5cddcd7defccd0fc
WORKDIR ${NS3_PATH}/src/ndnSIM/
RUN git pull --all \
		&& git submodule update --init \
		&& git checkout ndnSIM-2.7
WORKDIR ${NS3_PATH}/src/ndnSIM/NFD
RUN git checkout NFD-0.6.5-ndnSIM
WORKDIR ${NS3_PATH}/src/ndnSIM/ndn-cxx
RUN git checkout ndn-cxx-0.6.5-ndnSIM 

# prepare environment for ndnSIM
ENV PKG_CONFIG /usr/local/lib/pkgconfig:${NS3_PATH}/build/src/core
ENV LD_LIBRARY_PATH /usr/local/lib

# configuring, compiling and installing ndnSIM
WORKDIR ${NS3_PATH}
# optionally change visualizer default speed
#RUN sed -e 's/speed_adj = gtk.Adjustment(1.0/speed_adj = gtk.Adjustment(0.4/g' -i ./src/visualizer/visualizer/core.py
RUN	./waf configure \
		&& ./waf
USER root
RUN	./waf install
USER ndn
