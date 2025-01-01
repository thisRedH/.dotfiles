return {
    {"nvim-lua/plenary.nvim", config = false},
    {"MunifTanjim/nui.nvim", config = false},
    {"nvim-tree/nvim-web-devicons", config = false},

    {"dstein64/vim-startuptime"},
    -- {"Sam-programs/cmdline-hl.nvim", opts = {}}

    {"mbbill/undotree", event = { "VeryLazy" }},
    {"christoomey/vim-tmux-navigator"},


    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "InsertEnter" },
        opts = {},
    },

    {
        "tris203/precognition.nvim",
        event = { "VeryLazy" },
        opts = {
            startVisible = false,
        },
    },

    {
        "folke/lazydev.nvim",
        dependencies = { "Bilal2453/luvit-meta" },
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "Bilal2453/luvit-meta",
        lazy = true
    },

    {
        "Wansmer/treesj",
        event = { "VeryLazy" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { use_default_keymaps = false },
        init = function()
            vim.keymap.set("n", "<leader>tj", require("treesj").toggle, {desc="treesj: Toggle"})
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            disable_filetype = { "TelescopePrompt", "oil" },
            check_ts = true,
        }
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "andymass/vim-matchup",
        event = { "VeryLazy" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
