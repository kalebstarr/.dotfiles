{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
    ./desktop.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "thinkpad";
    networkmanager.enable = true;
  };

  console.keyMap = "de";
  services.xserver = {
    enable = false;
    xkb.layout = "de";
  };

  services.displayManager = {
    defaultSession = "niri";
    dms-greeter = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
      compositor.name = "niri";
      configHome = "/home/kaleb";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.05";
}
