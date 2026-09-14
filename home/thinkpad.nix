{ inputs, pkgs, ... }:

{

  imports = [
    ./common.nix

    ../home-modules/desktop/niri
    inputs.dms.homeModules.dank-material-shell

    ../home-modules/pi.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    proton-vpn
    openvpn
    godot

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    material-symbols
    papirus-icon-theme
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
