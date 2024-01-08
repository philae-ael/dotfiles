#!/usr/bin/env zsh


echologs(){
        ( [[ ! "$1" ]] && cat || grep --line-buffered $1 ) | 
        sed -e 's/\(.*\(INFO\|II\).*\)/\o033[32m\1\o033[0m/' \
            -e 's/\(.*\(WARNING\|WW\).*\)/\o033[33m\1\o033[0m/' \
            -e 's/\(.*\(ERROR\|EE\).*\)/\o033[31m\1\o033[0m/' \
}

tailflogs(){
    tail -f $1 | echologs $2
}
