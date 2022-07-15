vim.g.mapleader = ";"

local noremap = { noremap=true }

--> Navigation between screen splits
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", noremap)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", noremap)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", noremap)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", noremap)

--> Ctrl-s to save in NORMAL and INSERT modes
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>w<cr>", noremap) --> like nmap
vim.api.nvim_set_keymap("i", "<C-s>", "<esc><cmd>w<cr>a", noremap) --> like imap

--> Ctrl-q to close current split
vim.api.nvim_set_keymap("n", "<C-q>", "<C-w>q", noremap) 

--> Clear highlighted text
vim.api.nvim_set_keymap("n", "<Leader>cl", "<cmd>nohlsearch<cr>", noremap)

--> Capitalize previous word in INSERT mode
vim.api.nvim_set_keymap("n", "<C-u>", "<esc>viwUea", noremap) 
