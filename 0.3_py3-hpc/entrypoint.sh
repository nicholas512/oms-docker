#!/bin/bash

# it exits the script if there are uninitialised variables
set -o nounset

# it exits the script if any statement returns a non-true value
set -o errexit

abort() {
    echo >&2 "
*********************************
***     SIMULATION ABORTED    ***
*********************************
"
    echo "An error occured. Exiting..." >&2
    echo "OMS version: $OMS_VERSION"

    exit 1
}

##############################################################################
###
### MAIN
###
##############################################################################

trap 'abort' 0

omslink=$HOME/.oms

if [ -L ${omslink} ] ; then
   if [ -e ${omslink} ] ; then
      echo "Good link" >  /dev/null
   else
      echo "Broken link" > /dev/null
   fi
elif [ -e ${omslink} ] ; then
   echo "Not a link" > /dev/null
else
   ln -sf /opt/.oms $omslink
fi

sh bash_script/buildOMSprj.sh
sh bash_script/checkBuildRpackages.sh
sh bash_script/runOMS.sh $1

trap : 0

echo >&2 '
*********************************
***     END OF SIMULATION     ***
*********************************
'

exit
