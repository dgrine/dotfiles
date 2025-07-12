# Dotfiles

My personal development configuration files for:

* [alacritty](https://github.com/alacritty/alacritty) — Fast, cross-platform, OpenGL terminal emulator
* [git](https://git-scm.com) — Distributed version control system 
* [neovim](https://neovim.io) — Hyperextensible Vim-based text editor
* [tmux](https://github.com/tmux/tmux/wiki) — Terminal multiplexer
* [vifm](https://vifm.info) — File manager with curses interface providing a Vim-like environment 
* [zsh](https://zsh.sourceforge.io) — Shell designed for interactive use
* ...

The configurations are maintained using [Nix](https://nixos.org/) with [Home Manager](https://github.com/nix-community/home-manager) and are actively tested on Debian, Ubuntu, 
Manjaro and macOS.

![Example of Neovim, Vifm and zsh running inside a Tmux session within Alacritty](screenshot.png)

## Dependencies

* [Git](https://git-scm.com) — Distributed version control system 
* [Curl](https://curl.se) — URL based data transfer tool
* [Home Manager](https://github.com/nix-community/home-manager) — Declarative configuration management using Nix
* [Nix](https://nixos.org/) — Package manager for declarative, reproducible builds

And of course the software related to the configuration packages of interest.

## Installation

```
git clone git@gitlab.com:dgrine/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-nix.sh
./install-home-manager.sh
```