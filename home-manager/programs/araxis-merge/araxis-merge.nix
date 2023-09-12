{ pkgs, ... }:

{
    home = {
        sessionPath = ["/Applications/Araxis\ Merge.app/Contents/Utilities"];
    };
    programs = {
        zsh = {
            shellAliases = {
                gdtui = "git difftool --tool compare";
            };
        };
    };
}

