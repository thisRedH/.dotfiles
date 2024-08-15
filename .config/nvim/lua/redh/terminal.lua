vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader>ts", function ()
    vim.cmd.new()
    vim.api.nvim_win_set_height(0, 12)
    vim.cmd.term()
end, { desc = "Open split terminal" })

-- floating terminal
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(args)
        if not args.data == "nui.nvim" then
            return
        end

        vim.keymap.set("n", "<leader>tt", function ()
            local popup = require("nui.popup")({
                enter = true,
                focusable = true,
                border = {
                    style = "rounded",
                    text = {
                        top = " Terminal ",
                    },
                },
                position = "50%",
                size = {
                    width = "90%",
                    height = "80%",
                },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:Normal",
                },
            })

            popup:mount()
            vim.cmd.term()
            vim.cmd("startinsert")

            popup:on("BufLeave", function()
                popup:unmount()
            end)

            popup:map("n", "<esc>", function()
                print("esccvasdfg")
                popup:unmount()
            end, { noremap = true })
        end, { desc = "Open floating terminal" })
    end,
})
