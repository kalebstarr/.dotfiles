{ pkgs, ... }:

{
  # Niri starts XWayland on demand; no separate startup process is needed.
  home.packages = [ pkgs.xwayland-satellite ];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
