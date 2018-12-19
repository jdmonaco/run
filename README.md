# run.sh

Akin to `make` and `makefile` (but not really), this is a script runner called `run` that runs a `runfile` in the current directory. To install, create a symbolic link to `run.sh` called `run` somewhere in your `$PATH`. 

The idea is that a `runfile` is basically a switch that runs subcommands. That way, you can have `runfile`s laying around that don't need to be executable or on your `$PATH`. This is convenient for storing collections of shell commands that are specific to particular directories.

In normal usage, the first argument must be the name of a subcommand (i.e., one of the comparands defined in the `case` block of the `runfile`). This can be followed by optional arguments, which are available to the subcommands as `"${@}"`. 

To initialize or edit the `runfile` for the current directory, simply call `run -e`.

For added convenience, you can add an alias to your `.bashrc` for quickly listing the `run` subcommands in the current directory's `runfile`:

    alias runls="grep -Eo '^\w+\s*).*' runfile | sed 's/)[# ]*/|/' | column -s '|' -t"

Note that subcommands longer than one line can place a helpful comment or usage statement following the subcommand switch, e.g.:

    fizzbuzz) # run the classic fizzbuzz algorithm
        for num in {1..100}; do 
            ...

Comments like this will be displayed by the `runls` alias above in a column-formatted table. 
