{ lib, ... }:

{

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*".AddKeysToAgent = "yes";
  };

  # Real file, not a store symlink: ssh rejects it inside appimage-run's user namespace.
  home.file.".ssh/config".target = ".ssh/config.hm";
  home.activation.sshConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run install -m 600 "$HOME/.ssh/config.hm" "$HOME/.ssh/config"
  '';

  services.ssh-agent.enable = true;

}
