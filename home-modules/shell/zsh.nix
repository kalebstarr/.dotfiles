{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
        "z"
        "fzf"
      ];
    };

    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

}
