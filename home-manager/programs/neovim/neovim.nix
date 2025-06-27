{ pkgs, config, ... }:

{
    imports = [ 
        ../lua/lua-5.nix
        ../lua/luarocks.nix
        ../black/black.nix
        ../tree-sitter/tree-sitter.nix
    ];
    programs = {
        neovim = {
            enable = true;
            defaultEditor = true;
            coc = {
                enable = true;
            };
        };
        zsh.shellAliases = {
            e = "nvim";
        };
    };
    xdg.configFile."nvim" = {
        source = ../../../nvim/.config/nvim;
        recursive = true;
    };
}

