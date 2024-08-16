return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "andymass/vim-matchup" },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "rust",
            "zig",
            "go",
            "javascript",
            "typescript",
            "python",
            "lua",

            "html",
            "css",
            "markdown",
            "markdown_inline",
            "svelte",
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
        matchup = {
            enable = true,
        },
    }
}
