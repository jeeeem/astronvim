-- TODO:
-- mark f - specific file what you open from
local set_mark = function(id, path, desc) MiniFiles.set_bookmark(id, path, { desc = desc }) end
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    -- Get current working directory
    local cwd = vim.fn.getcwd()

    set_mark("c", vim.fn.stdpath "config", "Config") -- path
    set_mark("w", vim.fn.getcwd, "Working directory") -- callable
    set_mark("~", "~", "Home directory")

    -- Helper function to check if directory exists
    local function dir_exists(path) return vim.fn.isdirectory(path) == 1 end

    -- Raiden project specific bookmarks (only if they exist)
    if dir_exists(cwd .. "/services") then set_mark("s", cwd .. "/services", "Services") end
    if dir_exists(cwd .. "/components") then set_mark("c", cwd .. "/components", "Components") end
    if dir_exists(cwd .. "/libs") then set_mark("l", cwd .. "/libs", "Libs") end

    -- Individual services (check if they exist)
    if dir_exists(cwd .. "/services/raiden-order-service") then
      set_mark("1", cwd .. "/services/raiden-order-service", "Order Service")
    end

    if dir_exists(cwd .. "/services/raiden-product-service") then
      set_mark("2", cwd .. "/services/raiden-product-service", "Product Service")
    end

    if dir_exists(cwd .. "/services/raiden-product-instance-service") then
      set_mark("3", cwd .. "/services/raiden-product-instance-service", "Product Instance Service")
    end
  end,
})

return {
  "echasnovski/mini.files",
  -- No need to copy this inside `setup()`. Will be used automatically.
  opts = {
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- In which order to show file system entries
      sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
      close = "q",
      go_in = "<C-l>",
      go_in_plus = "L",
      go_out = "<C-h>",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = "<BS>",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },

    -- General options
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = true,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
    },

    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 25,
    },
  },
}
