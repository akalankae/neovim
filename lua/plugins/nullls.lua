#!/usr/bin/env lua

-- Filename: <filename>
-- Author: Akalanka Edirisinghe <akalankae@gmai.com>
-- Created on: <date time>
-- Last modified: <date time>

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
  sources = {
    formatting.black,
    formatting.prettier,
    formatting.clang_format,
    formatting.stylua,
  },
})

-- null_ls.setup {
--   sources = {
--     formatting.black,
--     formatting.luaformat,
--     formatting.clang_format,
--     formatting.prettier,
--     formatting.lua_format.with ({
--       extra_args = {
--         "--no-keep-simple-functions-one-line", "--no-break-after-operator",
--         "--column-limit=100", "--break-after-table-lb", "--indent-width=2"
--       }
--     }),
--     formatting.isort,
--     formatting.codespell.with({ filetypes= { "markdown" } })
--   },
--   on_attach = function (client)
--     if client.resolved_capabilites.document_formatting then
--       vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--     end
--   end
-- }
