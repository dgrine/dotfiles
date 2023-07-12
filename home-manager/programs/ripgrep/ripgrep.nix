{ pkgs, ... }:

{
    programs.ripgrep = {
        enable = true;
        arguments = [
            "--colors=line:style:bold"
            "--hidden"
            "--max-columns-preview"
        ];
    };

    home.packages = with pkgs; [
        ripgrep
    ];
}

