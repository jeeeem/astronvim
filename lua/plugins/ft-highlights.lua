return {
  "samiulsami/fFtT-highlights.nvim",
  event = "VeryLazy",
  config = function()
    ---@module "fFtT-highlights"
    ---@type fFtT_highlights.opts
    require("fFtT-highlights"):setup {
      f = "f", -- forward search key
      F = "F", -- backward search key
      t = "t", -- forward till key
      T = "T", -- backward till key
      next = ";", -- next key
      prev = ",", -- previous key
      reset_key = "<Esc>", -- key to reset highlights and cancel character-pending state

      on_reset = nil, -- callback to run when reset_key is pressed

      smart_motions = false, -- whether to use f/F/t/T to go to next/previous characters

      -- options: "default" | "smart_case" | "ignore_case"
      case_sensitivity = "default", -- case sensitivity

      max_highlighted_lines_around_cursor = 300, -- max number of lines to consider above/below cursor for highlighting. Doesn't prevent jumps outside the range.

      match_highlight = {
        enable = true, -- enable/disable matching chars highlight.

        -- options: "full" | "minimal" | "none"
        -- "full": highlights all matches until the top/bottom border or multi_line.max_lines.
        -- "minimal": highlights the prefix/suffix matches in the current line, and upto exactly ONE match above/below the cursor if it exists.
        -- "none": disables highlighting for matching characters.
        style = "minimal", -- match highlighting style.
        highlight_radius = 500, -- consider at most this many characters for highlighting around the cursor.
        show_jump_numbers = false, -- show the number of jumps required to get to each matching character.
        priority = 900, -- match highlight priority.
      },

      multi_line = {
        enable = false, -- enable/disable multi-line search
        max_lines = 300, -- max lines to consider for jumping/highlights above/below cursor if multi-line search is enabled.
      },

      backdrop = {
        style = {
          -- options: "full" | "minimal" | "none"
          -- "full": highlights from the cursor line upto the top/bottom border.
          -- "current_line": highlights from the until the last matching character in the cursor line.
          -- "none": disables backdrop highlighting on keypress.
          on_key_press = "full", -- highlight backdrop on keypress.

          -- options: "full" | "upto_next_line" | "current_line" | "none"
          -- "full": highlights from the cursor line upto the top/bottom border.
          -- "current_line": highlights from the until the last matching character in the cursor line.
          -- "upto_next_line": highlights from the cursor line upto the next matching character in another line.
          -- "none": disables backdrop highlighting while in motion.
          show_in_motion = "upto_next_line", -- highlight backdrop while in motion.
        },
        border_extend = 1, -- extend backdrop border horizontally by this many characters.
        priority = 800, -- backdrop highlight priority.
      },

      jumpable_chars = {
        -- options: "always" | "on_key_press" | "never"
        show_instantly_jumpable = "on_key_press", -- when to highlight characters that can be jumped to in 1 step (options below have no effect when this is disabled).
        show_secondary_jumpable = "never", -- when to highlight characters that can be jumped to in 2 steps.
        show_all_jumpable_in_words = "never", -- when to highlight all characters that can be jumped to in 1 or 2 steps. Highlights one char per word by default.
        show_multiline_jumpable = "never", -- when to highlight jumpable characters in other lines.
        min_gap = 1, -- minimum gap between two jumpable characters.
        priority = 1100, -- jumpable chars highlight priority.
        priority_secondary = 1000, -- secondary jumpable chars highlight priority.
      },

      disabled_filetypes = {}, -- disable the plugin for these filetypes (falls back to default keybindings)

      disabled_buftypes = { "nofile" }, -- disable the plugin for these buftypes (falls back to default keybindings)
    }
  end,
}
