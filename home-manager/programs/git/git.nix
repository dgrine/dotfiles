{ pkgs, ... }:

{
    home = {
        file.".gitconfig".source = ../../../git/.gitconfig;
        packages = with pkgs; [
            icdiff
        ];
    };
    programs = {
        git = {
            enable = true;
        };
        zsh = {
            shellAliases = {
                gdt = "git difftool";
            };
            oh-my-zsh.plugins = ["git"];
        };
    };
}
