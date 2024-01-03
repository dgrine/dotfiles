{ pkgs, ... }:

{
    imports = [
#        ../zathura/zathura.nix
    ];

    home.packages = with pkgs; [
        latexrun
        texlab # Implementation of the LSP for completion, etc.
        texlive.combined.scheme-full
    ];
}
