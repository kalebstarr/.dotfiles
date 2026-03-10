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
            html = [ "prettier" ];
            css = [ "prettier" ];
            javascript = [ "prettier" ];
            zig = [ "zigfmt" ];
            go = [ "gofmt" ];
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>gf";
        mode = [
          "n"
          "v"
        ];
        action.__raw = ''
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
