--------------------------------------------------------------------------------------
-- init.lua
-- Lua based neovim configuration for stable build of neovim
--------------------------------------------------------------------------------------
-- NOTES:
-- For you to jump to files and directories in require statements with "gf", you need
-- to put a lua config file in $HOME/.config/nvim/after/ftplugin directory
-- (e.g paths.lua) so that it will be loaded automatically.
--------------------------------------------------------------------------------------
-- Configs for the user

-- TODO: Setup "gf" command to be able to jump to paths written using "." as
-- path separator.
-- Plugin nvim-lua-gf can to do this, but it only works with neovim 0.8

-- Source vimscript files.
-- vim.cmd("source " .. vim.fn.stdpath("config") .. "/vimscript/autocmd.vim")

-- User level configs
require("user/plugins")
require("user/options")
require("user/keymaps")
require("user/autocmd")
require("user/abbrev")

-- Source configs for all installed plugins
require("plugins")
