{

  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      number = true;
      relativenumber = true;
      termguicolors = true;
    };

    diagnostic.settings = {
      virtual_text = {
        prefix = "●";
        spacing = 2;
      };
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
        header = "";
        prefix = "";
      };
    };
  };

}
