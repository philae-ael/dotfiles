# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
  {
    dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        per-window = true;
        sources = [ (mkTuple [ "xkb" "us+intl" ]) ];
        xkb-options = [ "terminate:ctrl_alt_bksp" ];
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };
      "org/gnome/gnome-flashback" = {
        desktop = false;
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        area-screenshot = [];
        area-screenshot-clip = [];
        help = [];
        logout = [];
        magnifier = [];
        magnifier-zoom-in = [];
        magnifier-zoom-out = [];
        screenreader = [];
        screensaver = [];
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [];
        switch-input-source-backward = [];
      };
    };
  }
