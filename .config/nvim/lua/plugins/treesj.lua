return {
    "Wansmer/treesj",
    keys = {"<leader>tj"},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
        })
        vim.keymap.set("n", "<leader>tj", require("treesj").toggle, { desc = "treesj toggle"})
    end,
}
