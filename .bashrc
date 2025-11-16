#
# ~/.bashrc
#

set -a
. <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
set +a


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "$(tty)" == "/dev/tty1" ]] ; then
		exec Hyprland
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_COMPRESSSPARSESTATE=1
GIT_PS1_COMPRESSSPARSESTATE="yes"
GIT_PS1_DESCRIBE_STYLE="describe"
GIT_PS1_SHOWCOLORHINTS=1
. /usr/share/git/completion/git-prompt.sh

PROMPT_DIRTRIM=2
function __jobs() {
	local job_count=$(jobs -lp | wc -l)
	if [[ job_count -gt 0 ]]; then 
		echo " $job_count"
	fi
}
PS1='\w$(__git_ps1 " (%s)")$(__jobs) \$ '

export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
shopt -s cmdhist
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
export HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="history -a; history -n"

eval "$(fzf --bash)"

