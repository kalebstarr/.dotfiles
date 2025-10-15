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
      theme = "robbyrussell";

      plugins = [
        "git"
        "z"
        "fzf"
      ];
    };
  };

  programs.tmux = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

}
