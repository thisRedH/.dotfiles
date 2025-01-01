return {
    "stevearc/oil.nvim",
    priority = 100,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        columns = {
            "icon",
            "permissions",
            "size",
        },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                return name == ".git"
            end,
        },
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
            ["<C-r>"] = "actions.refresh",
            ["<F5>"] = "actions.refresh",
        },
    },
    init = function()
        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", {desc="oil: Open"})
    end
}
