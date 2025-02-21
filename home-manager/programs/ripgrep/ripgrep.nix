{ pkgs, ... }:

{
    programs.ripgrep = {
        enable = true;
        arguments = [
            "--colors=line:style:bold"
            "--hidden"
            "--glob=!*.git"
            "--max-columns-preview"
        ];
    };

    home.packages = with pkgs; [
        ripgrep
    ];
}

