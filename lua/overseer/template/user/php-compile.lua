return {
  name = "php compile",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "php" },
      args = { file },
      components = { { "on_output_quickfix", open = false }, "default" },
    }
  end,
  condition = {
    filetype = { "php" },
  },
}
