{ config, pkgs, ... }:

{

  imports = [
    ./home/hyprland.nix
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim
    zsh
    htop
    fastfetch
  ];

  programs.git = {
    enable = true;
    userName = "Kaleb";
    userEmail = "kaleb.starr@proton.me";
  };

  programs.zsh.enable = true;

  programs.waybar = {
    enable = true;
  };

  programs.home-manager.enable = true;

}
