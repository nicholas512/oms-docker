#!/bin/sh

# @TODO: implement function for each if statement

cd work/

if [ ! -d build/ ];
then
    ant all
fi

if [ -d Rlibs/ ];
then
    cd Rlibs/
    if [ ! -d build/ ];
    then
        mkdir build/
        # @TODO: checks for source folder. if doesn't exist returns error message
        R CMD INSTALL -l build/ source/*.tar.gz
    fi
    cd ..
fi

java -Xmx12288M -Doms3.work=/work -cp ".:/root/.oms/3.5.26/oms-all.jar:lib/*:dist/*" oms3.CLI -r $1
