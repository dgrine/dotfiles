{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        coc = {
            enable = true;
        };
        defaultEditor = true;
    };

    xdg.configFile."nvim" = {
        source = ../../../nvim/.config/nvim;
        recursive = true;
    };
}

