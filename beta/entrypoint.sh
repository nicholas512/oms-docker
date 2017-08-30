#!/bin/sh

cd work/

if [ ! -d build/ ];
then
    ant all
fi

cd Rlibs/

if [ ! -d build/ ];
then
    mkdir build/
    R CMD INSTALL -l build/ source/*.tar.gz
fi

cd ..

java -Doms3.work=/work -cp ".:/root/.oms/3.5.26/oms-all.jar:lib/*:dist/*" oms3.CLI -r $1
