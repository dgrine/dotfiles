{
    xdg.configFile."alacritty".source = ../../../alacritty/.config/alacritty;
    programs.zsh.profileExtra = ''
        export TITLE="Alacritty"
    '';
}
