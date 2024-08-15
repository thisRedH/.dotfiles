return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
            --contrast = "", -- normal
            --contrast = "soft",
            contrast = "hard",
            overrides = {
                -- bg == normal mode background, works only in hard
                ColorColumn = { bg = "#282828" }
            },
        },
        init = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    }, {
        "folke/tokyonight.nvim",
    }
}
