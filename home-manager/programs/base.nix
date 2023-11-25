{ pkgs, ... }:

{
    imports = [
        ./alacritty/alacritty.nix
        ./bat/bat.nix
        ./btop/btop.nix
        ./fzf/fzf.nix
        ./git/git.nix
        ./gnu-sed/gnu-sed.nix
        ./jq/jq.nix
        ./neofetch/neofetch.nix
        ./neovim/neovim.nix
        ./latex/latex.nix
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
