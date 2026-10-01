{ ... }:

{
  programs.niri.enable = true;

  # Monitoring, clipboard paste and network controls are built in.
  # The module supplies matugen/cava; no calendar backend is installed.
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };
  programs.dsearch.enable = true;
  security.pam.services.dms = { };

  # Niri supplies GNOME/GTK portals and the Nautilus file chooser.
  # TLP's profile daemon supplies the DMS power-profile interface.
  services.power-profiles-daemon.enable = false;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;
}
