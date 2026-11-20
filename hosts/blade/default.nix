{ ... }:

{
  imports = [
    # Stub until install day; replace with the generated one.
    ./hardware-configuration.nix
    ./razer.nix
    ../modules/laptop.nix
  ];

  networking.hostName = "blade";

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Disk swap for hibernation
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # resume_offset: first physical_offset from `filefrag -v /var/lib/swapfile`
  boot.resumeDevice = "/dev/disk/by-uuid/5227823e-e173-41c4-818b-1f462ac6540a";
  boot.kernelParams = [ "resume_offset=246822912" ];

  # First NixOS release installed on this machine; don't change it after install.
  system.stateVersion = "26.11";
}
