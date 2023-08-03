{ pkgs, ... }:

{
    programs.git = {
        enable = true;
    };
    programs.zsh.shellAliases = {
        gdt = "git difftool";
        gdtui = "git difftool --tool meld";
    };
    home = {
        file.".gitconfig".source = ../../../git/.gitconfig;
        packages = with pkgs; [
            icdiff
            meld
        ];
    };
}
