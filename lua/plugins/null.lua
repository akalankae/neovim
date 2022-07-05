-- Config for null-ls.nvim
-------------------------------------------------------------------------------
-- What is Null-ls?
-- Null-ls is a language server that uses neovim's builtin LSP client to give
-- diagnostics, formatting, linting, ... etc, using programs that cannot work
-- themselves as language servers. (e.g. flake8, black)
-- It analyzes the requests of builtin language client, search for programs that
-- are configured to give requested services, launch these programs and provide
-- the relevant services.
-------------------------------------------------------------------------------

-- local lsp_formatting = function(bufnr)
-- 	vim.lsp.buf.format({
-- 		filter = function(client)
-- 			-- apply whatever logic you want (only null-ls is used here)
-- 			return client.name == "null-ls"
-- 		end,
-- 		bufnr = bufnr,
-- 	})
-- end

-- -- Shared on_attach callback
-- local on_attach = function(client, bufnr)
-- 	if client.supports_method("textDocument/formatting") then
-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			group = augroup,
-- 			buffer = bufnr,
-- 			callback = function()
-- 				lsp_formatting(bufnr)
-- 			end,
-- 		})
-- 	end
-- end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- Callback to use for setting up formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting({
            bufnr = bufnr,
            filter = function(cli)
              return cli.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = "--fast" }),
    formatting.stylua,
    diagnostics.flake8,
  },
})
