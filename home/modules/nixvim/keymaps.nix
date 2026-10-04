{

	programs.nixvim = {
	    keymaps = [
	      {
		key = "<leader>x";
		action = "<cmd>Ex<CR>";
		mode = "n";
		options.desc = "Open netrw";
	      }
	      {
		key = "<C-u>";
		action = "<C-u>zz";
		mode = "n";
	      }
	      {
		key = "<C-d>";
		action = "<C-d>zz";
		mode = "n";
	      }
	    ];
	};

}
