#!/usr/bin/env bash

#
# Fast bash script maker/runner
#

VERSION="1.1.1"
RUNFILE="runfile"

if [[ -f "$RUNFILE" ]]; then
    if [[ "$#" -eq 1 ]] && [[ "$1" = "-e" ]]; then
        exec vim "$RUNFILE"
    else
        exec bash "$RUNFILE" "${@}"
    fi
fi

if [[ "$#" -eq 1 ]] && [[ "$1" = "-e" ]]; then
( cat <<RUN
#!/bin/bash
set -ue

# Runfile script

USAGE="Usage: $(basename "$0") -e|test [args]"

if (( \$# )); then
    runcmd="\${1}"
    shift
else
    echo \$USAGE
    exit 1
fi


# Add run commands as switch cases below. Do not make edits
# outside of case blocks. Note: Optional args are available
# as "\${@}". If used, consider the first line in the block
# as a usage statement.


case \$runcmd in

test) # usage: test [args]
    echo "Testing runfile command (\$# args)." 
    ;;

*)
    echo \$USAGE
    exit 1
    ;;

esac
RUN
) > "$RUNFILE" && exec vim "$RUNFILE"
fi

echo "No runfile found."
exit 1
