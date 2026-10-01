{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
    lm_sensors
  ];

  hardware.bluetooth.enable = true;

  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;
    };
  };
  services.fwupd.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
  hardware.enableAllFirmware = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  # Dev with Arduino and IOT devices
  services.udev.packages = with pkgs; [
    platformio-core.udev
  ];
}
