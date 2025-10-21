{

  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "ruff" ];
            rust = [ "rustfmt" ];
            cpp = [ "clang-format" ];
            nix = [ "nixfmt" ];
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>gf";
        lua = true;
        mode = [
          "n"
          "v"
        ];
        action = ''
          function()
            require("conform").format({
              async = true,  -- Non-blocking
              lsp_fallback = true,  -- Use LSP if formatter fails
              timeout_ms = 1000,
            })
          end
        '';
        options = {
          desc = "Format buffer (conform.nvim)";
        };
      }
    ];
  };

}
