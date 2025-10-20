{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";

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

    extraConfigLua = ''
      vim.opt.relativenumber = true
    '';
  };

}
