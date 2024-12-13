
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto

# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git sudo direnv dirhistory zsh-syntax-highlighting)

zstyle ':omz:*' aliases no
source $ZSH/oh-my-zsh.sh

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
alias nvimf="nvim '+:Telescope find_files'"
alias tmp="cd \$(mktemp -d)"
alias ze=zellij

alias make="\\make -j$(( $(nproc) + 1 ))"

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
