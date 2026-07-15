{

  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      nixd = {
        enable = true;
        packageFallback = true;
      };

      clangd = {
        enable = true;
        packageFallback = true;
      };

      zls = {
        enable = true;
        packageFallback = true;
      };

      ruff = {
        enable = true;
        packageFallback = true;
      };

      pyright = {
        enable = true;
        packageFallback = true;
      };

      rust_analyzer = {
        enable = true;
        packageFallback = true;

        installCargo = false;
        installRustc = false;
      };

      ts_ls = {
        enable = true;
        packageFallback = true;
      };

      elixirls = {
        enable = true;
        packageFallback = true;
      };

      lua_ls = {
        enable = true;
        packageFallback = true;
      };

      jdtls = {
        enable = true;
        packageFallback = true;
      };
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

}
