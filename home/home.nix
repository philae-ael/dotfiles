{ config, pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
    dbus-python
    # other python packages you want
  ]; 
  python = python3.withPackages my-python-packages;

  dark-chrome = pkgs.google-chrome.override {
    commandLineArgs = "--enable-features=WebUIDarkMode --force-dark-mode";
  };

in
  {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./dconf.nix
  ];


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";


  home.packages = with pkgs; [
    firefox spotify anki evince

    xclip tree htop zathura kitty


    python
    dark-chrome

    feh
    sxhkd
    j4-dmenu-desktop
  ];

  xdg = {
    enable = true;
    configFile = {
      "bspwm/bspwmrc".source = "${config.home.homeDirectory}/.config/nixpkgs/bspwmrc";
      "sxhkd/sxhkdrc".source = "${config.home.homeDirectory}/.config/nixpkgs/sxhkdrc";
      "polybar/spotify_status.py".source = "${config.home.homeDirectory}/.config/nixpkgs/spotify_status.py";

    };
  };


  xsession = {
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
      defaultCursor = "left_ptr";
    };
  };

  services.dropbox = {
    enable = true;
    path = "${config.home.homeDirectory}/synced";
  };

  services.polybar = {
    enable = true;
    config = "${config.home.homeDirectory}/.config/nixpkgs/polybar";
    script = "PATH=${pkgs.python3}/bin:${pkgs.bspwm}/bin:$PATH polybar bar &";
    package = pkgs.polybar.override {
      pulseSupport = true;
    }; 
  };

  services.picom = {
    enable = true;
    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    backend = "glx";
    fade = true;
    fadeDelta = 3;
    shadow = true;
    shadowOpacity = "0.75";
    opacityRule = [ 
      "100:class_g = 'kitty' && focused"
      "95:class_g = 'kitty' && !focused"
    ];
  };

  programs.ssh = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family      monospace
      bold_font        auto
      italic_font      auto
      bold_italic_font auto

      disable_ligatures cursor

      # gruvbox dark by morhetz, https://github.com/morhetz/gruvbox
      # This work is licensed under the terms of the MIT license.
      # For a copy, see https://opensource.org/licenses/MIT.

      background  #282828
      foreground  #ebdbb2

      cursor                #928374

      selection_foreground  #928374
      selection_background  #3c3836

      color0  #282828
      color8  #928374

      # red
      color1                #cc241d
      # light red
      color9                #fb4934

      # green
      color2                #98971a
      # light green
      color10               #b8bb26

      # yellow
      color3                #d79921
      # light yellow
      color11               #fabd2f

      # blue
      color4                #458588
      # light blue
      color12               #83a598

      # magenta
      color5                #b16286
      # light magenta
      color13               #d3869b

      # cyan
      color6                #689d6a
      # lighy cyan
      color14               #8ec07c

      # light gray
      color7                #a89984
      # dark gray
      color15               #928374
    '';
  };

  programs.git = {
    enable = true;
    userName = "Tristan Gouge";
    userEmail = "gouge.tristan@gmail.com";
    extraConfig = {
      core.editor = "vim";
      github.username = "naegi";
    };
    aliases = {
      c = "commit";
      a = "add";
      s = "status";
      cl = "clone";
      co = "checkout";
      p = "push";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";

    };
  };


  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vimHugeX;
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      vim-nix
      vim-airline
      vim-surround
      rainbow_parentheses
      vim-gitgutter
      vim-easy-align
      gruvbox
      auto-pairs
    ];
    extraConfig = ''
      set linebreak
      set showbreak=++
      set foldmethod=marker
      set showmatch
      set ruler
      set number

      set cursorline
      set cursorcolumn
      " Only on current windows
      au WinLeave * set nocursorline nocursorcolumn
      au WinEnter * set cursorline cursorcolumn

      set backspace=indent,eol,start
      set autoread
      set showcmd


      set completeopt+=menuone

      " Selected characters/lines in visual mode
      nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
      nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

      let &t_SI = "\<esc>[5 q"
      let &t_SR = "\<esc>[5 q"
      let &t_EI = "\<esc>[2 q"


      set wildmenu
      set wildmode=longest,list,full

      set modeline

      set mouse=a

      set hidden

      "" tabs
      set expandtab   " Use spaces instead of tabs
      set autoindent
      set shiftwidth=4    " Number of auto-indent spaces
      set smartindent
      set smarttab
      set softtabstop=4
      set tabstop=8
      set shiftround

      set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
      set list

      set laststatus=2
      set noshowmode

      "Other undo opts
      set undolevels=1000
      set undoreload=10000

      set incsearch
      set ignorecase
      set smartcase

      let g:mapleader = "\<Space>"
      let g:maplocalleader = ','

      "Toggle relative/absolute line numbers
      function! NumberToggle()
      if(&relativenumber == 1)
        set norelativenumber
      else
        set relativenumber
      endif
      endfunction


      "" remove trailing spaces
      function! StripTrailingWhitespace()
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " do the business:
      %s/\s\+$//e
      " clean up: restore previous search
      "history, and cursor position
      let @/=_s
      call cursor(l, c)
      endfunction


      " completion with tab
      inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
      inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

      cmap w!! %!sudo tee > /dev/null %

      nnoremap <F4> :call NumberToggle()<cr>
      nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>
      set termguicolors
      set background=dark
      let g:gruvbox_contrast_dark="medium"
      colorscheme gruvbox

      au VimEnter * RainbowParenthesesToggle
      au Syntax * RainbowParenthesesLoadRound
      au Syntax * RainbowParenthesesLoadSquare
      au Syntax * RainbowParenthesesLoadBraces

      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)

      let g:airline_powerline_fonts = 1


    '';
  };

  # A cat(1) clone with syntax highlighting and Git integration.
  programs.bat = {
    enable = true;
  };

  # This project is a rewrite of GNU ls with lot of added features 
  programs.lsd = {
    enable = true;

    # ls, ll, la, lt ...
    enableAliases = true;
  };


  programs.zsh = {
    enable = true;
    shellAliases = {
      "cat" = "bat";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "aliases" "sudo" ];
      theme = "apple";
    };

  };

  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark";


  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
