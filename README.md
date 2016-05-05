# run

Akin to `make` and `makefile` (but not really), this is a script runner called `run` that runs a `runfile` in the current directory.

The idea is that a `runfile` is mostly just a `case` block that runs subcommands. That way, you can have `runfile`s laying around that don't need to be executable or directly on the `$PATH`. This is convenient for storing a collection of shell commands that you use commonly in a particular directory.

For added convenience, an alias can quickly print the available `run` subcommands:

    alias runls="grep '^\w*[^*]\W*)' runfile"
