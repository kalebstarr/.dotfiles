{ inputs, ... }:

{

  imports = [

    inputs.nixvim.homeModules.nixvim
    ./keymaps.nix
    ./options.nix
    ./plugins/treesitter.nix
    ./plugins/lsp-config.nix
    ./plugins/telescope.nix
    ./plugins/comment.nix
    ./plugins/completions.nix
    ./plugins/lazygit.nix
    ./plugins/lualine.nix
    ./plugins/formatters.nix
    ./plugins/todo-comments.nix
    ./plugins/debugger
    ./plugins/debugger/python.nix
    ./plugins/harpoon.nix
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs.source = inputs.nixpkgs;

    plugins = {
      web-devicons.enable = true;
    };
  };

}
