-- Install packer as package manager
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Install plugins using Packer
require("packer").startup(
function()
  -- Packer plugin manager
  use 'wbthomason/packer.nvim'

  -- Splash screen for neovim
  use { 'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').opts)
      local startify = require('alpha.themes.startify')
      startify.section.bottom_buttons.val = {
        startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua<CR>"),
        startify.button("q", "exit neovim", "qa<CR>"),
      }
    end
  }

  -- Utilities to make editing source code easier
  use 'jiangmiao/auto-pairs'    -- Auto-complete & pair parentheses and link them
  use 'tpope/vim-commentary'    -- "gc" to comment visual selection/lines

  -- Git
  use  'tpope/vim-fugitive'                   -- Git support
  use  'tpope/vim-rhubarb'                    -- GitHub support
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' } }  -- Git info in signcolumns & popups

  -- Colorschemes
  use 'gruvbox-community/gruvbox' -- Community groove colorscheme
  use 'joshdick/onedark.vim'      -- Theme inspired by Atom
  use 'shaunsingh/nord.nvim'      -- Modern colorscheme written in lua
  use 'EdenEast/nightfox.nvim'    -- A dark neovim theme written in lua
  use 'vim-scripts/CycleColor'    -- Cycle through colorschemes in runtimepath

  -- Snappy statusline in Lua
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt=true }}

  -- Native LSP setup
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Autocompletion engine and sources
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-cmdline'       -- NOT YET!

  -- Snippet engine
  use 'L3MON4D3/luasnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Navigate seamlessly between Vim and Tmux splits using a consistant set of hotkeys.
  use 'christoomey/vim-tmux-navigator'

end
)
