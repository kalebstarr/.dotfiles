{

  programs.nixvim = {
    plugins = {
      harpoon = {
        enable = true;
        settings = {
          menu = {
            width = 60;
            height = 10;
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>a";
        action = "<cmd>lua require('harpoon'):list():add()<cr>";
      }
      {
        key = "<leader>h";
        action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>";
      }
      {
        key = "<leader>1";
        action = "<cmd>lua require('harpoon'):list():select(1)<cr>";
      }
      {
        key = "<leader>2";
        action = "<cmd>lua require('harpoon'):list():select(2)<cr>";
      }
      {
        key = "<leader>3";
        action = "<cmd>lua require('harpoon'):list():select(3)<cr>";
      }
      {
        key = "<leader>4";
        action = "<cmd>lua require('harpoon'):list():select(4)<cr>";
      }
    ];
  };

}
