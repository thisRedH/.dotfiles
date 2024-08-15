vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set({"n", "v"}, "<C-d>", [["_d]])

-- Move arround in insert mode using ctrl+hjkl
vim.keymap.set("i", "<C-j>", "<C-o>gj")
vim.keymap.set("i", "<C-k>", "<C-o>gk")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Center on ctl+d/u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move selection up and down (I use mini.move now)
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- fast window switching
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

vim.keymap.set("n", "<C-up>", "<C-w>2-")
vim.keymap.set("n", "<C-down>", "<C-w>2+")
vim.keymap.set("n", "<C-left>", "<C-w>5<")
vim.keymap.set("n", "<C-right>", "<C-w>5>")

-- Nice substitute
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
