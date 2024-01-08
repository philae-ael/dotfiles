# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;
    imports = [ 
        ./hardware-configuration.nix
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
    };

    networking.hostName = "nixos-Tristan"; # Define your hostname.

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "en_US.UTF-8";

    hardware = {
        opengl.extraPackages = with pkgs ;[
            intel-media-driver
            vaapiIntel
        ];
        pulseaudio.enable = true;
    };
    sound.enable = true;


    services = {
        xserver = {
            enable = true;
            videoDrivers = ["modesetting"];

            displayManager.gdm.enable = true;
            displayManager.autoLogin.enable = true;
            displayManager.autoLogin.user = "tristan";
            desktopManager.gnome.enable = true;
            desktopManager.xterm.enable = false;

        };
        gnome.core-utilities.enable = false;



            # Remap what happens on power key press so it suspends rather than
            # shutting don immediately
            logind = {
                extraConfig = ''
                    HandlePowerKey=suspend
                '';
            };
        };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tristan = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.zsh;

    };

    environment = {
       variables.EDITOR = "vim";
        systemPackages = with pkgs; [
            vimHugeX 
            gnome.nautilus
        ];
    };
    programs.zsh.enable = true;


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
    system.stateVersion = "21.05"; # Did you read the comment?

}

