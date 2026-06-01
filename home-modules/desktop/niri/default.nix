{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaybg
    wofi
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
