set fish_greeting
if status is-interactive
  abbr -p command -a 'g' 'git'
  abbr -p command -a 'ga' 'git add'
  abbr -p command -a 'gs' 'git status'
  abbr -p command -a 'gd' 'git diff'
  abbr -p command -a 'gl' 'git log'
  abbr -p command -a 'gt' 'git tree'
  abbr -p command -a 'gc' 'git commit'
  
  abbr -p command -a 's' 'kitty +kitten ssh'

  abbr -p anywhere -a '...' '../..'
  abbr -p anywhere -a '....' '../../..'

  abbr -p command -a 'l' 'exa -l -stype'
  abbr -p command -a 'lg' 'exa --git-ignore -l -stype'
  abbr -p command -a 'la' 'exa -la -stype'
  abbr -p command -a 'lag' 'exa --git-ignore -la -stype'
  abbr -p command -a 'lt' 'exa -T -stype'
  abbr -p command -a 'ltg' 'exa --git-ignore -T -stype'
  direnv hook fish | source
end
