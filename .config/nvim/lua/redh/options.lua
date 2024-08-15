vim.g.netrw_liststyle = 3

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.virtualedit = "onemore"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"

vim.opt.signcolumn = "yes"

vim.opt.wrap = false
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.g.redh_listchars_normal = {
    -- leadmultispace = "▎" .. string.rep(" ", vim.fn.shiftwidth() - 1),
    tab = "» ",
    lead = " ",
    trail = "·",
    extends = "🢖",
    precedes = "🢔",
}
vim.g.redh_listchars_verbose = {
    -- leadmultispace = "▎" .. string.rep("·", vim.fn.shiftwidth() - 1),
    leadmultispace = "·",
    tab = vim.g.redh_listchars_normal.tab,
    trail = vim.g.redh_listchars_normal.trail,
    extends = vim.g.redh_listchars_normal.extends,
    precedes = vim.g.redh_listchars_normal.precedes,
    space = "␣",
    nbsp = "⍽",
    eol = "↵",
}
vim.opt.listchars = vim.g.redh_listchars_normal
vim.opt.list = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

if jit.os ~= "Windows" then
    vim.opt.undofile = true
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

vim.opt.updatetime = 150

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.laststatus = 3

if os.getenv("SSH_CONNECTION") or os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY") then
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        },
    }
end

