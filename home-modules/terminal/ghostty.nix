{ pkgs, ... }:

{

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
    };
  };

}
