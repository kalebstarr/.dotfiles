{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ brightnessctl ];

  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
  };

  services = {
    accounts-daemon.enable = true;
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    upower.enable = true;
    logind.settings.Login.HandlePowerKey = "suspend";

    udev.packages = with pkgs; [
      platformio-core.udev
    ];
  };
}
