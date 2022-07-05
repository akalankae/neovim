-- Configuration for stable build of Neovim
-- Install packer as package manager
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Install plugins using Packer
require("packer").startup(function()
	-- Packer plugin manager
	use("wbthomason/packer.nvim")

	-- Splash screen for neovim
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").opts)
			local startify = require("alpha.themes.startify")
			startify.section.bottom_buttons.val = {
				startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua<CR>"),
				startify.button("q", "exit neovim", "qa<CR>"),
			}
		end,
	})

	-- Utilities to make editing source code easier
	use("jiangmiao/auto-pairs") -- Auto-complete & pair parentheses and link them
	use("tpope/vim-commentary") -- "gc" to comment visual selection/lines

	-- Git
	use("tpope/vim-fugitive") -- Git support
	use("tpope/vim-rhubarb") -- GitHub support
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- Git info in signcolumns & popups

	-- Colorschemes
	use("vim-scripts/CycleColor") -- Cycle through colorschemes in runtimepath
	use("gruvbox-community/gruvbox") -- Community groove colorscheme
	use("joshdick/onedark.vim") -- Theme inspired by Atom
	use("EdenEast/nightfox.nvim") -- A dark neovim theme written in lua
	use("tomasr/molokai") -- Vim port of Monokai theme for TextMate
	use("dracula/vim") -- A dark theme for vim and others
	use("sainnhe/everforest") -- Green based warm & soft colorscheme to protect your eyes
	-- use("tjdevries/colorbuddy.nvim") --> Better customization of highlights
	use("tomasiser/vim-code-dark") -- Inspired by Dark+ colorscheme of VSCode
	use("folke/tokyonight.nvim") -->   Theme written in Lua ported from VSCode TokyoNight

	-- Snappy statusline in Lua
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	-- Native LSP setup
	use("neovim/nvim-lspconfig") -->   configurations for LSP servers
	use("williamboman/nvim-lsp-installer") -->   install LSP servers directly & locally
	use("p00f/clangd_extensions.nvim") --> extra features for clangd

	use({
		"jose-elias-alvarez/null-ls.nvim", -->   use non-LSP server programs like LSP servers
		requires = "nvim-lua/plenary.nvim",
	})

	-- Autocompletion engine and sources
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp") --> functionalities for working with nvim-lsp
	use("hrsh7th/cmp-nvim-lua") --> complete lua code for neovim' Lua API
	use("hrsh7th/cmp-path") --> complete file paths
	use("hrsh7th/cmp-buffer") --> complete words from current buffer
	use("hrsh7th/cmp-cmdline") -- NOT YET!
	use("onsails/lspkind-nvim") --> Add VSCode like pictograms to builtin LSP

	-- Treesitter for parsing source code
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- plugins using Treesitter
	use("p00f/nvim-ts-rainbow") -- Paint nested parentheses with colors of the rainbow
	use("windwp/nvim-ts-autotag") -- ERROR: not-working, autoclose and autorename HTML tags using treesitter

	-- Snippet engine and sources
	use("L3MON4D3/luasnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Navigate seamlessly between Vim and Tmux splits using a consistant set of hotkeys.
	use("christoomey/vim-tmux-navigator")

	-- Persist and toggle multiple terminals during vim session
	use("akinsho/toggleterm.nvim")

	-- Hightlight colorcodes in relevant colors
	use("norcalli/nvim-colorizer.lua")

	-- Extensible fuzzy-finder written in Lua, using new features in Neovim core
	-- Using community-driven builtin pickers, sorters & previewers
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })

	-- File explorer for neovim in lua
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" }, --> optional for file icons
		tag = "nightly", --> optional, updated every week
	})
  -- nvim-lua-gf: extend "gf" command to jump to files in lua files (e.g. dir1.dir2.file1)
  use "sam4llis/nvim-lua-gf"
end)
