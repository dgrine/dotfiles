{ pkgs, config, ... }:

{
    home.packages = with pkgs; [
        tree-sitter
    ];
}

