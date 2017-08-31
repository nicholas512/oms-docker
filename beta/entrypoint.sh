#!/bin/bash

set -e

buildOMSprj() {
    if [ ! -d build/ ];
    then
        ant all
    fi
}

buildRpackages() {
    if [ ! -d source/ ];
    then
       echo "ERROR: source folder and R packages not found"
       exit 1
    else
        R CMD INSTALL -l build/ source/*.tar.gz
    fi
}

checkRpackages() {
    cd Rlibs/
    if [ ! -d build/ ];
    then
        mkdir build/
        buildRpackages
    fi
    cd ..
}

checkAndBuildRpackages() {
    if [ -d Rlibs/ ];
    then
        checkRpackages
    fi

}

runOMS() {
    java -Xmx12288M \
        -Doms3.work=/work \
        -cp ".:/root/.oms/3.5.26/oms-all.jar:lib/*:dist/*" oms3.CLI \
        -r $1
}

cd work/

buildOMSprj
checkAndBuildRpackages
runOMS $1
