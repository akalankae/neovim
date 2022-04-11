-- Configuration for neovim-treesitter
require("nvim-treesitter.configs").setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype.
    -- (e.g. if you want to disable highlighting for the `tex` filetype, you
    -- need to include `latex` in this list as this is the name of the parser)
    -- list of language that will be disabled
    -- treesitter parser for Rust is twice as slow (apparently) as native rustc
    disable = { "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- EXPERIMENTAL indentation based on treesitter for "=" operator
  indent = {
    enable = true,
    -- List of languages to diable treesitter based indentation
    disable = { "c", "python" },
  },

  -- Treesitter based plugins
  -- Configs for rainbow parenthesis plugin
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings

  },
  -- Config for nvim-ts-autotag
  autotag = {
    enable = true,
    filetypes = { 'html', 'xml' },
  }
}
