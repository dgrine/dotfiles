{ pkgs, ... }:

{
    programs.fzf = {
        enable = true;
        fileWidgetOptions = let 
            fzfPreviewCommand = "bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}";
             in [
            "--min-height 30 --preview-window right:60% --preview-window noborder --preview '(${fzfPreviewCommand}) 2> /dev/null'"
        ];
    };

    home = {
        packages = with pkgs; [
            fzf
        ];
        sessionVariables = {
            "FZF_DEFAULT_OPTS" = "--bind alt-j:down,alt-k:up";
        };
    };
}
