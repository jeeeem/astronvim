-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  opts = {
    follow_current_file = {
      enabled = false, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    window = {
      mappings = {
        ["v"] = "vsplit_with_window_picker",
        ["s"] = "split_with_window_picker",
        ["<cr>"] = "open_with_window_picker",
        ["w"] = false,
        ["e"] = false,
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = true,
            use_snacks_image = true,
            use_image_nvim = true,
          },
        },
        ["<C-p>"] = "focus_preview",
        ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
        ["l"] = false,
        ["L"] = "open",
        -- ["<C-l>"] = {
        --   "toggle_node",
        --   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        -- },
        ["<C-l>"] = "open",
        ["h"] = false,
        ["H"] = "close_node",
        ["<C-h>"] = "close_node",
        ["C"] = "close_all_nodes",
        ["z"] = false,
        ["Z"] = "expand_all_subnodes",
        ["O"] = "expand_all_nodes",
        ["gX"] = "system_open",
        -- ["b"] = "rename_basename",
        ["b"] = false,
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<esc>"] = "close",
        ["<CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = { "<C-S-w>", raw = true },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          },
        },
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },
    commands = {
      -- system_open = function(state)
      --   local node = state.tree:get_node()
      --   local path = node:get_id()
      --   -- macOs: open file in default application in the background.
      --   vim.fn.jobstart({ "open", path }, { detach = true })
      --   -- Linux: open file in default application
      --   -- vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      --
      --   -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
      --   -- local p
      --   -- local lastSlashIndex = path:match "^.+()\\[^\\]*$" -- Match the last slash and everything before it
      --   -- if lastSlashIndex then
      --   --   p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
      --   -- else
      --   --   p = path -- If no slash found, return original path
      --   -- end
      --   -- vim.cmd("silent !start explorer " .. p)
      -- end,
      -- open_and_clear_filter = function(state)
      --   local node = state.tree:get_node()
      --   if node and node.type == "file" then
      --     local file_path = node:get_id()
      --     -- reuse built-in commands to open and clear filter
      --     local cmds = require "neo-tree.sources.filesystem.commands"
      --     cmds.open(state)
      --     cmds.clear_filter(state)
      --     -- reveal the selected file without focusing the tree
      --     require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
      --   end
      -- end,
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
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
    source_selector = {
      winbar = false,
      statusline = true,
    },
    event_handlers = {
      {
        event = "after_render",
        handler = function()
          local bufnr = vim.api.nvim_get_current_buf()

          vim.schedule(function()
            local success, position = pcall(vim.api.nvim_buf_get_var, bufnr, "neo_tree_position")
            local state = require("neo-tree.sources.manager").get_state "filesystem"

            if position == "float" then
              if not require("neo-tree.sources.common.preview").is_active() then
                state.config = { use_float = true }
                state.commands.toggle_preview(state)
              end
            end
          end)
        end,
      },
    },
  },
}
