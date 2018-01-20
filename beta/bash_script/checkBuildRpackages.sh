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
                Rscript /rdep.R
                trap : 0 INT TERM
            fi
        elif [ ! -e Rlibs/package.json ];
        then
            cp /package.json Rlibs/
            abort "ERROR: package.json not found. Template provided"
        else
            trap 'abort "ERROR: problems building R packages"' 0 INT TERM
            python2 /packageParser.py
            trap : 0 INT TERM
        fi
    fi
fi

cd ..

exit
