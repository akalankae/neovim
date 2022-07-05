-- Configuration for neovim native LSP
-- NOTE: Individual LSP servers are setup by lua config files in
-- 'stdpath("data")/plugged/nvim-lspconfig/lua/lspconfig' directory
-- If the LSP server is known to nvim-lspconfig it is found as "SERVER_NAME.lua"

-- Map following keys for NORMAL mode, but only after a language server attaches to
-- current buffer.
local custom_attach_func = function(_, bufnr)
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
  buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('x', '<Leader>ca', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>', { silent=true })

  -- FORMAT: Format the current buffer
  buf_set_keymap('n', '<Leader>ff', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('x', '<Leader>ff', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

  -- DIAGNOSTICS:
  -- Goto next
  buf_set_keymap('n', '<Leader>dn', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- Goto previous
  buf_set_keymap('n', '<Leader>dp', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- In floating window
  buf_set_keymap('n', '<Leader>df', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- Add/create/replace to location list for window
  buf_set_keymap('n', '<Leader>dl', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- Once you have Telescope installed uncomment line below and remove line above
  -- buf_set_keymap('n', '<Leader>dl', '<Cmd>Telescope diagnostics<CR>', opts)
  -- NOTE: Once you get the Diagnostic List, <C-q> gets them into a quick-fix list

end

-- Get path of python3 executable for current python3 virtual environment
local util = require("lspconfig/util")

local path = util.path

local function get_python_path(workspace)
  -- Use active virtual environment
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory
  local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system python
  return vim.fn.exepath("python3") or vim.fn.exepath('python') or 'python'
end

-- Setup installed language servers
local nvim_lsp = require("lspconfig")
local servers = {
  "pyright",                        -- Python
  -- "jedi_language_server",           -- Python
  "sumneko_lua",                    -- Lua
  "gopls",                          -- Go
  -- "ccls",                           -- C | C++ | Objective-C
  "clangd",                         -- C | C++
  "tsserver",                       -- Typescript server
  "vimls",                          --> Vimscript
}
local server_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in ipairs(servers) do
  -- Lua:
  -- Add "vim" to known global variables table to get rid of annoying error
  -- msg: undefined global "vim"
  if server == "sumneko_lua" then
    nvim_lsp[server].setup{
      capabilities = server_capabilities,
      on_attach = custom_attach_func,
      settings = {
        Lua = {
          diagnostics = { globals = {"vim", "use"} }
        }
      }
    }
  -- C | C++
  elseif server == "ccls" then
    nvim_lsp[server].setup{
      capabilities = server_capabilities,
      on_attach = custom_attach_func,
      init_options = {
        cache = { directory = ".ccls-cache" },
        compilationDatabaseDirectory = "build",
        index = { threads = 0 },
        clang = { excludeArgs = { "-frounding-math" } },
      }
    }
  -- Python3
  elseif server == "pyright" then
    nvim_lsp[server].setup {
      capabilities = server_capabilities,
      on_attach = custom_attach_func,
      on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
      end,
    }
  -- HTML
  elseif server == "html" then
    local html_server_capabilities = vim.lsp.protocol.make_client_capabilities()
    html_server_capabilities.textDocument.completion.completionItem.snippetSupport = true
    nvim_lsp[server].setup {
      capabilities = html_server_capabilities,
      on_attach = custom_attach_func,
    }
  -- Other languages
  else
    nvim_lsp[server].setup{
      capabilities = server_capabilities,
      on_attach = custom_attach_func,
    }
  end
end

-- Enable update on insert ( Issue #19 )
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    update_in_insert = true,
  }
)
