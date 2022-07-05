-- Whitespace settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2   -- use -1 for same value as "shiftwidth", 0 for "tabstop"
vim.opt.shiftwidth = 2    -- use 0 for same value as "tabstop"
vim.opt.smarttab = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.breakindent = true

-- Text dispaly area setup
vim.opt.textwidth = 0
vim.opt.wrapmargin = 2
vim.opt.signcolumn = 'yes'

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show effects of command incrementally
vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true

-- Save undo history
vim.opt.undofile = true

-- Better colors
vim.opt.termguicolors = true

-- Select one out selected random colorschemes
local colorschemes = {'molokai', 'gruvbox', 'onedark', 'tokyonight', 'dracula', 'codedark', 'everforest'}
-- math.randomseed(os.clock()) --> Gives a warning
-- vim.g.colors_name = colorschemes[math.random(#colorschemes)] NOTE: not working!
vim.cmd('colorscheme ' .. colorschemes[math.random(#colorschemes)])

-- Uncomment to get original Monokai background
-- vim.g.molokai_original = true

-- Graphical
vim.g.mouse = 'a'
vim.opt.digraph = true

-- Don't save when switching buffers (this is the default)
vim.opt.hidden = true

-- For Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.dictionary = '/usr/share/dict/allwords.txt'
vim.opt.cmdheight = 2

-- Make new splits appear below and to the right of current one
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Make visible invisible whitespace characters
vim.opt.list = false      -- Enable to see whitespace characters
vim.opt.listchars = { nbsp = '+', trail = '●', eol = "↲", tab = "━━"}

-- Setup path of python3 executable to work with virtual environments
if vim.env.VIRTUAL_ENV ~= nil then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. "/bin/python3"
else
  vim.g.python3_host_prog = '/usr/bin/python3'
end
