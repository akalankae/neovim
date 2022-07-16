-- Key Mappings

-- Navigation between screen splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- Ctrl-s to save in NORMAL and INSERT modes
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>") --> like nmap
vim.keymap.set("i", "<C-s>", "<esc><cmd>w<cr>a") --> like imap

-- Ctrl-q to close current split
vim.keymap.set("n", "<C-q>", "<C-w>q") 

-- Ckeymaptalize previous word in INSERT mode
vim.keymap.set("i", "<C-u>", "<esc>viwUea") 

-- Leader
vim.g.mapleader = ";"

local silent = { silent=true }

-- Clear highlighted text with <Escape> key
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<cr>")

-- Launch splash screen
vim.keymap.set("n", "<Leader>a", "<cmd>Alpha<cr>")

-- Better indentation
vim.keymap.set("v", "<", "<gv", silent)
vim.keymap.set("v", ">", ">gv", silent)
