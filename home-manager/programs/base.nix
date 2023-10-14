{ pkgs, ... }:

{
    imports = [
        ./alacritty/alacritty.nix
        ./bat/bat.nix
        ./btop/btop.nix
        ./fzf/fzf.nix
        ./ghostscript/ghostscript.nix
        ./git/git.nix
        ./gnu-sed/gnu-sed.nix
        ./neofetch/neofetch.nix
        ./neovim/neovim.nix
        ./pandoc/pandoc.nix
        ./python3/python3.nix
        ./readline/readline.nix
        ./ripgrep/ripgrep.nix
        ./sshfs/sshfs.nix
        ./tldr/tldr.nix
        ./tmux/tmux.nix
        ./vifm/vifm.nix
        ./zoxide/zoxide.nix
        ./zsh/zsh.nix
    ];
}
