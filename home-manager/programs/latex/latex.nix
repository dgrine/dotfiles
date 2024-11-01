{ pkgs, ... }:

{
    imports = [
#        ../zathura/zathura.nix
    ];

    home.packages = with pkgs; [
        latexrun
        pandoc
        texlab # Implementation of the LSP for completion, etc.
        texlive.combined.scheme-full
    ];
}
