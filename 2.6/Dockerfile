FROM emrevoid/ndnsim:base

LABEL mantainer="Casadei Andrea <andrea.casadei22@studio.unibo.it>, Margotta Fabrizio <fabrizio.margotta@studio.unibo.it>"

# utility env vars
ENV NDNSIM_PATH ${HOME}/ndnSIM
ENV NS3_PATH ${NDNSIM_PATH}/ns-3

# checking out to used build (ndnSIM v2.6)
WORKDIR ${NS3_PATH}
RUN git pull --all \
		&& git checkout ndnSIM-v2.6
WORKDIR ${NDNSIM_PATH}/pybindgen
RUN git pull --all \
		&& git checkout ef30ba23dd23afe41aef5bc9aced71c112ccc22e
WORKDIR ${NS3_PATH}/src/ndnSIM/
RUN git pull --all \
		&& git submodule update --init \
		&& git checkout 6028c61c25764311b625eae21153ae7149859720
WORKDIR ${NS3_PATH}/src/ndnSIM/NFD
RUN git checkout 0a30676920b9d3f2b2c8bc68e583befc415210cc
WORKDIR ${NS3_PATH}/src/ndnSIM/ndn-cxx
RUN git checkout c37bf1633828ef6b69646a4989a9cef855e08248

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
