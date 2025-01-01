return {
    "akinsho/toggleterm.nvim",
    opts = {
        float_opts = {
            title_pos = "center",
            border = "curved",
            winblend = vim.g.redh_winblend,
        },
        on_create = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<CMD>close<CR>", {noremap = true, silent = true})
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<ESC>", "<CMD>close<CR>", {noremap = true, silent = true})

            term.float_opts.winblend = vim.g.redh_winblend
            term:__set_options()

            -- if term:is_float() then
            --     vim.api.nvim_set_option_value(
            --         "winblend",
            --         vim.g.redh_winblend,
            --         { win = term.window, scope = "local" }
            --     )
            -- end
        end,
    },
    init = function()
        vim.keymap.set("n", "<leader>ts", "<CMD>ToggleTerm name=' SplitTerm ' direction=horizontal size=13<CR>", {desc="terminal: Open split"})
        vim.keymap.set("n", "<leader>tt", "<CMD>ToggleTerm name=' FloatTerm ' direction=float<CR>", {desc="terminal: Open floating"})
    end,
}
