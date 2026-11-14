# Shared base for the laptops (thinkpad, blade): boot, nix housekeeping,
# locale/keyboard, gaming and laptop services.
{ pkgs, ... }:

{
  imports = [ ./desktop.nix ];

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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  console.keyMap = "de";
  services.xserver.xkb.layout = "de";

  services.xserver.enable = false;

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;

  services.acpid.enable = true;
  services.upower.enable = true;
  services.resolved.enable = true;

  # Dev with Arduino and IOT devices
  services.udev.packages = with pkgs; [
    platformio-core.udev
  ];
}
