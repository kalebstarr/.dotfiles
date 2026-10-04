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

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    base16-schemes
  ];

}
