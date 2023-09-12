{ pkgs, ... }:

{
    home.packages = with pkgs; [
        tldr
    ];
    programs.zsh.initExtra = ''
        # Ctrl + f to launch tldr
        function launch_tldr () {
            tldr --list | sort | fzf --preview "tldr {1}" --preview-window=right,60% | xargs tldr
            zle reset-prompt
        }
        zle -N launch_tldr
        bindkey '^f' launch_tldr
    '';
}
