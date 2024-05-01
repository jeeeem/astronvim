return {
  "nvim-neo-tree/neo-tree.nvim",
  -- config = function(plugin, opts)
  --   require "astronvim.plugins.configs.neo-tree"(plugin, opts)
  --   -- local maps = opts.mappings
  --   opts.window = {
  --     mappings = {
  --       ["s"] = "vsplit_with_window_picker",
  --       ["S"] = "split_with_window_picker",
  --     },
  --   }
  -- end,
  opts = {
    window = {
      mappings = {
        ["v"] = "vsplit_with_window_picker",
        ["s"] = "split_with_window_picker",
        ["<cr>"] = "open_with_window_picker",
        ["w"] = false,
      },
    },
  },
}
