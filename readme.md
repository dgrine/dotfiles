# Dotfiles

Development configuration files for:

* [alacritty](https://github.com/alacritty/alacritty) — Fast, cross-platform, OpenGL terminal emulator
* [git](https://git-scm.com) — Distributed version control system 
* [neovim](https://neovim.io) — Hyperextensible Vim-based text editor
* [tmux](https://github.com/tmux/tmux/wiki) — Terminal multiplexer
* [vifm](https://vifm.info) — File manager with curses interface providing a Vim-like environment 
* [zsh](https://zsh.sourceforge.io) — Shell designed for interactive use

The configurations are maintained for Ubuntu (22.04 LTS) and macOS (Ventura) devices,
but should work on any Linux or macOS system.

![Example of Neovim, Vifm and zsh running inside a Tmux session within Alacritty](screenshot.png)

## Features

The configuration files provide a modern _terminal-only_ development environment
that is heavily focused on _vim-style_ navigation, command line editing, and
programming.

* Alacritty

    * Support for _special keys_ on macOS so that key-bindings (e.g. `Alt`) work as expected

* Git

    * Neovim as default editor
    * Merges and diffs

        * GUI version using [Meld](https://meldmerge.org)
        * Console version using [icdiff](https://github.com/jeffkaufman/icdiff)

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
    * Support for [bat](https://github.com/sharkdp/bat)
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

## Recommended Software

* [alacritty](https://github.com/alacritty/alacritty) — Fast, cross-platform OpenGL terminal emulator
* [bat](https://github.com/sharkdp/bat) — Cat clone with syntax highlighting and Git integration
* [exa](https://github.com/ogham/exa) — Modern replacement for `ls`
* [fzf](https://github.com/junegunn/fzf) — General-purpose command-line fuzzy finder
* [git](https://git-scm.com) — Distributed version control system 
* [icdiff](https://github.com/jeffkaufman/icdiff) — Command-line diff tool
* [meld](https://meldmerge.org) — Visual diff and merge tool
* [neovim](https://neovim.io) — Hyperextensible Vim-based text editor
* [ripgrep](https://github.com/BurntSushi/ripgrep) — Fast, line-oriented search tool for regex patterns
* [tmux](https://github.com/tmux/tmux/wiki) — Terminal multiplexer
* [vifm](https://vifm.info) — File manager with curses interface providing a Vim-like environment 
* [zsh](https://zsh.sourceforge.io) — Shell designed for interactive use
