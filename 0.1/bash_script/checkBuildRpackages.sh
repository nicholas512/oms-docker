#!/bin/bash

set -o errexit

# set -o errtrace

abort() {
    if [ -d Rlibs/build/ ];
    then
        rm -r Rlibs/build/
    fi
    echo $1
    exit 1
}

cd work

if [ -d Rlibs/ ];
then
    if [ ! -d Rlibs/build/ ];
    then
        mkdir Rlibs/build/
        if [ ! -d Rlibs/source/ ];
        then
            if [ ! -e Rlibs/package.txt ];
            then
                abort "ERROR: source folder and R packages not found"
            else
                mkdir Rlibs/source/
                trap 'abort "ERROR: problems building R packages"' 0 INT TERM
                rdep.R di
                trap : 0 INT TERM
            fi
        else
            trap 'abort "ERROR: problems building R packages"' 0 INT TERM
            rdep.R i
            trap : 0 INT TERM
        fi
    fi
fi

cd ..

exit
