return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), {
                title = " Harp(.)(.)n ",
                title_pos = "center",
                border = "rounded"
            })
        end, {desc="harpoon: Open Menu"})
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc="harpoon: Add"})

        vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, {desc="harpoon: 1"})
        vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, {desc="harpoon: 2"})
        vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, {desc="harpoon: 3"})
        vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, {desc="harpoon: 4"})

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc="harpoon: 1"})
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc="harpoon: 2"})
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc="harpoon: 3"})
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc="harpoon: 4"})
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {desc="harpoon: 5"})
        vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, {desc="harpoon: 6"})

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.api.nvim_set_option_value(
                    "winhighlight",
                    "Normal:Normal,FloatBorder:Normal",
                    { win = cx.winid, scope = "local" }
                )
                vim.api.nvim_set_option_value(
                    "winblend",
                    vim.g.redh_winblend,
                    { win = cx.winid, scope = "local" }
                )
            end,
        })
    end
}
