vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { desc = "Explore files" })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
