#!/usr/bin/zsh

function make_redirect() {
    exec {id}<> >(
        # fct is in subshell created by (), so it won't pollute extern scripts

        function join_by {
            local IFS="$1" && shift
            echo "$*"
        }

        eval "function fct { $(join_by ';' $@ | sed -E 's_(^|[^\\])\$_\1\$_') }"

        while IFS='' read -r line || [ -n "$line" ]; do
            fct $line
        done
    )

    print "fd is $id"
    print "redirect stderr to fd $id (2>&$id)"
    print "redirect stdout to fd $id (>&$id)"
    print "To close fd $id do 'exec $id>&-'"
}

function stderred {
    # fd 8 will always be colored in red
    make_redirect 'tput setaf 1; echo @$ ; tput sgr0'
}

alias ealias="nvim ~/.zshconf/alias.zsh"

alias tailf="tail -f"
alias wttr='curl "http://wttr.in/Plouzané?lang=fr"'
alias moon='curl "http://wttr.in/Moon?lang=fr"'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel)'

alias py=ipython3

export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
alias pmake='time nice make -j$NUMCPUS --load-average=$NUMCPUS'

alias gdb-kern='gdb kernel/apropos.kernel  -iex "target remote localhost:1234"'
alias msfconsole="msfconsole --quiet -x \"db_connect ${USER}@msf\""

