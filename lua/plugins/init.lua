-- Configurations for installed plugins go here.
--
-- Source all files in this directory except this file (i.e. init.lua).
-- NOTE: You have add this file to each directory under "$NVIM_CONFIG_DIR/lua"
-- with lua files that you want to source.
-- REMEMBER to change "parent" variable to the name of the directory.

local parent = "plugins"  --> parent directory of this set of lua modules
local dirname = vim.fn.stdpath("config") .. "/lua/" .. parent
local handle = io.popen("ls " .. dirname)
local pattern = "(%w+).lua$"

if handle == nil then
  return
end

for filename in handle:lines() do
  local module = string.match(filename, pattern)
  -- skip non-lua files
  if module == nil then
    goto continue
  end
  -- Source all lua files except init.lua
  if module ~= "init" then
    local modulepath = "%s.%s"
    require(modulepath:format(parent, module))  --> require("directory.module")
  end
  ::continue::
end

handle:close()
