local is_image = function(path)
    local image_extensions = {"jpg", "jpeg", "png", "webp", "gif"}
    local split_path = vim.split(path:lower(), '.', {plain=true})
    local extension = split_path[#split_path]
    return vim.tbl_contains(image_extensions, extension)
end

return {
    "nvim-telescope/telescope.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
        opts.defaults = {
            layout_config = {
                prompt_position = "top",
            },
            sorting_strategy = "ascending",
            winblend = function()
                return vim.g.redh_winblend
            end,
            preview = {
                mime_hook = function(filepath, bufnr, o)
                    local function term_display(cmd)
                        print(cmd)
                        local chan = vim.api.nvim_open_term(bufnr, {})

                        local function send_output(_, data, _)
                            for _, d in ipairs(data) do
                                -- vim.fn.chansend(chan, d .. "\r\n")
                                vim.api.nvim_chan_send(chan, d .. "\r\n")
                            end
                        end

                        vim.fn.jobstart(cmd, {
                            on_stdout=send_output,
                            stdout_buffered=true,
                            pty=true,
                        })
                    end

                    if is_image(filepath) then
                        vim.schedule(function ()
                        term_display(string.format(
                            "chafa -w 9 -O 0 -c full -p on -s '%dx%d' '%s'",
                            vim.api.nvim_win_get_width(o.winid) - 2,
                            vim.api.nvim_win_get_height(o.winid) - 2,
                            filepath
                        ))
                        end)
                    else
                        term_display(string.format(
                            "xxd -a -u -R 'always' -g 1 -l 15000 %s",
                            filepath
                        ))
                    end
                end
            }
        }
    end,
    init = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep)
        vim.keymap.set("n", "<leader>fb", function() builtin.current_buffer_fuzzy_find({ skip_empty_lines = true, }) end)
        vim.keymap.set("n", "<leader>fc", builtin.commands)
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
        vim.keymap.set("n", "<leader>fm", function() builtin.man_pages({sections = {"1","2","3"}}) end)

        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopePreviewerLoaded",
            callback = function(args)
                local blend = vim.g.redh_winblend
                if is_image(args.data.bufname) then
                    blend = 0
                end

                vim.api.nvim_set_option_value("winbl", blend, {win=vim.fn.bufwinid(args.buf)})
                vim.schedule(function()
                end)
            end,
        })

    end,
}
