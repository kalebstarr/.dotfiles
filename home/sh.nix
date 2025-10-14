{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
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
