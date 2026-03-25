{ pkgs, ... }:

{

  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom.d;
  };

  services.emacs.enable = true;

}
