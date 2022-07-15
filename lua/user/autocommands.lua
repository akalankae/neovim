-- autocommands.lua
-- Commands to be executed upon triggering events

-- Map <Escape> key to <CapsLock> upon entering neovim, and unmap on leaving
local remap_escape = vim.api.nvim_create_augroup("esc_remap", { clear=true })
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*", once = true, group = remap_escape,
	command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
})
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*", once = true, group = remap_escape,
	command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"
})

-- Setting up line numbers
-- Switch between relative and absolute line numbers when editing and not.
local numbertoggle = vim.api.nvim_create_augroup("NumberToggle", { clear=true })
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
	pattern = "*", once = false, group = numbertoggle,
	command = "set relativenumber",
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
	pattern = "*", once = false, group = numbertoggle,
	command = "set norelativenumber",
})
