{ pkgs, config, lib, ... }:

{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        initContent = ''
            mkdir -p $HOME/dev/tmp/
            mkdir -p $HOME/dev/bin/
            fpath=("$HOME/.zfunc" $fpath)
            autoload -Uz compinit
            compinit
        '';
        oh-my-zsh = {
            enable = true;
            plugins = [
                "vi-mode"
                "z"
            ];
            theme = "gianu";
        };

        # TODO: Work-around for the fact that zsh does not work well with PATH
        # changes
        # See https://github.com/nix-community/home-manager/issues/2991
        profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
            export PATH="$PATH''${PATH:+:}${lib.concatStringsSep ":" config.home.sessionPath}"
            export PATH="$PATH:$HOME/dev/bin:$HOME/.local/bin"
            export DISABLE_AUTO_TITLE="true"
        '';
    };
}
