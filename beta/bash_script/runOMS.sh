#!/bin/bash

set -o nounset

set -o errexit

abort() {
    echo "ERROR: problems running the OMS project";
    exit 1
}

cd work/

trap 'abort' 0
java -Xmx12288M \
    -Doms3.work=/work \
    -cp ".:/root/.oms/3.5.38/oms-all.jar:lib/*:dist/*" oms3.CLI \
    -r $1
trap : 0

cd ..

exit