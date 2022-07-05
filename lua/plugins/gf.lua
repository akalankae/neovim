-- Config for nvim-lua-gf
-- Extending vim "gf" ( go to file ) command to jump to paths written with "."
-- as the delimiter.

--> needs neovim >= 0.8
if not vim.fn.has("nvim-0.8") then
  require("nvim-lua-gf").setup {}
end
