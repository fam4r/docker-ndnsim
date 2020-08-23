FROM emrevoid/ndnsim-os:ubuntu-20.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# utility env vars
ENV NDNSIM_PATH ${HOME}/ndnSIM
ENV NS3_PATH ${NDNSIM_PATH}/ns-3

# checking out to used build
WORKDIR ${NS3_PATH}
RUN git pull --all \
		&& git checkout 173aec9e080c71e75cca67fb3088834a52f4956a
WORKDIR ${NDNSIM_PATH}/pybindgen
RUN git pull --all \
		&& git checkout 572e1d92d9d0388de86b73d1ee37a10d0b0b633a
WORKDIR ${NS3_PATH}/src/ndnSIM/
RUN git pull --all \
		&& git submodule update --init \
		&& git checkout ndnSIM-2.8
WORKDIR ${NS3_PATH}/src/ndnSIM/NFD
RUN git checkout NFD-0.7.0-ndnSIM
WORKDIR ${NS3_PATH}/src/ndnSIM/ndn-cxx
RUN git checkout ndn-cxx-0.7.0-ndnSIM

# prepare environment for ndnSIM
ENV PKG_CONFIG /usr/local/lib/pkgconfig:${NS3_PATH}/build/src/core
ENV LD_LIBRARY_PATH /usr/local/lib

# configuring, compiling and installing ndnSIM
WORKDIR ${NS3_PATH}
# optionally change visualizer default speed
#RUN sed -e 's/speed_adj = gtk.Adjustment(1.0/speed_adj = gtk.Adjustment(0.4/g' -i ./src/visualizer/visualizer/core.py
RUN	./waf configure -d optimized \
		&& ./waf
USER root
RUN	./waf install
USER ndn
