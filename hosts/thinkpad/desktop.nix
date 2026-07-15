{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    playerctl
    pavucontrol
    pamixer
  ];

  programs.niri.enable = true;

  security.pam.services.swaylock = { };

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
}
