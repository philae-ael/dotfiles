PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>/tmp/startlog.$$
    setopt xtrace prompt_subst
fi

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

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi
