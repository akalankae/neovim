-- Config for Luasnips
local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then
      return lib
  end
  return nil
end


-- Keymaps
local luasnip_okay, luasnip = pcall(prequire, "luasnip")
if not luasnip_okay then
  error("Could not import luasnip!")
  return
end

local cmp_okay, cmp = pcall(prequire, "cmp")
if not cmp_okay then
  error("Could not import cmp!")
  return
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t("<Tab>")
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t("<S-Tab>")
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- Grabbed from TJDevries #TakeTuesdsy Video #3
local types = prequire("luasnip.util.types")

luasnip.config.set_config {
  -- This tells Luasnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection.
  history = true,

  -- If you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged, TextChangedI",

  -- Autosnippets
  enable_autosnippets = true,

  -- Crazy highlights!
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "⟵", "error" } },
      },
    },
  },
}

-- Adding snippets
require("luasnip.loaders.from_vscode").lazy_load()
