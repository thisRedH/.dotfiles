vim.api.nvim_create_autocmd("VimEnter", {
    desc = "CD to the file opened in the CLI",
    pattern = "*",
    callback = function()
        local args = vim.v.argv
        local dir = nil

        if #args < 2 then return end

        for i = #args, 2, -1 do
            dir = vim.fn.fnamemodify(args[i], ":p:h")
            dir = vim.fs.normalize(dir)
            if vim.fs.dir(dir) then break end
        end

        if not vim.fs.dir(dir) then return end
        vim.cmd("cd " .. vim.fs.normalize(dir))
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Hightlight selection on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 150
        }
    end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Open help pages to the left",
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "help" or ft == "man" then
            vim.cmd.wincmd("L")
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.bo.filetype = "terminal"
    end,
})

vim.api.nvim_create_user_command("ToggleTransparent", function()
    local nrml = vim.api.nvim_get_hl(0, { name = "Normal" })
    local nrmlfl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })

    vim.cmd.colorscheme(vim.g.colors_name)

    if nrml.bg or nrmlfl.bg then
        vim.api.nvim_set_hl(0, "Normal", vim.tbl_extend("force", nrml, { bg = "none" }))
        vim.api.nvim_set_hl(0, "NormalFloat", vim.tbl_extend("force", nrmlfl, { bg = "none" }))
    end
end, {})

vim.api.nvim_create_user_command("ToggleListchars", function()
    for k, v in pairs(vim.opt.listchars:get()) do
        if vim.g.redh_listchars_normal[k] ~= v then
            vim.opt.listchars = vim.g.redh_listchars_normal
            return
        end
    end
    vim.opt.listchars = vim.g.redh_listchars_verbose
end, {})
