#!/bin/env sh
rm home -rf
cp -r $HOME/.config/nixpkgs home
cat /etc/nixos/configuration.nix > configuration.nix


