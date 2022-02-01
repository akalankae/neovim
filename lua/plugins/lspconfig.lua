-- Configuration for neovim native LSP

-- Map following keys for NORMAL mode, but only after a language server attaches to
-- current buffer.
local custom_attach_func = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable autocompletion ("Omnicompletion") triggered by <C-x><C-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap=true, silent=true}

  -- HOVER: Show documentation about symbol under the cursor in a floating window.
  -- Executing the function twice, makes cursor jump to the floating window, so that
  -- you can navigate inside it like a regular vim buffer in NORMAL mode.
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- GOTO DEFINITION: Jump to the file and place where the symbol under the cursor
  -- is defined.
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- GOTO TYPE-DEFINITION: Jump to the file and place where the type of the symbol
  -- under the cursor is defined.
  buf_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- LIST REFERENCES: List all references to the symbol under the cursor in a quickfix
  -- window.
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- LIST IMPLEMENTATIONS: List all implementations for the symbol under the cursor in
  -- a quickfix window.
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  -- RENAME: Rename all references to the symbol under the cursor.
  buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- CODE ACTION: Select a code action available at current cursor postion.
  buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- FORMAT: Format the current buffer
  buf_set_keymap('n', '<Leader>ff', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Setup installed language servers
local nvim_lsp = require("lspconfig")
local servers = {
  "jedi_language_server",           -- Python
  "sumneko_lua",                    -- Lua
  "gopls",                          -- Go
}

for _, server in ipairs(servers) do
  nvim_lsp[server].setup{
    on_attach = custom_attach_func
  }
end
