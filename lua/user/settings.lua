-- Editor settings for neovim

local opt = vim.opt

--> Whitespace
opt.tabstop = 4
opt.softtabstop = 2 --> if 0 equals "tabstop", -1 equals "shiftwidth"
opt.shiftwidth = 2  --> if 0 equals "tabstop"
opt.expandtab = true
opt.smarttab = true

--> ndentation
opt.autoindent = true
opt.smartindent = false
opt.cindent = true
opt.breakindent = true

--> Formatting
opt.textwidth = 0
opt.wrap = true    --> do line wrapping
opt.wrapmargin = 2 --> line wrap text beyond 2 columns to the left of border

--> Helper lines and columns
opt.signcolumn = "yes" --> always show sign column, width variable
opt.number = true
opt.relativenumber = true

--> Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

--> Show effects of commands incrementally
opt.inccommand = "nosplit"

--> Undoing & saving
opt.undofile = true  --> keep track of changes in "undodir"
opt.hidden = true  --> do not save current buffer when switching buffers

--> Colors
opt.termguicolors = true

--> Graphical
vim.g.mouse = "a"
opt.digraph = true

--> Treesitter
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

--> Omnicompletion
opt.completeopt = {"menu", "menuone", "noselect"}
opt.dictionary = "/usr/share/dict/allwords.txt"

opt.cmdheight = 2 --> number of lines in screen command-line

--> New splits to the right of and below current window
opt.splitbelow = true
opt.splitright = true

--> Visibility of whitespace
opt.list = false --> "true" make whitespace visible
opt.listchars = { nbsp="+", trail="●", eol="↲", tab="― " }
