{ inputs, pkgs, ... }:

{

  imports = [
    ./common.nix

    ../home-modules/desktop/niri
    inputs.dms.homeModules.dank-material-shell

    ../home-modules/pi.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    proton-vpn
    openvpn
    godot

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    material-symbols
    papirus-icon-theme
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      configVersion = 18;
      acLockTimeout = 900;
      acMonitorTimeout = 1200;
      batteryLockTimeout = 900;
      batteryMonitorTimeout = 1200;
      batteryLowThreshold = 20;
      batteryNotifyLow = true;
      batteryCriticalThreshold = 10;
      batteryNotifyCritical = true;
      lockBeforeSuspend = true;
    };

    session = {
      configVersion = 4;
      wallpaperPath = toString ../wallpapers/Sunset.png;
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
