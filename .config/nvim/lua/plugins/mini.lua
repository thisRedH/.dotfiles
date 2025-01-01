return {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mini.ai").setup()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.bracketed").setup()

        require("mini.cursorword").setup()
        vim.api.nvim_create_autocmd("Filetype", {
            pattern = {"oil", "telescope", "mason", "lazy", "terminal"},
            callback = function()
                vim.b.minicursorword_disable = true
            end,
        })

        require("mini.map").setup({
            symbols = {
                encode = require("mini.map").gen_encode_symbols.dot("3x2"),
            },
        })
        vim.keymap.set("n", "<leader>mm", require("mini.map").toggle, {desc="mini.map: Toggle"})
    end
}
