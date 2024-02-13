{ pkgs, ... }:

{
    home.packages = with pkgs; [
        eza # Apparently, this is the package, because exa is not maintained
    ];
    programs.zsh.shellAliases = {
        ls = "exa";
    };
}
