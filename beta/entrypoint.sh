#!/bin/bash

abort() {
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occured. Exiting..." >&2

    exit 1
}

buildOMSprj() {
    if [ ! -d build/ ];
    then
        ant all
    fi
}

buildRpackages() {
    if [ ! -d Rlibs/source/ ];
    then
       rm -r Rlibs/build/
       echo "ERROR: source folder and R packages not found"
       exit 1
    elif [ ! -e Rlibs/package.json ];
    then
        rm -r Rlibs/build/
        cp /package.json Rlibs/
        echo "ERROR: package.json not found. Template provided"
        exit 1
    else
        if ! python2 /packageParser.py;
        then
            rm -r Rlibs/build/
            exit 1
        fi
    fi
}

checkRpackages() {
    if [ ! -d Rlibs/build/ ];
    then
        mkdir Rlibs/build/
        buildRpackages
    fi
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
        -cp ".:/root/.oms/3.5.27/oms-all.jar:lib/*:dist/*" oms3.CLI \
        -r $1
}

##############################################################################
###
### MAIN
###
##############################################################################

trap 'abort' 0

cd work/

buildOMSprj
checkAndBuildRpackages
runOMS $1

trap : 0

echo >&2 '
************
*** DONE ***
************
'

exit
