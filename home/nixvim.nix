{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";

    keymaps = [
      {
        key = "<leader>x";
        action = "<cmd>Ex<CR>";
        options.desc = "Open netrw";
      }
    ];

    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
        };
      };

      telescope.enable = true;
      treesitter = {
        enable = true;
        folding = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
          auto_install = true;
        };
      };
      web-devicons.enable = true;
    };

    extraConfigLua = ''
      vim.opt.relativenumber = true
    '';
  };

}
