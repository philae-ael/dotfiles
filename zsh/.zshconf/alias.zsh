#!/usr/bin/zsh

function xruns {
    if [[ -n "`pgrep X`" ]]; then
        return 0
    else
        return 1
    fi
}

alias ealias="nvim ~/.zshconf/alias.zsh"

alias tailf="tail -f"
alias wttr='curl "http://wttr.in/Plouzané?lang=fr"'
alias moon='curl "http://wttr.in/Moon?lang=fr"'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel)'

alias cln_latex_dir="find . -maxdepth 1 -type f | grep -v .tex$  | xargs -i rm '{}'"

alias py=ipython3

# startx alias
alias sxg='startx gnome'
alias sx='startx'
alias sxb='startx bspwm'

export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
alias pmake='time nice make -j$NUMCPUS --load-average=$NUMCPUS'


function mkdirvenv(){
    mkvirtualenv $@ || return -1
    ENV_NAME=$(basename $VIRTUAL_ENV)
    echo $ENV_NAME > .venv
    export CD_VIRTUAL_ENV="$ENV_NAME"
}

alias gdb-kern='gdb kernel/apropos.kernel  -iex "target remote localhost:1234"'
