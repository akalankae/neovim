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
-- NOTE: "." may used as path separator in Lua. But, I'm unable to get to jump
-- to files specified this way, at the moment. Therefore, regular path separator
-- ("/") is used here.
-- Plugin nvim-lua-gf is available to do above, but it only works with neovim
-- 0.8.
require("user/plugins")
require("user/options")
require("user/keymaps")
require("user/autocmd")
require("user/abbrev")

-- Source configs for all installed plugins
require("plugins")
