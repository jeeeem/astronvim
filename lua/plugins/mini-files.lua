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
      local markers = { ".git", "package.json", "Cargo.toml", "go.mod", "composer.json", "pom.xml", "gradlew" }

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

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify "Cursor is not on valid entry" end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify "Cursor is not on valid entry" end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
    vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
    vim.keymap.set("n", "gY", yank_path, { buffer = b, desc = "Yank path" })
  end,
})

local show_dotfiles = true

local filter_show = function(fs_entry) return true end

local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh { content = { filter = new_filter } }
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
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
