#!/usr/bin/zsh

function make_redirect() {
    local -t id
    exec {id}> >(
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
    print "To close fd $id do close_$id"
    eval "function close_$id { local id; id=$id; exec {id}>&- ; unset -f close_$id }"
}

function stderred {
    # fd 8 will always be colored in red
    make_redirect 'tput setaf 1; echo $@ ; tput sgr0'
}

alias ealias="${EDITOR} ${(%):-%N}"

alias tailf="tail -f"
alias wttr='curl "http://wttr.in/Plouzané?lang=fr"'
alias moon='curl "http://wttr.in/Moon?lang=fr"'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel)'

alias py=ipython3
alias vim=nvim

export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
alias pmake='time make -j$NUMCPUS --load-average=$NUMCPUS'

alias gdb-kern='gdb kernel/kernel.kernel  -iex "target remote localhost:1234"'
alias msfconsole="msfconsole --quiet -x \"db_connect ${USER}@msf\""

alias bws='export BW_SESSION=$(cat ~/.bitwarden_session)'

alias sync_books_from_drive="rclone sync 'remote:Livres Math' $HOME/Documents/Maths/Livres -P"
alias sync_books_to_drive="rclone sync $HOME/Documents/Maths/Livres 'remote:Livres Math' -P"

alias sync_administratif_from_drive="rclone sync 'remote:Administratif' $HOME/Documents/administratif -P"
alias sync_administratif_to_drive="rclone sync $HOME/Documents/administratif 'remote:Administratif' -P"

alias tmpdir='cd $(mktemp -d)'
