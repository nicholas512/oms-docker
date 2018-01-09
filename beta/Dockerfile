FROM ubuntu:zesty

MAINTAINER Francesco Serafin <francesco.serafin.3@gmail.com>, Olaf David <odavid@colostate.edu>

ENV OMS_VERSION="3.5.39"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ \
      simulation=/work/simulation/Simulation.sim \
      LD_LIBRARY_PATH=/usr/local/lib/python2.7/dist-packages/jep \
      R_LIBS=/work/Rlibs/build/ OMS_CONSOLE="oms-$OMS_VERSION-console"

# copy OMS console, entrypoint.sh, packageParser.py and package.json into the container
COPY $OMS_CONSOLE.zip entrypoint.sh packageParser.py package.json ./
COPY bash_script/ ./bash_script/

RUN set -x \
        \
        && apt-get -y update \
        \
        # installation of required packages
        && apt-get install --no-install-recommends -y \
            ca-certificates \
            wget \
            binutils \
            gcc \
            g++ \
            gfortran \
            make \
            unzip \
            python-dev \
            openjdk-8-jdk \
            ant \
            python-pip \
            r-base \
            libblas-dev \
            liblapack-dev \
            libgdal-dev \
            libproj-dev \
            lynx \
            libssl-dev \
        \
        # install setuptools wheel and jep python packages
        && pip2 install setuptools \
        && pip2 install wheel \
        && pip2 install jep==3.6.4 \
        \
        # get latest version of Rserve and Rcpp, then install them
        && CRAN="https://cran.r-project.org/src/contrib/" \
        && RSERVE=$( lynx -dump -listonly "${CRAN}" | awk '{print $2}' | sed -n '/\/Rserve_/p' ) \
        && wget $RSERVE \
        && RCPP=$( lynx -dump -listonly "${CRAN}" | awk '{print $2}' | sed -n '/\/Rcpp_/p' ) \
        && wget $RCPP \
        && R CMD INSTALL Rserve_*.tar.gz \
        && R CMD INSTALL Rcpp_*.tar.gz \
        && rm Rserve_*.tar.gz Rcpp_*.tar.gz \
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
