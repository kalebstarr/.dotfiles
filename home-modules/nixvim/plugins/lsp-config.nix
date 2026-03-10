{

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        clangd.enable = true;
        zls.enable = true;
        ruff.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        ts_ls.enable = true;
        elixirls.enable = true;
        gopls.enable = true;
      };
      keymaps = {
        lspBuf = {
          gd = "definition";
          K = "hover";
          "<leader>ca" = "code_action";
        };

        diagnostic = {
          "<leader>e" = "open_float";
        };
      };
    };
  };

}
