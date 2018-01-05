#!/bin/bash

# it exits the script if there are uninitialised variables
set -o nounset

# it exits the script if any statement returns a non-true value
set -o errexit

abort() {
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occured. Exiting..." >&2

    exit 1
}

##############################################################################
###
### MAIN
###
##############################################################################

trap 'abort' 0

sh bash_script/buildOMSprj.sh
sh bash_script/checkBuildRpackages.sh
sh bash_script/runOMS.sh $1

trap : 0

echo >&2 '
************
*** DONE ***
************
'

exit
