{ pkgs, ... }:

{
    programs.tmux = {
        enable = true;
    };
    home = {
        file.".tmux.conf".source = ../../../tmux/.tmux.conf;
        packages = with pkgs; [
            tmux
        ];
    };
}
