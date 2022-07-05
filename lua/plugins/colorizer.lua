-- Config for nvim-colorizer.lua
local colorizer_ok, colorizer = pcall(require, "colorizer")

if not colorizer_ok then
  print("Error occured when trying to import colorizer")
  return
end
