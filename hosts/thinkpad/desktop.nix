{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    foot
    uwsm
    xwayland-satellite
    playerctl
    pavucontrol
    pipewire
    wireplumber
    pamixer
  ];

  programs.niri.enable = true;

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
