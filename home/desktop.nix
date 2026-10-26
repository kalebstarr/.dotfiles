{ pkgs, ... }:

{
  imports = [
    ./modules/desktop/niri.nix
    ./modules/desktop/dux.nix
  ];

  home.packages = with pkgs; [
    brave-origin
    obsidian
    legcord
    proton-vpn
    openvpn
    kdePackages.dolphin
    papirus-folders

    base16-schemes
  ];
}
