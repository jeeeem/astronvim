return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      function() require("yazi").yazi() end,
      desc = "Open the file manager",
    },
    -- {
    --   -- Open in the current working directory
    --   "<leader>cw",
    --   function()
    --     require("yazi").yazi(nil, vim.fn.getcwd())
    --   end,
    --   desc = "Open the file manager in nvim's working directory" ,
    -- },
  },
  opts = {
    -- Below is the default configuration. It is optional to set these values.
    -- You can customize the configuration for each yazi call by passing it to
    -- yazi() explicitly

    -- enable this if you want to open yazi instead of netrw.
    -- Note that if you enable this, you need to call yazi.setup() to
    -- initialize the plugin. lazy.nvim does this for you in certain cases.
    open_for_directories = false,

    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 0.9,

    -- the transparency of the yazi floating window (0-100). See :h winblend
    yazi_floating_window_winblend = 0,

    -- what Neovim should do a when a file was opened (selected) in yazi.
    -- Defaults to simply opening the file.
    open_file_function = function(chosen_file, config) end,

    -- completely override the keymappings for yazi. This function will be
    -- called in the context of the yazi terminal buffer.
    set_keymappings_function = function(yazi_buffer_id, config) end,

    -- the type of border to use for the floating window. Can be many values,
    -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
    -- more information, see :h nvim_open_win
    yazi_floating_window_border = "rounded",

    hooks = {
      -- if you want to execute a custom action when yazi has been opened,
      -- you can define it here.
      yazi_opened = function(preselected_path, yazi_buffer_id, config)
        -- you can optionally modify the config for this specific yazi
        -- invocation if you want to customize the behaviour
      end,

      -- when yazi was successfully closed
      yazi_closed_successfully = function(chosen_file, config) end,

      -- when yazi opened multiple files. The default is to send them to the
      -- quickfix list, but if you want to change that, you can define it here
      yazi_opened_multiple_files = function(chosen_files, config, state) end,
    },

    integrations = {
      --- What should be done when the user wants to grep in a directory
      ---@param directory string
      grep_in_directory = function(directory)
        -- the default implementation uses telescope if available, otherwise nothing
      end,
    },
  },
}
