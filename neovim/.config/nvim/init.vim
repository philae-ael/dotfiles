set  nocompatible
source ~/.config/nvim/plugin-install.vim

source ~/.config/nvim/general.vim

source ~/.config/nvim/plugins/deoplete.vim
source ~/.config/nvim/plugins/grammalect.vim
source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/ultisnips.vim
source ~/.config/nvim/plugins/rainbow-parenthese.vim
source ~/.config/nvim/plugins/syntastic.vim
source ~/.config/nvim/plugins/vim-commentary.vim
source ~/.config/nvim/plugins/tabularize.vim
source ~/.config/nvim/plugins/ale.vim
source ~/.config/nvim/plugins/vimtex.vim
source ~/.config/nvim/plugins/other.vim

source ~/.config/nvim/maps.vim


" get git top dir and remove trailing \n
let local_git_dir = substitute(system('git rev-parse --show-toplevel'), '\n\+$','', '')
if !v:shell_error
    let localfile = local_git_dir . "/.project.vim"

    if filereadable(localfile)
        execute 'source '.fnameescape(localfile)
    endif
endif

