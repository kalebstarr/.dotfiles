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
        font-family = "FiraCode Nerd Font";
        font-size = 12;
        window-padding-x = 10;
        window-padding-y = 10;
        cursor-style = "block";
        background = "1e1e2e";
        foreground = "cdd6f4";
      };
    };
  };

}
