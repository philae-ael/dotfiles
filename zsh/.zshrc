#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "$HOME/.zprezto/init.zsh" ]]; then
  source "$HOME/.zprezto/init.zsh"
fi

setopt ksh_glob
setopt no_bare_glob_qual

for f in ~/.zshconf/* 
do
	source $f
done
