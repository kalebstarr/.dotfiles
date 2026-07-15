{ pkgs, ... }:

{

  home.packages = with pkgs; [
    nixfmt
    stylua
    ruff
    prettierd
    clang-tools
    google-java-format
  ];

  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "ruff_format" ];
            rust = [ "rustfmt" ];
            cpp = [ "clang-format" ];
            nix = [ "nixfmt" ];
            html = [ "prettierd" ];
            css = [ "prettierd" ];
            javascript = [ "prettierd" ];
            zig = [ "zigfmt" ];
            go = [ "gofmt" ];
            clojure = [ "cljfmt" ];
            elixir = [ "mix" ];
            java = [ "google-java-format" ];
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
              async = true,
              lsp_format = "fallback",
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
