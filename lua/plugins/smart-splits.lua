local term = vim.trim((vim.env.TERM_PROGRAM or ""):lower())
local mux = term == "tmux" or term == "zellij" or vim.env.KITTY_LISTEN_ON

vim.g.smart_splits_multiplexer_integration = "zellij"

return {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
  enabled = true,
  event = mux and "VeryLazy" or nil, -- load early if mux detected
  opts = {
    -- Desired behavior when your cursor is at an edge and you
    -- are moving towards that same edge:
    -- 'wrap' => Wrap to opposite side
    -- 'split' => Create a new split in the desired direction
    -- 'stop' => Do nothing
    -- function => You handle the behavior yourself
    -- NOTE: If using a function, the function will be called with
    -- a context object with the following fields:
    -- {
    --    mux = {
    --      type:'tmux'|'wezterm'|'kitty'|'zellij'
    --      current_pane_id():number,
    --      is_in_session(): boolean
    --      current_pane_is_zoomed():boolean,
    --      -- following methods return a boolean to indicate success or failure
    --      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
    --      next_pane(direction:'left'|'right'|'up'|'down'):boolean
    --      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
    --      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
    --    },
    --    direction = 'left'|'right'|'up'|'down',
    --    split(), -- utility function to split current Neovim pane in the current direction
    --    wrap(), -- utility function to wrap to opposite Neovim pane
    -- }
    -- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
    -- multiplexer, as there is no way to determine layout via the CLI
    at_edge = "wrap",
    -- the default number of lines/columns to resize by at a time
    default_amount = 3,
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile" },
    disable_multiplexer_nav_when_zoomed = true,
    -- enable or disable a multiplexer integration;
    -- automatically determined, unless explicitly disabled or set,
    -- by checking the $TERM_PROGRAM environment variable,
    -- and the $KITTY_LISTEN_ON environment variable for Kitty.
    -- You can also set this value by setting `vim.g.smart_splits_multiplexer_integration`
    -- before the plugin is loaded (e.g. for lazy environments).
    multiplexer_intergration = "zellij",
    -- In Zellij, set this to true if you would like to move to the next *tab*
    -- when the current pane is at the edge of the zellij tab/window
    zellij_move_focus_or_tab = false,
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<C-H>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
        maps.n["<C-J>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
        maps.n["<C-K>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
        maps.n["<C-L>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
        maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
        maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
        maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
        maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
      end,
    },
  },
}
