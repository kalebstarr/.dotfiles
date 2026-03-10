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
  ];

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };

    plugins = {
      web-devicons.enable = true;
    };
  };

}
