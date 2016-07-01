#!/usr/bin/env bash

#
# Script runner
#

RUNFILE="./runfile"
BASH=`which bash`
VIM=vim

if [ -f "$RUNFILE" ]
then
    $BASH "$RUNFILE" ${@}
    exit 0
fi

if [[ $# == 1 ]] && [[ "$1" == "init" ]]
then
(
cat <<RUN
#!/usr/bin/env sh
set -ue

#
# Runfile script
#
# Add commands as test cases below.
#

USAGE="Usage: `basename \${0}` command"

if [[ \$# != 1 ]]
then
    echo \$USAGE
    exit 1
fi

case "\$1" in

test) echo "Testing runfile command." ;;

*)
    echo \$USAGE
    exit 1
    ;;

esac
RUN
) > "$RUNFILE" &&
    $VIM "$RUNFILE"
exit 0
fi

echo "No runfile found."
exit 1
