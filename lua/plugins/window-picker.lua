return {
  "s1n7ax/nvim-window-picker",
  main = "window-picker",
  lazy = true,
  opts = {
    hint = "floating-big-letter",
    picker_config = {
      statusline_winbar_picker = { use_winbar = "smart" },
      floating_big_letter = {
        font = "ansi-shadow", -- ansi-shadow |
      },
    },
  },
}
