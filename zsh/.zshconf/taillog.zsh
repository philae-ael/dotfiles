#!/usr/bin/env zsh


echologs(){
        ( [[ ! "$1" ]] && cat || grep --line-buffered $1 ) | 
        sed -e 's/\(.*INFO.*\)/\o033[32m\1\o033[0m/' \
        -e 's/\(.*WARNING.*\)/\o033[33m\1\o033[0m/' \
        -e 's/\(.*ERROR.*\)/\o033[31m\1\o033[0m/' \
}

tailflogs(){
    tail -f $1 | echologs $2
}
