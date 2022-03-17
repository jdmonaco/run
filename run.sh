#!/usr/bin/env bash

#
# Fast bash script maker/runner
#

NAME=$(basename "$0")
VERSION="1.1.2"
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
#!/usr/bin/env bash
set -ue

# Directory runfile

USAGE="Usage: $NAME (-e | <command>) ..."
CMDHELP=\$(
    grep -Eo '^[[:alnum:]\|]+\s*).*' runfile | sed 's/)[# ]*/\\\\/' | column -s '\\' -t
)

if (( \$# )); then
    runcmd="\$1"
    shift
else
    echo -e "\$USAGE\\n\\n\$CMDHELP"
    exit 1
fi


# Add run commands as switch cases below. Do not make edits
# outside of case blocks. Note: Optional args are available
# as "\${@}". If used, consider the first line in the block
# as a usage statement.


case "\$runcmd" in

test) # usage: test [args]
    echo "Testing runfile command (\$# args)."
    ;;

*)
    echo -e "Error: unrecognized command: \$runcmd\\n\$USAGE\\n\\n\$CMDHELP"
    exit 1
    ;;

esac
RUN
) > "$RUNFILE" && exec vim "$RUNFILE"
fi

echo "Missing runfile. Use 'run -e' to initialize."
exit 1
