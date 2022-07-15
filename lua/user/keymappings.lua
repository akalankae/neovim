vim.g.mapleader = ";"

--> Navigation between screen splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

--> Ctrl-s to save in NORMAL and INSERT modes
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>") --> like nmap
vim.keymap.set("i", "<C-s>", "<esc><cmd>w<cr>a") --> like imap

--> Ctrl-q to close current split
vim.keymap.set("n", "<C-q>", "<C-w>q") 

--> Capitalize previous word in INSERT mode
vim.keymap.set("i", "<C-u>", "<esc>viwUea")

--> Clear highlighted text
vim.keymap.set("n", "<Leader>cl", "<cmd>nohlsearch<cr>")

--> Show current colorscheme
vim.keymap.set("n", "<Leader>cs", "<cmd>colorscheme<cr>")

--> Goto startify splash screen
vim.keymap.set("n", "<Leader>a", "<cmd>Alpha<cr>")
