{ pkgs, ... }:

{
    imports = [
        ./alacritty/alacritty.nix
        ./bat/bat.nix
        ./btop/btop.nix
        ./fzf/fzf.nix
        ./git/git.nix
        ./gnu-sed/gnu-sed.nix
        ./neofetch/neofetch.nix
        ./neovim/neovim.nix
        ./pandoc/pandoc.nix
        ./python3/python3.nix
        ./ripgrep/ripgrep.nix
        ./sshfs/sshfs.nix
        ./tldr/tldr.nix
        ./tmux/tmux.nix
        ./vifm/vifm.nix
        ./zoxide/zoxide.nix
        ./zsh/zsh.nix
    ];
}
