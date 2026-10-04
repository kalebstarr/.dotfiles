{ pkgs, ... }:

{

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/id_ed25519";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      };
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;

}
