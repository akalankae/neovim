-- Autocommands translated from vimscript file autocommands.vim in $NVIM_CONFIG_DIR/vimscript
-- Using new nvim_create_autocmd & nvim_create_augroup with Neovim 0.7

-- Map <Escape> key to <CapsLock> for easy typing
-- CAUTION: If you exit a single vim buffer while one/more vim buffers remain open,
-- this <Esc> to <CapsLock> mapping will be disabled for those opened buffers.
vim.api.nvim_create_autocmd("VimEnter", {
  pattern="*", command="silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
})
vim.api.nvim_create_autocmd("VimLeave", {
  pattern="*", command="silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"
})

-- Toggle/untoggle relative line numbers depending on whether window is active/inactive
local numbertoggle = vim.api.nvim_create_augroup( "numbertoggle", { clear=true } ) -- clear==true is default

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" },
  { pattern = "*", command = "set relativenumber" , group = numbertoggle })
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" },
  { pattern = "*", command = "set norelativenumber", group = numbertoggle })

-- auto-pairs: Language dependant pairs
-- Python F-strings and raw-strings
vim.api.nvim_create_autocmd("FileType", {
  pattern="python", command='let b:AutoPairs = AutoPairsDefine({"f\'":"\'", "r\'":"\'"})'
})
-- Markup languages HTML/XML
vim.api.nvim_create_autocmd("FileType", {
  pattern={"html", "xml"}, command='let b:AutoPairs = AutoPairsDefine({"<":">"})'
})

-- Auto-complete HTML tags with omnicomplete ( <Ctrl-x><Ctrl-O> )
vim.api.nvim_create_autocmd("FileType", {
  pattern="html", command='set omnifunc=htmlcomplete#CompleteTags'
})

-- Remove trailing whitespace & blank lines
vim.api.nvim_create_autocmd("FileType", {
  pattern={"python", "c", "cpp", "lua", "vim"},
  command="autocmd BufWritePre <buffer> %s/\\s\\+$//e"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern={"python", "c", "cpp", "lua", "vim"},
  command="autocmd BufWritePre <buffer> %s/\\($\n\\s*\\)\\+\\%$//e"
})
