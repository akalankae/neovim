-- Iterate through this directory and source each lua file except this one.
-- NOTE: You have add this file to each directory under "~/.config/nvim/lua/" with lua
-- file that you want to source.
-- Remember to change "parent" variable to the name of the directory.

local parent = "plugins"            -- parent directory of this set of lua modules
local dirname = vim.fn.stdpath("config") .. "/lua/" .. parent
local handle = io.popen("ls " .. dirname)
local pattern = "(%w+).lua$"

for filename in handle:lines() do
  local module = string.match(filename, pattern)
  -- If not a lua file skip it
  if module == nil then
    goto continue
  end
  -- Source all lua files except init.lua
  if module ~= "init" then
    local modulepath = "%s.%s"
    require(modulepath:format(parent, module))    -- require("directory.module")
  end
  ::continue::
end

handle:close()
