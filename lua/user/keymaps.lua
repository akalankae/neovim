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
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')

-- Go to startify splash screen
vim.keymap.set('n', '<Leader>a', '<Cmd>Alpha<CR>')

-- Ctrl-s to save in NORMAL & INSERT modes
vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>')       -- nmap(...)
vim.keymap.set('i', '<C-s>', '<Esc><Cmd>w<CR>a') -- imap(...)

-- Ctrl-q closes current split
vim.keymap.set('n', '<C-q>', '<C-w>q')

-- Turn-off highlighted text (e.g. after a search operation)
vim.keymap.set("n", "<Leader>cl", "<Cmd>nohlsearch<CR>")

-- Capitalize previous word in INSERT mode
vim.keymap.set("i", "<C-u>", "<Esc>viwUea")

-- Map dictionary completion default mapping <C-x><C-k> to <C-d> in INSERT mode
vim.keymap.set('i', '<C-d>', '<C-x><C-k>')

-- Show current colorscheme
vim.keymap.set('n', '<Leader>cs', '<Cmd>colorscheme<CR>')

-- Cycle between available colorschemes (colorscheme next | colorscheme previous)
vim.keymap.set('n', '<Leader>cn', '<Cmd>CycleColorNext<CR>')
vim.keymap.set('n', '<Leader>cp', '<Cmd>CycleColorPrev<CR>')
