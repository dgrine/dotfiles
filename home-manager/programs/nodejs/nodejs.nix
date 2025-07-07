{ pkgs, ... }:

{
    home = {
        # file.".npmrc".source = ../../../npm/.npmrc;
        packages = with pkgs; [
            nodejs
            yarn
            eslint_d
        ];
    };
    programs.zsh = {
        oh-my-zsh.plugins = ["npm"];
        initContent = ''
            export PATH=$PATH:~/.npm-packages/bin
        '';
    };
}
