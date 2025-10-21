{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
      web-devicons.enable = true;
    };
  };

}
