return {
    "stevearc/oil.nvim",
    priority = 100,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        dirty_oil = false
        opt_columns = {
            "icon",
            "permissions",
            "size",
        }

        require("oil").setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            columns = opt_columns,
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
        })

        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

--[[
        vim.api.nvim_create_autocmd("InsertEnter", {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "oil" then
                    pcall(require("oil").set_columns, {"icon"})
                end
            end
        })
        vim.api.nvim_create_autocmd("ModeChanged", { -- will also be called on <C-c>
            pattern = "i*:*",
            callback = function()
                if vim.bo.filetype == "oil" and not dirty_oil then
                    pcall(require("oil").set_columns, opt_columns)
                end
            end
        })
        vim.api.nvim_create_autocmd("InsertChange", {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "oil" then
                    dirty_oil = true
                    pcall(require("oil").set_columns, {"icon"})
                end
            end
        })
        vim.api.nvim_create_autocmd("BufWrite", {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "oil" then
                    dirty_oil = false
                    pcall(require("oil").set_columns, opt_columns)
                end
            end
        })
--]]
    end
}
