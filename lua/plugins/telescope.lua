-- Config for telescope.nvim

require("telescope").setup {
  defaults = {
    -- default configuration for telescope
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker
        -- e.g: git{create, delete, ... }_branch for the git_branches picker
        ["<C-h>"] = "which_key",
      }
    }
  },
  pickers = {
    -- default configuration for builtin pickers goes here
    -- picker_name = {
    -- picker_config_key = value,
    -- ...
    -- }
    -- Now the picker_config_key will be applied everytime you call this
    -- builtin picker
  },
  extensions = {
    -- your extension configuration goes here
    -- extension_name = {
    -- extension_config_key = value,
    -- }
    -- NB: Take a look at the README of the extension you want to configure
  }
}
