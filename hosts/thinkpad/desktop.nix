{ pkgs, ... }:

{
  programs.niri.enable = true;

  environment = {
    systemPackages = with pkgs; [ xwayland-satellite ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
}
