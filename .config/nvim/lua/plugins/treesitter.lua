return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "lua",

            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "dockerfile",
            "gitignore",
            "vimdoc",

            "json",
            "yaml",
        },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        matchup = { -- vim-matchup
            enable = true,
            disable_virtual_text = true,
        },
    }
}
