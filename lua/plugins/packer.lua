--> Configuration for packer.nvim
--> Imported by plugin.lua

local M = {} --> module namespace table

function M.setup()

  local packer_bootstrap = false --> indicate 1st time installation

  --> packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float( {border="rounded"} )
      end,
    },
  }

  --> check if packer.nvim is installed
  --> if any changes in this file run PackerCompile
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd[[ packadd packer.nvim ]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  local function plugins(use)
    --------------------------------------------------------------------------
    -- List of installed plugins
    --------------------------------------------------------------------------
    --> packer.nvim plugin manager
    use "wbthomason/packer.nvim"

      --> Splash screen
      use { "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("alpha").setup(require("alpha.themes.startify").opts)
        local startify = require("alpha.themes.startify")
        startify.section.bottom_buttons.val = {
          startify.button("v", "Neovim Config", "<cmd>e ~/.config/nvim/init.lua<cr>"),
          startify.button("q", "Exit Neovim",   "qa<cr>"),
        }
      end
    }

    --> Colors
    --> TokyoNight colorscheme for VSCode
    use { "folke/tokyonight.nvim",
    config = function()
      vim.cmd [[ colorscheme tokyonight ]]
    end,
  }

    use "tomasr/molokai" --> vim port of Monokai theme for TextMate
    use "joshdick/onedark.vim" --> theme inspired by Atom
    use "morhetz/gruvbox" --> Community Groove colorscheme

    --> Snappy statusline in lua
    use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    --> Utilities for coding
    use "jiangmiao/auto-pairs" --> autocomplete & link parenthesis
    use "tpope/vim-commentary" --> gc/gcc to comment/uncomment in INSERT/VISUAL modes

    --> Persistant floating terminal that can be toggled during a vim session
    use "akinsho/toggleterm.nvim",

    --> Highlight colorcodes in relavent colors
    use { "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    }

    --------------------------------------------------------------------------

    if packer_bootstrap then
      print "Need to restart neovim after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)

end

return M
