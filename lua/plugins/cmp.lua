-- Configuration of Neovim autocompletion engine nvim-cmp and plugins that provide
-- it with sources.

-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item.
    -- When no item is selected do not automatically select first item
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- Set `select` to `true` to select the first item.

    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false }),
    ['<Tab>'] = cmp.mapping(
    function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif cmp.visible() then
        cmp.select_next_item()
        -- elseif vim.api.nvim_get_mode().mode == 'i' then
        --   tabout.tabout()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(
    function (fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        elseif luasnip.jumptable(-1) then
          luasnip.jump(-1)
        else
          fallback()
      end
    end, {'i', 's'})
    },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
}
