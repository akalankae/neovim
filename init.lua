--------------------------------------------------------------------------------------
-- init.lua
-- Lua based neovim configuration
--------------------------------------------------------------------------------------
-- NOTES:
-- For you to jump to files and directories in require statements with "gf", you need
-- to put a lua config file in $HOME/.config/nvim/after/ftplugin directory
-- (e.g paths.lua) so that it will be loaded automatically.
--------------------------------------------------------------------------------------

-- Source vimscript source files
vim.cmd("source " .. vim.fn.stdpath("config") .. "/vimscript/autocommands.vim")

-- Configs for the user
require("user")

-- Configs for installed plugins
require("plugins")
