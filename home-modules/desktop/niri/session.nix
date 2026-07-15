{ pkgs, ... }:

let
  lock = "${pkgs.swaylock}/bin/swaylock -f";
  powerOff = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  powerOn = "${pkgs.niri}/bin/niri msg action power-on-monitors";
in
{
  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;
  services.mako.enable = true;
  services.swayosd.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = lock;
      }
      {
        timeout = 1200;
        command = powerOff;
        resumeCommand = powerOn;
      }
    ];
    events = {
      before-sleep = lock;
      lock = lock;
    };
  };
}
