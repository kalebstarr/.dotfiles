{ config, pkgs, ... }:

{

  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim
    zsh
    htop
    fastfetch
    brave
  ];

  programs.git = {
    enable = true;
    userName = "Kaleb";
    userEmail = "kaleb.starr@proton.me";
  };

  programs.zsh.enable = true;

  programs.home-manager.enable = true;

}
