{ ... }:

{
  imports = [
    # Stub until install day; replace with the generated one.
    ./hardware-configuration.nix
    ./razer.nix
    ../modules/laptop.nix
  ];

  networking.hostName = "blade";

  # First NixOS release installed on this machine; don't change it after install.
  system.stateVersion = "26.11";
}
