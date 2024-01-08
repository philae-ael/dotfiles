#!/usr/bin/zsh

alias ealias="vim ~/.zshconf/alias.zsh"

alias v=vim
alias g=git
alias groot='cd $(git rev-parse --show-toplevel)'

function mkdirvenv(){
    mkvirtualenv $@ || return -1
    ENV_NAME=$(basename $VIRTUAL_ENV)
    echo $ENV_NAME > .venv
    export CD_VIRTUAL_ENV="$ENV_NAME"
}
