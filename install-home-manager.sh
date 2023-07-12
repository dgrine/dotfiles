#!/usr/bin/env bash
# install-home-manager.sh
# Installs the home-manager for nix
# Example: ./install-home-manager.sh 
set -e
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
fn_home_nix="`pwd`/home-manager/hosts/`hostname`/home.nix"
if [ -f "$fn_home_nix" ]; then
    rm $HOME/.config/home-manager/home.nix
    ln -s `pwd`/home-manager/hosts/`hostname`/home.nix $HOME/.config/home-manager/
    home-manager switch
else
    echo "warning: $fn_home_nix does not exist, leaving the auto-generated home.nix"
fi
