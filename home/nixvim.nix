{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    plugins = {

      telescope.enable = true;
      web-devicons.enable = true;
    };
  };

}
