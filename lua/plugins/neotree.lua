-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
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
        ["e"] = false
      },
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        -- hide_gitignored = true,
        hide_ignored = true, -- hide files that are ignored by other gitignore-like files
        -- other gitignore-like files, in descending order of precedence.
        ignore_files = {
          ".neotreeignore",
          ".ignore",
          -- ".rgignore"
        },
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        always_show_by_pattern = { -- uses glob style patterns
          --".env*",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
    },
  }
}
