return {
    "nvim-telescope/telescope.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            layout_config = {
                prompt_position = "top",
            },
            sorting_strategy = "ascending",
        },
    },
    init = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep)
        vim.keymap.set("n", "<leader>fb", function() builtin.current_buffer_fuzzy_find({ skip_empty_lines = true, }) end)
        vim.keymap.set("n", "<leader>fc", builtin.commands)
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
        vim.keymap.set("n", "<leader>fm", function() builtin.man_pages({sections = {"1","2","3"}}) end)
    end,
}
