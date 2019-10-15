#!/bin/bash

set -o nounset

set -o errexit

abort() {
    echo "ERROR: problems running the OMS project";
    exit 1
}

cd work/

trap 'abort' 0 INT TERM
/usr/lib/jvm/java-8-openjdk-amd64/bin/java -Xmx12288M \
    -Doms3.work=/work \
    -cp ".:/root/.oms/$OMS_VERSION/*:lib/*:dist/*" oms3.CLI \
    -l $2 -r $1
trap : 0 INT TERM

cd ..

exit
