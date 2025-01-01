return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", "diagnostics"},
                lualine_c = {{
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                    symbols = {
                        readonly = ""
                    }
                }},
                lualine_x = {"encoding", {"filetype", icons_enabled = false}},
                lualine_y = {"progress", "location"},
                lualine_z = {{"datetime", style = "%R"}}
            },
            extensions = {
                "lazy",
                "mason",
                "oil",
            },
        },
        init = function() vim.opt.showmode = false end,
    },
    {
        "j-hui/fidget.nvim",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        "folke/which-key.nvim",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        -- indentation guides
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = {
            scope = {
                enabled = false,
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function ()
            vim.api.nvim_set_hl(0, "RainbowRed",    {fg="#E06C75"})
            vim.api.nvim_set_hl(0, "RainbowYellow", {fg="#E5C07B"})
            vim.api.nvim_set_hl(0, "RainbowBlue",   {fg="#61AFEF"})
            vim.api.nvim_set_hl(0, "RainbowOrange", {fg="#D19A66"})
            vim.api.nvim_set_hl(0, "RainbowGreen",  {fg="#98C379"})
            vim.api.nvim_set_hl(0, "RainbowViolet", {fg="#C678DD"})
            vim.api.nvim_set_hl(0, "RainbowCyan",   {fg="#56B6C2"})
            require("rainbow-delimiters.setup").setup({
                highlight = {
                    "RainbowRed",
                    "RainbowYellow",
                    "RainbowBlue",
                    "RainbowOrange",
                    "RainbowGreen",
                    "RainbowViolet",
                    "RainbowCyan",
                },
            })
        end,
    },
    {
        "Djancyp/better-comments.nvim",
        event = { "BufReadPre", "InsertEnter" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("better-comment").Setup() -- Why is this uppercase Djancyp?!
        end,
    },
    {
        -- CSS colors
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },
}
