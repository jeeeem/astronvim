-- TODO:
-- mark f - specific file what you open from
local set_mark = function(id, path, desc) MiniFiles.set_bookmark(id, path, { desc = desc }) end
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    -- Get current working directory
    local cwd = vim.fn.getcwd()

    -- Project root detection bookmark
    local function find_project_root()
      local current_dir = vim.fn.expand "%:p:h" -- current file's directory
      local markers = { ".git", "package.json", "Cargo.toml", "go.mod", "composer.json", "pom.xml", "gradlew"}

      local function has_marker(dir)
        for _, marker in ipairs(markers) do
          if vim.fn.isdirectory(dir .. "/" .. marker) == 1 or vim.fn.filereadable(dir .. "/" .. marker) == 1 then
            return true
          end
        end
        return false
      end

      -- Traverse up from current directory
      local dir = current_dir
      while dir ~= "/" and dir ~= "" do
        if has_marker(dir) then return dir end
        dir = vim.fn.fnamemodify(dir, ":h")
      end

      return cwd -- fallback to cwd if no project root found
    end

    set_mark("c", vim.fn.stdpath "config", "Config") -- path
    set_mark("p", vim.fn.expand "~/projects", "Projects Directory") -- project
    set_mark("r", find_project_root, "Project Root")
    set_mark("w", vim.fn.getcwd, "Working directory") -- callable
    set_mark("~", "~", "Home directory")
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
      use_as_default_explorer = false,
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
      width_preview = 50,
    },
  },
}
