{ pkgs, ... }:

{
    home = {
        # file.".npmrc".source = ../../../npm/.npmrc;
        packages = with pkgs; [
            nodejs
            yarn
        ];
    };
    programs.zsh = {
        oh-my-zsh.plugins = ["npm"];
        initExtra = ''
            export PATH=$PATH:~/.npm-packages/bin
        '';
    };
}
