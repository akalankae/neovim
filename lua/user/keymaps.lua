-- User keymappings
-- keymaps.lua
-------------------------------------------------------------------------------
-- Notes:
-- <CR> = "carriage return"
-- <Cmd> = ":" (same as entering semicolon at the command line)
--
-------------------------------------------------------------------------------
-- Utility functions
function BackgroundToggle()
	if vim.o.background == "light" then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
end

-- <Leader>
vim.g.mapleader = ";"

-- Ctrl-j/k/h/l to navigate between splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- Go to startify splash screen
vim.keymap.set("n", "<Leader>a", "<Cmd>Alpha<CR>")

-- Ctrl-s to save in NORMAL & INSERT modes
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>") -- nmap(...)
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>w<CR>a") -- imap(...)

-- Ctrl-q closes current split
vim.keymap.set("n", "<C-q>", "<C-w>q")

-- Turn-off highlighted text (e.g. after a search operation)
vim.keymap.set("n", "<Leader>cl", "<Cmd>nohlsearch<CR>")

-- Capitalize previous word in INSERT mode
vim.keymap.set("i", "<C-u>", "<Esc>viwUea")

-- Map dictionary completion default mapping <C-x><C-k> to <C-d> in INSERT mode
vim.keymap.set("i", "<C-d>", "<C-x><C-k>")

-- Show current colorscheme
vim.keymap.set("n", "<Leader>cs", "<Cmd>colorscheme<CR>")

-- colorscheme settings
-- cycle between available colorschemes
vim.keymap.set("n", "<Leader>cn", "<Cmd>CycleColorNext<CR>") --> colorscheme next
vim.keymap.set("n", "<Leader>cp", "<Cmd>CycleColorPrev<CR>") --> colorscheme previous
vim.keymap.set("n", "<Leader>bg", "<Cmd>lua print(vim.o.background)<CR>") --> print light/dark
vim.keymap.set("n", "<Leader>bt", "<Cmd>lua BackgroundToggle()<CR>") --> light<->dark

-- Keymaps for telescope.nvim (given in github page)
vim.keymap.set("n", "<Leader>ff", '<Cmd>lua require("telescope.builtin").find_files()<CR>')
vim.keymap.set("n", "<Leader>fg", '<Cmd>lua require("telescope.builtin").live_grep()<CR>')
vim.keymap.set("n", "<Leader>fb", '<Cmd>lua require("telescope.builtin").buffers()<CR>')
vim.keymap.set("n", "<Leader>fh", '<Cmd>lua require("telescope.builtin").help_tags()<CR>')

-- For nvim-tree directory explorer
vim.keymap.set("n", "<Leader>tt", "<Cmd>NvimTreeToggle<CR>") --> toggle tree
vim.keymap.set("n", "<Leader>tf", "<Cmd>NvimTreeFocus<CR>") --> focus on tree
vim.keymap.set("n", "<Leader>tc", "<Cmd>NvimTreeCollapse<CR>") --> collapse recursively

-- Git related keymappings
-- NOTE: Some Git commands are implemented as abbreviations (abbr.lua)
vim.keymap.set("n", "<Leader>gs", "<Cmd>Git status<CR>") --> show repo status
vim.keymap.set("n", "<Leader>ga", "<Cmd>Git add %<CR>") --> git add open file
vim.keymap.set("n", "<Leader>gr", "<Cmd>Git restore --staged %<CR>") --> remove file from staging area
vim.keymap.set("n", "<Leader>gp", "<Cmd>Git push<CR>") --> push commits to remote repo
vim.keymap.set("c", "git", "Git ")
vim.keymap.set("c", "comm", "commit -m ")
