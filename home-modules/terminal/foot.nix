{ pkgs, ... }:

{

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
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

}
