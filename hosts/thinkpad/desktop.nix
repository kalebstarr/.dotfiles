{ ... }:

{
  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;
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
