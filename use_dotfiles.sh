#!/usr/bin/env sh


sudo cp ./configuration.nix /etc/nixos/configuration.nix
sudo chown root:root /etc/nixos/configuration.nix

mkdir -p $HOME/.config/nixpkgs/
cp -a ./home/. $HOME/.config/nixpkgs/

