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

        diagnostics = {
          virtualText = {
            prefix = "●";
            spacing = 2;
          };
          signs = true;
          underline = true;
          updateInInsert = false;
          severitySort = true;
          float = {
            border = "rounded";
            source = "if_many";
            header = "";
            prefix = "";
          };
        };

      };

      telescope.enable = true;
      treesitter = {
        enable = true;
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
