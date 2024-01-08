pkgs: {
  "bar/bar" = {
    background = "\${colors.background}";
    border-bottom-color = "\${colors.background-alt}";
    border-bottom-size = 3;
    enable-ipc = true;
    font-0 = "Hasklug Nerd Font:style=Regular";
    font-1 = "FiraCode Nerd Font:style=Regular";
    foreground = "\${colors.foreground}";
    height = 26;
    modules-center = "xwindow";
    modules-left = "workspaces ";
    modules-right =
      "battery pad wlan pad pulseaudio pad date pad powermenu pad";
    scroll-down = "bspc desktop -f next.occupied ";
    scroll-up = "bspc desktop -f prev.occupied";
    tray-position = "right";
    width = "100%";
    wm-restack = "bspwm";
  };
  colors = {
    background = "#282828";
    background-alt = "#3c3836";
    color0 = "#282828";
    color1 = "#fb4934";
    color10 = "#b8bb26";
    color11 = "#fabd2f";
    color12 = "#83a598";
    color13 = "#d3869b";
    color14 = "#8ec07c";
    color15 = "#fbf1c7";
    color16 = "#fe8019";
    color17 = "#d65d0e";
    color18 = "#3c3836";
    color19 = "#504945";
    color2 = "#b8bb26";
    color20 = "#bdae93";
    color21 = "#ebdbb2";
    color3 = "#fabd2f";
    color4 = "#83a598";
    color5 = "#d3869b";
    color6 = "#8ec07c";
    color7 = "#d5c4a1";
    color8 = "#665c54";
    color9 = "#fb4934";
    foreground = "#ebdbb2";
    foreground-alt = "#d5c4a1";
  };
  "module/battery" = {
    battery = "BAT1";
    full-at = "99";
    poll-interval = "5";
    type = "internal/battery";
  };
  "module/date" = {
    date = "";
    date-alt = "d/%m/%Y";
    interval = "5";
    label = "%date% %time%";
    time = "%H:%M";
    time-alt = "%H:%M:%S";
    type = "internal/date";
  };
  "module/pad" = {
    content = "| ";
    content-background = "\${colors.background}";
    content-foreground = "\${colors.background-alt}";
    type = "custom/text";
  };
  "module/pad-inv" = {
    content = "  ";
    content-background = "\${colors.background}";
    content-foreground = "\${colors.background-alt}";
    type = "custom/text";
  };
  "module/powermenu" = {
    click-left = "${pkgs.plasma-workspace}/libexec/ksmserver-logout-greeter needed"; 
    content = "power";
    content-foreground = "\${colors.color2}";
    format-spacing = "1";
    menu-4-0-exec = "bspc quit";
    menu-4-1 = "cancel";
    menu-4-1-exec = "menu-open-0";
    type = "custom/text";
  };
  "module/pulseaudio" = {
    bar-volume-empty = "─";
    bar-volume-empty-foreground = "\${colors.foreground-alt}";
    bar-volume-fill = "─";
    bar-volume-foreground-0 = "#55aa55";
    bar-volume-foreground-1 = "#55aa55";
    bar-volume-foreground-2 = "#f5a70a";
    bar-volume-foreground-3 = "#f5a70a";
    bar-volume-foreground-4 = "#ff5555";
    bar-volume-gradient = "true";
    bar-volume-indicator = "│";
    bar-volume-indicator-foreground = "\${colors.foreground-alt}";
    bar-volume-width = "6";
    format-muted = "<label-muted> <bar-volume>";
    format-muted-foreground = "\${colors.foreground-alt}";
    format-volume = "<label-volume> <bar-volume>";
    label-muted = "";
    label-volume = "";
    label-volume-foreground = "\${colors.foreground-alt}";
    type = "internal/pulseaudio";
  };
  "module/spotify" = {
    click-left = "i3-msg workspace '10:S'";
    exec = "~/.config/polybar/spotify_status.py -t 15 -f '{artist}: {song}'";
    format = "<label>";
    format-foreground = "\${colors.foreground-alt}";
    type = "custom/script";
  };
  "module/spotify-next" = {
    click-left = "playerctl next";
    content = "";
    format-foreground = "\${colors.foreground-alt}";
    type = "custom/text";
  };
  "module/spotify-note" = {
    content = " :";
    type = "custom/text";
  };
  "module/spotify-play-pause" = {
    click-left = "playerctl play-pause || spotify";
    exec =
      "~/.config/polybar/spotify_status.py -f '{play_pause}' -p '⏵,⏸' -d '怜'";
    format-foreground = "\${colors.foreground-alt}";
    type = "custom/script";
  };
  "module/spotify-previous" = {
    click-left = "playerctl previous";
    content = "";
    format-foreground = "\${colors.foreground-alt}";
    type = "custom/text";
  };
  "module/wlan" = {
    format-connected = "<label-connected>";
    format-connected-foreground = "\${colors.color20}";
    format-connected-prefix = " ";
    interface = "wlo1";
    interval = "3.0";
    label-connected = "%essid%";
    label-disconnected = "Wifi off";
    label-disconnected-foreground = "\${colors.foreground-alt}";
    type = "internal/network";
  };
  "module/workspaces" = {
    label-empty = "%name%";
    label-empty-foreground = "\${colors.background-alt}";
    label-empty-padding = "1";
    label-focused = "%name%";
    label-focused-background = "\${colors.background-alt}";
    label-focused-padding = "1";
    label-occupied = "%name%";
    label-occupied-padding = "1";
    label-urgent = "%name%!";
    label-urgent-background = "\${colors.color1}";
    label-urgent-padding = "1";
    type = "internal/bspwm";
  };
  "module/xwindow" = {
    label = "%title:0:50:...%";
    type = "internal/xwindow";
  };
}
