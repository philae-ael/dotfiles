export ZSH=/home/tristan/.oh-my-zsh

ZSH_THEME="honukai"

HYPHEN_INSENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(sudo git common-aliases virtualenvwrapper systemd pip cabal python pass)

PATH="$HOME/bin:$PATH"

#clean a bit the path (remove doublons)
export PATH=$(echo $PATH | sed 's/:/\n/g' |  awk '!a[$0]++' | tr '\n' ':' | sed 's/:$//')

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8

export EDITOR='vim'
export PROJECT_HOME="$HOME/programmation/"

# Compilation flags
export ARCHFLAGS="-arch x86_64 -j8"

#Need to be before .zshconf because of fct redifining
source /usr/share/doc/pkgfile/command-not-found.zsh
source $(which crossdev)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt ksh_glob
setopt no_bare_glob_qual

for f in ~/.zshconf/* 
do
	source $f
done


[[ -n "$AUTO_RANGER" && -z "$RANGER_LEVEL" ]] && { 
    /usr/bin/ranger && exit  # don't exit on fails
}
