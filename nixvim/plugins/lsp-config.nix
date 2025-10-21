{

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        clangd.enable = true;
        zls.enable = true;
        ruff.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
      keymaps = {
        lspBuf = {
          gd = "definition";
          K = "hover";
          "<leader>ca" = "code_action";
        };
      };
    };
  };

}
