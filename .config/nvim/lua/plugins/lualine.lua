return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            --theme = "gruvbox_dark",
            theme = "auto",
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch", "diff", "diagnostics"},
            lualine_c = {{
                "filename",
                file_status = true,
                newfile_status = true,
                path = 1,
                symbols = {
                    readonly = ""
                }
            }},
            lualine_x = {"encoding", {"filetype", icons_enabled = false}},
            lualine_y = {"progress", "location"},
            lualine_z = {{"datetime", style = "%R"}}
        },
        extensions = {
            "lazy",
            "mason",
            "oil",
        },
    },
    init = function() vim.opt.showmode = false end,
}
