{ pkgs, ... }:

{

  imports = [
    ./common.nix

    ./modules/desktop/niri.nix

    ./modules/pi.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    proton-vpn
    openvpn

    base16-schemes
  ];

}
