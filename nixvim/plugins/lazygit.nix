{

  programs.nixvim = {
    plugins = {
      lazygit = {
        enable = true;
      };
    };

    keymaps = [
      {
        key = "<leader>lg";
        action = ":LazyGit<CR>";
        mode = "n";
        options.desc = "LazyGit";
      }
    ];
  };

}
