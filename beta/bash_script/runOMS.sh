#!/bin/bash

set -o nounset

set -o errexit

abort() {
    echo "ERROR: problems running the OMS project";
    exit 1
}

cd work/

trap 'abort' 0 INT TERM
java -Xmx12288M \
    -Doms3.work=/work \
    -cp ".:/root/.oms/$OMS_VERSION/oms-all.jar:lib/*:dist/*" oms3.CLI \
    -r $1
trap : 0 INT TERM

cd ..

exit
