return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        disable_filetype = { "TelescopePrompt", "oil" },
        check_ts = true,
    }
}
