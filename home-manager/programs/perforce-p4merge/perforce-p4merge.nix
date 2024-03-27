{ pkgs, ... }:

{
    home = {
        sessionPath = ["/Applications/p4merge.app/Contents/MacOS/"];
    };
    programs = {
        zsh = {
            shellAliases = {
                gdtui = "git difftool --tool p4merge";
            };
        };
    };
}

