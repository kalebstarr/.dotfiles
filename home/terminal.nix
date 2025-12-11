{ pkgs, ... }:

{

  programs = {
    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "FiraCode Nerd Font";
          dpi-aware = "yes";
          pad = "10x10";
        };
        cursor = {
          style = "beam";
          blink = "yes";
        };
        colors = {
          background = "1e1e2e";
          foreground = "cdd6f4";
        };
        bell = {
          urgent = "no";
          notify = "no";
        };
        scrollback = {
          lines = 10000;
        };
      };
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        font-family = "FiraCode Nerd Font";
        font-size = 12;
        window-padding-x = 10;
        window-padding-y = 10;
        cursor-style = "block";
      };
    };
  };

  xdg.configFile."ghostty/themes/catppuccin-mocha".text = ''
    background = 1e1e2e
    foreground = cdd6f4
    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#f5c2e7
    palette = 6=#94e2d5
    palette = 7=#bac2de
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#f5c2e7
    palette = 14=#94e2d5
    palette = 15=#a6adc8
  '';

}
