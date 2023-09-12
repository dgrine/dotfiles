{ pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            meld
        ];
    };
    programs = {
        zsh = {
            shellAliases = {
                gdtui = "git difftool --tool meld";
            };
        };
    };
}

