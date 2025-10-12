return {
  -- {
  --   "echasnovski/mini.animate",
  --   opts = {
  --     scroll = {
  --       enable = false,
  --     },
  --     resize = {
  --       enable = true
  --     }
  --   },
  -- },
  {
    "sphamba/smear-cursor.nvim",
    event = "User AstroFile",
    enabled = false,
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = false,

      -- Sets animation framerate -- default: 17
      time_interval = 17, -- milliseconds
      -- Color
      cursor_color = "#50fa7b",
      gamma = 1,
      -- How fast the smear's head moves towards the target. -- 0: no movement, 1: instantaneous
      stiffness = 0.8,                      -- 0.6      [0, 1]
      -- How fast the smear's tail moves towards the target. -- 0: no movement, 1: instantaneous
      trailing_stiffness = 0.5,               -- 0.4      [0, 1]
      -- Controls if middle points are closer to the head or the tail.
      -- < 1: closer to the tail, > 1: closer to the head
      trailing_exponent = 5,
      -- Initial velocity factor in the direction opposite to the target
      -- anticipation = 0.2
      -- Stop animating when the smear's tail is within this distance (in characters) from the targe
      distance_stop_animating = 0.3,        -- 0.1      > 0
      -- -- Velocity reduction over time. O: no reduction, 1: full reduction
      damping = 0.65,                        -- 0.65     [0, 1]
      -- Set of parameters for insert mode
      -- damping_insert_mode = 0.8,            -- 0.7      [0, 1]
      -- stiffness_insert_mode = 0.8,          -- 0.5      [0, 1]
      -- trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    },
  },
}
