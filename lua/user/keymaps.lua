-- User keymappings
-------------------------------------------------------------------------------
-- Notes:
-- <CR> = "carriage return"
-- <Cmd> = ":" (same as entering semicolon at the command line)
--
-------------------------------------------------------------------------------
-- <Leader>
vim.g.mapleader = ";"

-- Ctrl-j/k/h/l to navigate between splits
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap=true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap=true})

-- Go to startify splash screen
vim.api.nvim_set_keymap('n', '<Leader>a', '<Cmd>Alpha<CR>', {noremap=true})

-- Ctrl-s to save in NORMAL & INSERT modes
vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>w<CR>', {noremap=true})       -- nmap(...)
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc><Cmd>w<CR>a', {noremap=true}) -- imap(...)

-- Ctrl-q closes current split
vim.api.nvim_set_keymap('n', '<C-q>', '<C-w>q', {noremap=true})

-- Turn-off highlighted text after a search operation
vim.api.nvim_set_keymap("n", "<Leader>cl", "<Cmd>nohlsearch<CR>", {noremap=true})

-- Capitalize previous word in INSERT mode
vim.api.nvim_set_keymap("i", "<C-u>", "<Esc>viwUea", {noremap=true})
