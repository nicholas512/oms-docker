#!/bin/bash

set -o errexit

# set -o errtrace

abort() {
    if [ -d build/ ];
    then
        rm -r build/
    fi
    echo "ERROR: OMS project not built";
    exit 1
}

cd work/

if [ ! -d build/ ];
then
    trap 'abort' 0 INT TERM
    ant all
    trap : 0 INT TERM
else
    echo "build/ folder exists: project already built."
fi

cd ..

exit
