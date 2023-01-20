# Dotfiles

Development configuration files for:

* [Alacritty](https://github.com/alacritty/alacritty) — Fast, cross-platform, OpenGL terminal emulator
* [Git](https://git-scm.com) — Distributed version control system 
* [Neovim](https://neovim.io) — Hyperextensible Vim-based text editor
* [Tmux](https://github.com/tmux/tmux/wiki) — Terminal multiplexer
* [Vifm](https://vifm.info) — File manager with curses interface providing a Vim-like environment 
* [zsh](https://zsh.sourceforge.io) — Shell designed for interactive use

The configurations work on Linux and macOS.

![Example of Neovim, Vifm and zsh running inside a Tmux session within Alacritty](screenshot.png)

## Features

* Alacritty

    * Support for _special keys_ on macOS so that key-bindings (e.g. `Alt`) work as expected

* Git

    * Neovim as default editor
    * Merges and diffs via [Meld](https://meldmerge.org)

* Neovim

    * Lua-based configuration
    * Plugin management using [Packer](https://github.com/wbthomason/packer.nvim)
    * Bootstrapping of all plugins (installation upon first launch)

* Tmux

    * `<C-a>` as prefix
    * Plugin management using [tpm](https://github.com/tmux-plugins/tpm)
    * Startup sessions are locally customizable 

* Vifm

    * Change current shell directory to navigated directory

* zsh

    * [oh-my-zsh](https://ohmyz.sh) based configuration
    * Vim-style editing
    * Support for [fzf](https://github.com/junegunn/fzf)
    * Extensibility via `~/.zshrc_local`


## Dependencies

* [Git](https://git-scm.com) — Distributed version control system 
* [GNU Stow](https://www.gnu.org/software/stow/) — Symlink farm manager

And of course the software related to the configuration packages of interest.

## Installation

```
git clone git@gitlab.com:dgrine/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

To install a specific package use `./install.sh <package>`

## Uninstall

```
cd ~/dotfiles
./uninstall.sh
```

To uninstall a specific package use `./uninstall.sh <package>`
