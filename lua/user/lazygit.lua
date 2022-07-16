-- Launching lazygit with toggleterm "Terminal" class

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
    cmd = "lazygit", -- command to execute when creating the terminal e.g. 'top'
    hidden = true,
    direction = "float", -- the layout for the terminal, same as the main config options
    float_opts = {
      border = "double",
    },
    --> function to run on closing the terminal
    on_open = function(term)
      vim.cmd [[ startinsert! ]]
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer=0, silent=true })
    end,

    --> function to run on closing the terminal
    on_close = function(term)
      vim.cmd [[ "closing terminal" ]]
    end,
    dir = "git_dir", -- the directory for the terminal
    close_on_exit = true, -- close the terminal window when the process exits
    -- highlights = table -- a table with highlights
    -- env = table -- key:value table with environmental variables passed to jobstart()
    -- clear_env = bool -- use only environmental variables from `env`, passed to jobstart()
    -- on_open = fun(t: Terminal) -- function to run when the terminal opens
    -- on_close = fun(t: Terminal) -- function to run when the terminal closes
    -- -- callbacks for processing the output
    -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
    -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
    -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
  }

  function _lazygit_toggle()
    lazygit:toggle()
  end

  --> <SPACE>g launches lazygit in a floating window
  vim.keymap.set("n", "<space>g", "<cmd>lua _lazygit_toggle()<cr>", { silent=true })
