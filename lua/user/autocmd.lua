--==============================================================================
-- NOTE: New Lua API updated for 0.7 has the ability to create autocommands and
-- augroups using nvim_create_autocmd & nvim_create_augroup. But these appear to
-- be slower than vimscript autocommands.
-- These same contents are found in $NVIM_CONFIG_DIR/vimscript/autocmd.vim
-- You may want to source that file for performance reasons, but do not source both
-- of them!
--==============================================================================

-- New Neovim v0.7 exposes an API to write autocommands in Lua

-- -- nvim-cmp works on all opened buffers to give autocompletion, diagnostics, ... etc
-- -- but this messing around inside buffers is not what you sometimes want.
-- -- e.g. Telescope floating text (but telescope has other ways to achieve this)
-- vim.api.nvim_create_autocmd("FileType", {
-- 	command = "TelescopePrompt lua require('cmp').setup.buffer { enabled=false }",
-- 	pattern = "lua",
-- })

-------------------------------------------------------------------------------
--                 <CapsLock> ==  <Esc> inside Neovim
-------------------------------------------------------------------------------
-- Map <Escape> key to <CapsLock> for easy typing
-- CAUTION: If you exit a single vim buffer while one/more vim buffers remain open,
-- this <Esc> to <CapsLock> mapping will be disabled for those opened buffers.
vim.api.nvim_create_autocmd("VimEnter", {
  pattern="*", command="silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
})
vim.api.nvim_create_autocmd("VimLeave", {
  pattern="*", command="silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"
})

-------------------------------------------------------------------------------
-- Relative and absolute line numbers
-- Toggle/untoggle relative/absolute line numbers depending on active/inactive
-- state of the buffers.
-------------------------------------------------------------------------------
local numbertoggle = vim.api.nvim_create_augroup( "numbertoggle", { clear=true } )

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

-- Start source code from skeleton files (templates)
-- Template files have to be there in "~/.local/share/nvim/skeletons"
local skel_dir = vim.fn.stdpath("data") .. "/skeletons"

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern="lua", command="0read " .. skel_dir .. "/skel.lua" })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern="c", command="0read " .. skel_dir .. "/skel.c" })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern="cpp", command="0read " .. skel_dir .. "/skel.cpp" })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern="python", command="0read " .. skel_dir .. "/skel.py" })

-- Remove redundant whitespace from end of the line.
function TrimTrailingWhitespace()
  if not vim.o.binary and vim.o.filetype ~= "diff" then
    local current_view = vim.fn.winsaveview()
    -- vim.cmd( [[ keepjumps '[,'s/\s+\+$//e ]] )
    vim.cmd [[ keeppatterns %s/\s\+$//e ]]
    vim.fn.winrestview(current_view)
  end
end

-- Remove redundant newlines from end of the file.
function TrimTrailingNewlines()
  if not vim.o.binary and vim.o.filetype ~= "diff" then
    local cursor_pos = vim.fn.getpos(".")
    vim.cmd( [[ silent! %s#\($\n\s*\)\+\%$## ]] )
    vim.fn.setpos(".", cursor_pos)
  end
end

-- Remove all redundant whitespace from source files etc
function Cleanup()
  TrimTrailingWhitespace()
  TrimTrailingNewlines()
end

-- Remove trailing whitespace & blank lines from filetypes that have following
-- extensions
local file_patterns = {
  "*.py", "*.c", "*.cpp", "*.h", "*.lua", "*.vim", "*.sh"
}

--> Creating a group for a single autocommand to stop it from being registered
--> multiple times when it is sourced multiple times.
local cleanup_ws_group = vim.api.nvim_create_augroup("RemoveWhitespace", { clear=true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = file_patterns,
  callback = Cleanup,
  group = cleanup_ws_group
})
