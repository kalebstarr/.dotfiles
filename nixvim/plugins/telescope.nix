{

  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions.ui-select.enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
      };
    };
  };

}
