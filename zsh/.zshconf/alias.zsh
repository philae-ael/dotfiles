#!/usr/bin/zsh

function xruns {
    if [[ -n "`pgrep X`" ]]; then
        return 0
    else
        return 1
    fi
}

alias ealias="vim ~/.zshconf/alias.zsh"

alias optirun="vblank_mode=0 optirun"
alias tailf="tail -f"
alias wttr='curl "http://wttr.in/Plouzané?lang=fr"'
alias moon='curl "http://wttr.in/Moon?lang=fr"'
alias v=nvim
alias vim=nvim
alias y=yaourt
alias ys='yaourt -S'
alias ysd='yaourt -S --as-deps'
alias yu='yaourt -Suya'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel)'

alias py=ipython

# startx alias
alias sxg='startx gnome'
alias sx='startx'
alias sxb='startx bspwm'

function mkdirvenv(){
    mkvirtualenv $@ || return -1
    ENV_NAME=$(basename $VIRTUAL_ENV)
    echo $ENV_NAME > .venv
    export CD_VIRTUAL_ENV="$ENV_NAME"
}
alias jnb="cd ~/programmation/notebooks/; jupyter-notebook"
