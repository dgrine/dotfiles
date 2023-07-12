#!/usr/bin/env bash
# install-nix.sh
# Installs the nix package manager (multi-user installation)
# Example: ./install-nix.sh 
set -e
curl -L https://nixos.org/nix/install > .install-nix.sh.tmp
sh ./.install-nix.sh.tmp --daemon
rm ./.install-nix.sh.tmp
