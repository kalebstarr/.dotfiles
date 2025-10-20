return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "master",
        build = ":TSUpdate",

        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "python",
                    "cpp",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
