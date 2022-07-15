-- Neovim configuration

require("user.settings")
require("user.autocommands")
require("user.keymappings")
require("user.plugins") --> "user/plugins.lua" requires "plugins/packer.lua"

require("plugins.lualine")
