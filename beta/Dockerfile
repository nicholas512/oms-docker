FROM ubuntu:19.04

ENV OMS_VERSION="3.6.28"
ENV Rserve_VERSION="1.8-6"
ENV Jep_VERSION="3.9.0"
ENV JAVA_VERSION="13"
ENV JAVA_HOME=/usr/lib/jvm/java-"$JAVA_VERSION"-openjdk-amd64/ \
      simulation=/work/simulation/Simulation.sim \
      LD_LIBRARY_PATH=/usr/local/lib/python2.7/dist-packages/jep \
      R_LIBS=/work/Rlibs/build/ \
      PYTHONPATH=$PYTHONPATH:/work/Pylibs/ \
      OMS_CONSOLE="oms-$OMS_VERSION-console" \
      TZ=US/Mountain

ARG VCS_REF

LABEL org.label-schema.license="MIT" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/sidereus3/oms-docker" \
      org.label-schema.vendor="OMSlab" \
      org.label-schema.OMS=$OMS_VERSION \
      maintainer="Francesco Serafin <francesco.serafin.3@gmail.com>"

MAINTAINER Francesco Serafin <francesco.serafin.3@gmail.com>, Olaf David <odavid@colostate.edu>

# copy OMS console, entrypoint.sh, packageParser.py and package.json into the container
COPY install.R ./
COPY $OMS_CONSOLE.zip entrypoint.sh ./
COPY rdep.R /usr/bin/
COPY bash_script/ ./bash_script/

RUN set -x \
        \
        && apt-get -y update \
        \
        # installation of required packages
        && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
            ca-certificates \
            wget \
            binutils \
            gcc \
            g++ \
            gfortran \
            make \
            unzip \
            python-dev \
            openjdk-"$JAVA_VERSION"-jdk \
            ant \
            python-pip \
            r-base \
            libblas-dev \
            liblapack-dev \
            libgdal-dev \
            libproj-dev \
            lynx \
            libssl-dev \
            libcurl4-gnutls-dev \
        \
        # install setuptools wheel and jep python packages
        && pip2 install setuptools \
        && pip2 install wheel \
        && pip2 install jep==$Jep_VERSION \
        \
        && chmod +x install.R \
        && ./install.R \
        # Rserve set up
        && wget https://www.rforge.net/Rserve/snapshot/Rserve_$Rserve_VERSION.tar.gz \
        && R CMD INSTALL Rserve_$Rserve_VERSION.tar.gz \
        && rm Rserve_$Rserve_VERSION.tar.gz \
        \
        # oms set up
        && unzip $OMS_CONSOLE.zip \
        && rm $OMS_CONSOLE.zip \
        && mkdir -p /root/.oms/$OMS_VERSION/ \
        && cp $OMS_CONSOLE/lib/cpptasks-1.0b6-od.jar /root/.oms/$OMS_VERSION/ \
        && cp $OMS_CONSOLE/lib/groovy-all-2.3.9.jar /root/.oms/$OMS_VERSION/ \
        && cp $OMS_CONSOLE/lib/jcommon-1.0.15.jar /root/.oms/$OMS_VERSION/ \
        && cp $OMS_CONSOLE/lib/jfreechart-1.0.12.jar /root/.oms/$OMS_VERSION/ \
        && cp $OMS_CONSOLE/lib/oms-all.jar /root/.oms/$OMS_VERSION/ \
        \
        && mkdir /work \
        && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
