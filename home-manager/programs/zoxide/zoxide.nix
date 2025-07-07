{ pkgs, ... }:

{
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };
    programs.zsh.initContent = ''
        # Ctrl + p to launch Zoxide
        function launch_zi () {
            __zoxide_zi
            zle reset-prompt
        }
        zle -N launch_zi
        bindkey '^p' launch_zi
    '';
}
