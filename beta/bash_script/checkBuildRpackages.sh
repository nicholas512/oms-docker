#!/bin/bash

set -o errexit

# set -o errtrace

abort() {
    if [ -d Rlibs/source/ ];
    then
        if [ -z "$(ls -A Rlibs/source/)" ] || [ -z "$(ls -A Rlibs/source/src/contrib)" ]; # @TODO: this should check if every package has been downloaded
        then
            rm -r Rlibs/source/
        fi
    fi

    if [ -d Rlibs/build/ ];
    then
        rm -r Rlibs/build/
    fi

    echo $1
    exit 1
}

cd work

if [ -d Rlibs/ ]; # R dependencies to download
then
    if [ ! -d Rlibs/build/ ]; # Packages not build yet
    then
        mkdir Rlibs/build/
        if [ ! -d Rlibs/source/ ]; # Packages not downloaded yet
        then
            if [ ! -e Rlibs/package.txt ]; # No list of packages available
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
