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
  };

}
