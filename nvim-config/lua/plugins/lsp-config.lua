return {
	{
		"mason-org/mason.nvim",

		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",

		config = function()
			require("mason-lspconfig").setup({
				-- ensure_installed = {
				-- 	"lua_ls",
				-- 	"clangd",
				-- 	"zls",
				-- 	"rust_analyzer",
				-- 	"ts_ls",
				--  "ruff",
				-- },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", {
				-- capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
