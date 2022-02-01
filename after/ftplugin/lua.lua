-- We source multiple files in our init.lua file using require statements.
-- Following lines enable us to jump directly from relative paths in these require
-- stetements to relavent files.
-- This file should be placed in $HOME/.config/nvim/after/ftplugin/.
vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config') .. '/lua')
