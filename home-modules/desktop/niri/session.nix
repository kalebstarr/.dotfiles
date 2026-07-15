{ pkgs, ... }:

let
  lock = "${pkgs.swaylock}/bin/swaylock -f";
  powerOff = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  powerOn = "${pkgs.niri}/bin/niri msg action power-on-monitors";
in
{
  programs.fuzzel.enable = true;
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      datestr = "%A, %d %B";
      effect-blur = "12x3";
      effect-vignette = "0.25:0.65";
      fade-in = 0.25;
      font = "FiraCode Nerd Font";
      indicator = true;
      indicator-caps-lock = true;
      indicator-idle-visible = true;
      indicator-radius = 110;
      indicator-thickness = 8;
      show-failed-attempts = true;
      show-keyboard-layout = true;
      timestr = "%H:%M";
    };
  };
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
