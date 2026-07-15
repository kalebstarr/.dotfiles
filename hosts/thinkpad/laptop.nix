{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
    lm_sensors
  ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  services.tlp.enable = true;
  services.acpid.enable = true;
  hardware.enableAllFirmware = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  # Dev with Arduino and IOT devices
  services.udev.packages = with pkgs; [
    platformio-core.udev
  ];
}
