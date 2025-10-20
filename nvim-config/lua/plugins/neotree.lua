return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Neotree" },
    keys = {
        { "<C-n>", ":Neotree filesystem toggle left<CR>", desc = "Neo-tree" },
    },

    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = { enabled = false },
                hijack_netrw_behavior = "open_default",
            },
        })
    end,
}
