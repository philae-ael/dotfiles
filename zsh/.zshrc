export ZSH=/home/tristan/.oh-my-zsh

ZSH_THEME="honukai"

HYPHEN_INSENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(sudo git common-aliases web-search virtualenvwrapper )


export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8

export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64 -j8"

#Need to be before .zshconf because of fct redifining
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/bin/virtualenvwrapper.sh

for f in .zshconf/* 
do
	source $f
done

