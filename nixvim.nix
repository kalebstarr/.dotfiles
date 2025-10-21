{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
      enable = true;

      settings = {
        flavour = "mocha";
      };
    };

    plugins = {
      web-devicons.enable = true;
    };
  };

}
