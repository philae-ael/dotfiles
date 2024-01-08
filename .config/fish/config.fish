set fish_greeting
if status is-interactive
  abbr -p command -a 'g' 'git'
  abbr -p command -a 'gs' 'git status'
  abbr -p command -a 'gd' 'git diff'
  abbr -p command -a 'gl' 'git log'
  abbr -p command -a 'gt' 'git tree'
  abbr -p command -a 'gc' 'git commit'

  abbr -p anywhere -a '...' '../..'
  abbr -p anywhere -a '....' '../../..'

  abbr -p command -a 'l' 'exa -l'
  abbr -p command -a 'lg' 'exa --git-ignore -l'
  abbr -p command -a 'la' 'exa -la'
  abbr -p command -a 'lag' 'exa --git-ignore -la '
  abbr -p command -a 'lt' 'exa -T'
  abbr -p command -a 'ltg' 'exa --git-ignore -T'
end
