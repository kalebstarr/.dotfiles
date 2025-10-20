{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
        };
      };

      telescope.enable = true;
      web-devicons.enable = true;
    };
  };

}
