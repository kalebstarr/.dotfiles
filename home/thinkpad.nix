{ pkgs, ... }:

{

  imports = [
    ./common.nix

    ./modules/desktop/niri.nix
    ./modules/desktop/dms.nix

    ./modules/pi.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    proton-vpn
    openvpn
    kdePackages.dolphin
    papirus-folders

    base16-schemes
  ];

}
