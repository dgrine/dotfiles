{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        coc = {
            enable = true;
        };
    };

    xdg.configFile."nvim" = {
        source = ../../../nvim/.config/nvim;
        recursive = true;
    };

    home.packages = with pkgs; [
        black
    ];
}

