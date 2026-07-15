# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "kaleb";
  wsl.usbip.enable = true;

  networking.hostName = "wsl";

  services.openssh.enable = false;

  programs.dconf.enable = true;

  system.stateVersion = "25.05";
}
