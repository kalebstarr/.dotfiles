{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      emacs = "emacs -nw";
      ect = "emacsclient -t";
      ecg = "emacsclient -c";
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
