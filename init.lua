--------------------------------------------------------------------------------------
-- init.lua
-- Lua based neovim configuration
--------------------------------------------------------------------------------------
-- Setup autocommands written in vimscript
vim.cmd("source " .. vim.fn.stdpath("config") .. "/vimscript/autocommands.vim")

-- Configs for the user
require("user")
-- require("user/keymaps")
-- require("user/options")
-- require("user/plugins")

-- Configs for installed plugins
require("plugins")
-- require("plugins/lualine")
