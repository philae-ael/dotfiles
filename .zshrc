
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto

# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git-auto-fetch sudo direnv dirhistory zsh-syntax-highlighting zsh-uv-env)

# zstyle ':omz:*' aliases no
source $ZSH/oh-my-zsh.sh
unalias md
unalias rd

function enote() {
  pushd ~/notes
  nvim "$(date '+%Y-%m-%d').md"
  popd
}

alias ssh="TERM=xterm \\ssh"
alias l="eza -lh"
alias ls=eza
alias ll="eza -lh"
alias la="eza -lAh"
alias lsa="eza -lah"
alias tree="eza -t"
alias tree="eza --tree"
alias lt="eza --tree"
alias ltg="eza --tree --git-ignore"
alias lta="eza --tree -A"
alias ltga="eza --tree --git-ignore -A"
alias cdf="cd \$(fd  --type d  --strip-cwd-prefix | fzf)"
alias tmp="cd \$(mktemp -d)"
alias ze=zellij

alias make="\\make -j$(( $(nproc) + 1 ))"

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source /usr/share/nvm/init-nvm.sh

eval "$(starship init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

function idot() {
    dot -Gmargin=0.7 "-Gbgcolor=#ffffff00" -Gcolor=white -Gfontcolor=white -Ncolor=white -Nfontcolor=white -Ecolor=white -Efontcolor=white -Gdpi=200 -Tpng \
    | magick - -resize $(kitty +kitten icat --print-window-size | awk -Fx '{print $1 "x" ($2 - 100)}')\> png:- \
    | kitty +kitten icat
}

function md() {
  pandoc --standalone --from gfm --css ~/.pandoc/github-markdown.css $1 > /tmp/$1.html
  xdg-open /tmp/$1.html
}
