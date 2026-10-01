{ pkgs, ... }:

{

  imports = [
    ./common.nix

    ../home-modules/desktop/dms.nix

    ../home-modules/desktop/niri

    ../home-modules/pi.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    proton-vpn
    openvpn
    nautilus
    pavucontrol

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    base16-schemes
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "brave-browser.desktop" ];
      "x-scheme-handler/http" = [ "brave-browser.desktop" ];
      "x-scheme-handler/https" = [ "brave-browser.desktop" ];
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  stylix = {
    autoEnable = false;
    targets = {
      tmux.enable = true;
      nixvim.enable = true;
      fontconfig.enable = true;
      gtk.enable = false;
      gnome.enable = false;
      ghostty.enable = false;
    };
  };

  programs.ghostty.settings = {
    theme = "dankcolors";
    font-family = "FiraCode Nerd Font";
    font-size = 12;
    background-opacity = 0.9;
  };
}
