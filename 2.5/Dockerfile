FROM emrevoid/ndnsim-os:ubuntu-16.04

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# utility env vars
ENV NDNSIM_PATH ${HOME}/ndnSIM
ENV NS3_PATH ${NDNSIM_PATH}/ns-3

WORKDIR ${NS3_PATH}/src/ndnSIM
RUN git submodule update --init

# checking out to used build (ndnSIM v2.5)
WORKDIR ${NS3_PATH}
RUN git pull --all \
		&& git checkout ndnSIM-v2.5
WORKDIR ${NDNSIM_PATH}/pybindgen
RUN git pull --all \
		&& git checkout 0466ae3508076ccfb803a16c0eeffc2ed3fc32c3
WORKDIR ${NS3_PATH}/src/ndnSIM/
RUN git pull --all \
		&& git submodule update --init \
		&& git checkout 65c490630e1a2e9cdebaf505de8729838c000821
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
RUN	./waf configure \
		&& ./waf
USER root
RUN ./waf install
USER ndn
