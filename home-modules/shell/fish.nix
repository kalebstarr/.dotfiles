{ pkgs, ... }:

{

  programs.fish = {
    enable = true;
    shellAliases = {
      la = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };

    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };

}
