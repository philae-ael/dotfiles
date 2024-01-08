# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  plasma-bspwm = pkgs.writeTextFile {
    name = "plasma-bspwm-session";
    destination = "/share/xsessions/plasma-bspwm.desktop";
    text = ''
      [Desktop Entry]
      Exec=${pkgs.coreutils}/bin/env KDEWM=${pkgs.bspwm}/bin/bspwm ${pkgs.plasma-workspace}/bin/startplasma-x11
      DesktopNames=KDE
      Name=Plasma with bspwm
      Comment=Plasma with bwpsm
    '';
  } // {
    providedSessions = [ "plasma-bspwm" ];
  };
in {
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = [ "ntfs" ];
  };

  networking.hostName = "nixos-Tristan"; # Define your hostname.

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware = {
    opengl.extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl

    ];
    bluetooth.enable = true;
  };

  #  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];

      # Use 2560x1440p 144Hz  by default
      monitorSection = ''
        Modeline "2560x1440_144.0"  592.25  2560 2581 2613 2666  1440 1443 1448 1543 +hsync -vsync
        Option "PreferredMode" "2560x1440_144.0"
      '';

      displayManager = {
        defaultSession = "plasma-bspwm";
        autoLogin = {
          enable = true;
          user = "tristan";
        };
        sddm = {
          enable = true;
          enableHidpi = true;
        };

        sessionPackages = [ plasma-bspwm ];
      };

      desktopManager.plasma5 = { enable = true; };
      windowManager.bspwm = { enable = true; };

      # displayManager.defaultSession = "gnome-flashback-bspwm-gnome";

    };

    # Remap what happens on power key press so it suspends rather than
    # shutting don immediately
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };
  };

  networking.networkmanager.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
    shell = pkgs.zsh;

  };

  environment = {
    variables.EDITOR = "vim";
    systemPackages = with pkgs; [ vim plasma-pa ];
  };
  programs.zsh.enable = true;
  programs.steam.enable = true;

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        serif = [ "Source Serif Pro" "DejaVu Serif" ];
        sansSerif = [ "Source Sans Pro" "DejaVu Sans" ];
        monospace = [ "Hasklug Nerd Font" "FiraCode Nerd Font" ];
      };
    };

    fonts = with pkgs; [
      hasklig
      source-code-pro
      overpass
      nerdfonts
      fira
      fira-code
      fira-mono
    ];
  };

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

