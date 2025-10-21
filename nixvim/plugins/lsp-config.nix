{

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
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
