{ pkgs, ... }:

{

  imports = [
    ./common.nix

    ../home-modules/terminal/foot.nix

    ../home-modules/desktop/niri
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
    base16-schemes
  ];

  stylix.targets = {
    gtk.enable = true;
    gnome.enable = true;
  };

}
