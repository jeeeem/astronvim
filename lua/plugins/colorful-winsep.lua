return {
  {
    "nvim-zh/colorful-winsep.nvim",
    -- commit = "e1b72c498f25c1fc37a7e9913332c137f753a90a",
    commit = "f5378e7a51e265a92e3a156e134bc902d61bf339",
    config = function()
      require("colorful-winsep").setup {
        -- highlight for Window separator
        hi = {
          bg = "#16161E",
          fg = "#1F3442",
        },
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "neo-tree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        -- Smooth moving switch
        smooth = false,
        anchor = {
          left = { height = 1, x = -1, y = -1 },
          right = { height = 1, x = -1, y = 0 },
          up = { width = 0, x = -1, y = 0 },
          bottom = { width = 0, x = 1, y = 0 },
        },
      }
    end,
    events = { "WinEnter", "BufEnter", "WinResized", "VimResized" },
  },
}
