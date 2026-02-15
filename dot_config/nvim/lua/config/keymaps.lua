-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v" }, "q", "<Nop>")

map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "<Del>", '"_x')

map("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window" })

map("n", "<M-Left>", "<C-o>")
map("n", "<M-Right>", "<C-i>")

map("n", "<Leader>L", "<Cmd>LazyExtras<CR>", { desc = "Lazy Extras" })
