{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./razer.nix
    ../modules/desktop.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # R7: systemd-boot, no Secure Boot (the BIOS rejects custom keys)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "blade";
  networking.networkmanager.enable = true;

  console.keyMap = "de";
  services.xserver.xkb.layout = "de";

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    brightnessctl
    acpi
    lm_sensors
  ];

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  services.acpid.enable = true;
  services.upower.enable = true;
  services.resolved.enable = true;

  # Dev with Arduino and IOT devices
  services.udev.packages = with pkgs; [
    platformio-core.udev
  ];

  # First NixOS release installed on this machine; don't change after install.
  system.stateVersion = "26.11";
}
