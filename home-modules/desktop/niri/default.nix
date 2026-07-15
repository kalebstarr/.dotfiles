{ config, pkgs, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;
  niriConfig = builtins.replaceStrings
    [
      "@base0D@"
      "@base03@"
      "@wallpaper@"
    ]
    [
      colors.base0D
      colors.base03
      (toString config.stylix.image)
    ]
    (builtins.readFile ./config.kdl);
in

{
  imports = [
    ../waybar.nix
    ./session.nix
  ];

  home.packages = with pkgs; [
    swaybg
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".text = niriConfig;
}
