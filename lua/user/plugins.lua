-- Load all plugins
-- Look up https://developpaper.com/lua-modules-and-packages/ to find out how to
-- require modules across directories.

--> updating package.path global variable
package.path = "../?.lua;" .. package.path

local status_ok, packer = pcall(require, "plugins.packer")
if not status_ok then
  return
end

packer.setup()
