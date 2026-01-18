-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "q", "<Nop>")

map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "<Del>", '"_x')
map("n", "<BS>", '"_X')

map("n", "<C-Up>", "<C-k>", { remap = true })
map("n", "<C-Down>", "<C-j>", { remap = true })
map("n", "<C-Left>", "<C-h>", { remap = true })
map("n", "<C-Right>", "<C-l>", { remap = true })

map("n", "<Leader>L", "<Cmd>LazyExtras<CR>", { desc = "Lazy Extras" })
