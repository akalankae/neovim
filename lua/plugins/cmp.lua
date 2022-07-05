-- Configuration of Neovim autocompletion engine nvim-cmp and plugins that provide
-- it with sources.

-- Add additional capabilites supported by nvim-cmp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  local capabilites = vim.lsp.protocol.make_client_capabilities()
  capabilites = cmp_nvim_lsp.update_capabilities(capabilites)
else
  error("Could not import cmp_nvim_lsp", 1)
  return
end

--> Setup nvim-cmp.
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  error("Could not import cmp", 2)
  return
end

--> Setup Luasnip
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
  error("Could not import luasnip", 2)
  return
end

--> Setup Lspkind
local lspkind_ok, lspkind = pcall(require, 'lspkind')
if lspkind_ok then
  lspkind.init()
else
  error("Could not import luasnip", 2)
  return
end

-- local tabout = require('tabout')  -- Needs tabout.nvim plugin
--> From nvim-cmp/wiki/example-mappings#luasnip
local has_words_before = function ()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, true)[1]:sub(col, col):match("%") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-Space>'] = cmp.mapping.complete(), --> Ulauncher launched with same vim

    -- Accept currently selected item.
    -- When no item is selected do not automatically select first item
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- Set `select` to `true` to select the first item.

    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert, --> OR cmp.ConfirmBehavior.Replace
      select = false }),                     --> OR true

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      -- elseif vim.api.nvim_get_mode().mode == 'i' then
      --   tabout.tabout()
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        elseif luasnip.jumptable(-1) then
          luasnip.jump(-1)
        else
          fallback()
      end
    end, {'i', 's'})
    },

  -- by default order of sources determines order of priority
  -- configurable options for sources:
  -- keyword_length, priority, max_item_count, ...
  sources = cmp.config.sources {
    { name = "nvim-lua" },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 4 },
  },

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      -- Show in virtual text where autocompletion suggestions come from
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[API]",
        path = "[path]",
        luasnip = "[snip]",
        gt_issues = "[issues]",
        tn = "[TabNine]",
      },
    }),
  },

  experimental = {
    -- new menu
    native_menu = false,

    -- insert suggested text to nvim virtual text WITHOUT inserting it to buffer
    -- press <tab> to autocomplete with suggested text
    ghost_text = true,
  },
}
