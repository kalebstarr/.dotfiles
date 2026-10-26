{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    playerctl
    pavucontrol
    pamixer
    xwayland-satellite
    papirus-icon-theme
    bibata-cursors
  ];

  programs = {
    niri.enable = true;
    dux-shell.enable = true;
    dux-search.enable = true;
  };

  services.displayManager.dux-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = config.users.users.kaleb.home;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [
      "gnome"
      "gtk"
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;
}
