#
# ~/.bashrc
#

set -a
. <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
set +a

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "$(tty)" == "/dev/tty1" ]]; then
	exec Hyprland
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c'

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
eval "$(direnv hook bash)"
eval "$(mise activate bash)"

function enote() {
	# If 2 args: NOTE_DIR/dir/file
	# If 1 arg: file in NOTE_DIR
	# If no args: today's date in NOTE_DIR
	# For file there are some shortcuts:
	#  - t: today's date
	#  - y: yesterday's date

	local NOTE_DIR=${NOTE_DIR:-$HOME/documents/notes}
	local filename
	local dir

	if [[ $# -eq 2 ]]; then
		dir="$1"
		filename="$2"
	elif [[ $# -eq 1 ]]; then
		dir=""
		filename="$1"
	else
		dir=""
		filename="$(date +%Y-%m-%d)"
	fi

	if [[ "$filename" == "t" ]]; then
		filename="$(date +%Y-%m-%d)"
	elif [[ "$filename" == "y" ]]; then
		filename="$(date -d "yesterday" +%Y-%m-%d)"
	fi

	if [[ "$filename" != *.md ]]; then
		filename="$filename.md"
	fi
	local filepath="$NOTE_DIR/$dir/$filename"
	mkdir -p "$(dirname "$filepath")"
	pushd "$(dirname "$filepath")" >/dev/null 2>&1
	${EDITOR:-vim} "$filepath"
	popd >/dev/null 2>&1
}
