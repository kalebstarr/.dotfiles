{ pkgs, ... }:

{

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 12;
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
    };
  };

}
