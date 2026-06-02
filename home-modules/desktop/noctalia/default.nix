{ pkgs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    settings = ./settings.json;
  };
}
