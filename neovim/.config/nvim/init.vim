set  nocompatible

source ~/.config/nvim/general.vim

source ~/.config/nvim/plugin-install.vim

source ~/.config/nvim/plugins/which_keys.vim " Should be first !

source ~/.config/nvim/maps.vim

source ~/.config/nvim/plugins/ycm.vim
source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/vimtex.vim
source ~/.config/nvim/plugins/gutentags.vim
source ~/.config/nvim/plugins/vista.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/ultisnip.vim
source ~/.config/nvim/plugins/rainbow.vim
source ~/.config/nvim/plugins/neomake.vim
source ~/.config/nvim/plugins/easyalign.vim
source ~/.config/nvim/filetypes.vim

" get git top dir and remove trailing \n
let local_git_dir = substitute(system('git rev-parse --show-toplevel'), '\n\+$','', '')

if !v:shell_error
    let localfile = local_git_dir . "/.project.vim"

    if filereadable(localfile)
        execute 'source '.fnameescape(localfile)
    endif
endif

