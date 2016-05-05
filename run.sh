#!/usr/bin/env sh

#
# Script runner
#

RUNFILE=runfile
SH=`which sh`

if [ -f "./$RUNFILE" ]
then
    $SH "./$RUNFILE" ${@}
else
    echo "No runfile found."
    exit 1
fi
