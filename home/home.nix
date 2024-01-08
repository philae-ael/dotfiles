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

  lspsaga-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lspsaga-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tami5";
      repo = "lspsaga.nvim";
      rev = "518c12e2897edd2542bee76278a693cc7eea2f51";
      sha256 = "1ilyl26xdwq9ws6mb86rz83kq267gsgfpjmrpc87snx1h8z9rq4v";
    };
  };
  polybar_config = import ./polybar.nix pkgs;
in
{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";


  home.packages = with pkgs; [
    # required for DE
    python
    feh
    sxhkd
    j4-dmenu-desktop
    qt4 # for qdbus

    # graphical apps
    firefox
    spotify
    anki
    evince
    zathura
    kitty
    dark-chrome

    pavucontrol
    inkscape

    # various bash utilities
    xclip
    tree
    htop
    file
    unzip
    p7zip
    ripgrep

    nodePackages.vim-language-server
    rust-analyzer
    rnix-lsp
    zsh-completions
  ];


  # tray service, used to run polybar
  systemd.user.targets = {
    tray = {
      Unit = {
        Description = "Tray";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

    };
  };

  home.file.".xinitrc".source = "${config.home.homeDirectory}/.config/nixpkgs/xinitrc";
  xdg = {
    enable = true;
    configFile = {
      "plasma-org.kde.plasma.desktop-appletsrc".source = "${config.home.homeDirectory}/.config/nixpkgs/plasma-org.kde.plasma.desktop-appletsrc";
      "kactivitymanagerdrc".source = "${config.home.homeDirectory}/.config/nixpkgs/kactivitymanagerdrc";
      "kxkbrc".source = "${config.home.homeDirectory}/.config/nixpkgs/kxkbrc";
      "kdeglobals".source = "${config.home.homeDirectory}/.config/nixpkgs/kdeglobals";
      "kded5rc".source = "${config.home.homeDirectory}/.config/nixpkgs/kded5rc";
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
    config = polybar_config;
    script = "PATH=${pkgs.python3}/bin:${pkgs.bspwm}/bin:$PATH polybar bar &";
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
  };

  services.mpris-proxy.enable = true;

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
      enable_audio_bell no

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
      init.defaultBranch = "main";
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


  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible

      vim-airline
      vim-surround

      vim-polyglot

      rainbow_parentheses

      vim-gitgutter
      vim-easy-align

      nvim-lspconfig
      lspkind-nvim

      friendly-snippets
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-cmdline
      cmp-buffer

      cmp_luasnip
      luasnip

      lspsaga-nvim

      gruvbox

      which-key-nvim

    ];
    extraConfig = builtins.readFile ./config.vim;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

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
      "toWindows" = "systemctl reboot --boot-loader-entry=auto-windows";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "aliases" "sudo" "direnv" "dotenv" ];
      theme = "apple";
    };

    initExtra = ''
      if [[ -z $DISPLAY ]] ; then
        case $(tty) in /dev/tty1)
          exec startx
        esac
      fi

    '';
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
