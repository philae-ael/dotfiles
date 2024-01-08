#!/usr/bin/env sh

sudo cp ./configuration.nix /etc/nixos/configuration.nix
sudo chown root:root /etc/nixos/configuration.nix

if [ ! -L $HOME/.config/nixpkgs ]; then
    ln -s $PWD/home/ $HOME/.config/nixpkgs
fi

