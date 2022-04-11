-- Configuration of Neovim autocompletion engine nvim-cmp and plugins that provide
-- it with sources.

-- Add additional capabilites supported by nvim-cmp
local capabilites = vim.lsp.protocol.make_client_capabilities()
capabilites = require("cmp_nvim_lsp").update_capabilities(capabilites)

-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')
-- local tabout = require('tabout')  -- Needs tabout.nvim plugin

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['C-p'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['C-n'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
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
      behavior = cmp.ConfirmBehavior.Insert, -- OR cmp.ConfirmBehavior.Replace
      select = false }),                     -- OR true
    ['<Tab>'] = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
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
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
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
