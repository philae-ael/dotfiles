#!/bin/env sh
cd "$(dirname "$0")"
rm home -rf
cp -r $HOME/.config/nixpkgs home
cat /etc/nixos/configuration.nix > configuration.nix


