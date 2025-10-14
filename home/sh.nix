{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
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
