FROM ubuntu:zesty

MAINTAINER Francesco Serafin <francesco.serafin.3@gmail.com>, Olaf David <odavid@colostate.edu>

COPY oms-3.5.26-console.zip entrypoint.sh ./

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV simulation /work/simulation/Simulation.sim
ENV LD_LIBRARY_PATH /usr/local/lib/python2.7/dist-packages/jep

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
            make \
            unzip \
            python-dev \
            openjdk-8-jdk \
            ant \
            python-pip \
        \
        && pip2 install setuptools \
        && pip2 install wheel \
        && pip2 install jep==3.6.4 \
        && unzip oms-3.5.26-console.zip \
        && rm oms-3.5.26-console.zip \
        && mkdir -p /root/.oms/3.5.26/ \
        && cp oms-3.5.26-console/lib/cpptasks-1.0b6-od.jar /root/.oms/3.5.26/ \
        && cp oms-3.5.26-console/lib/groovy-all-2.3.9.jar /root/.oms/3.5.26/ \
        && cp oms-3.5.26-console/lib/jcommon-1.0.15.jar /root/.oms/3.5.26/ \
        && cp oms-3.5.26-console/lib/jfreechart-1.0.12.jar /root/.oms/3.5.26/ \
        && cp oms-3.5.26-console/lib/oms-all.jar /root/.oms/3.5.26/ \
        && apt-get -y remove --purge \
            wget \
            binutils \
            gcc \
            make \
            unzip \
            python-pip \
        && apt-get -y autoremove --purge \
        && mkdir /work \
        && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
