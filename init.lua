-- Neovim configuration

require("user.settings")
require("user.autocommands")
require("user.keymappings")
require("user.plugins") --> "user/plugins.lua" requires "plugins/packer.lua"
require("user.lazygit") --> launch lazygit in floating terminal (using toggleterm)

require("plugins.lualine")
require("plugins.toggleterm")
require("plugins.nvim-tree")
