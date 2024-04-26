-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- import/override with your plugins folder
  "AstroNvim/astrocommunity",
  -- LSP
  { import = "astrocommunity.pack.lua" },

  -- MOTION
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.flash-nvim" },

  -- GIT
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },

  -- FUZZY
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },

  -- FILE EXPLORER
  { import = "astrocommunity.file-explorer.oil-nvim" },

  -- EDITING SUPPORT
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- COLORSCHEME
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- PROJECT
  { import = "astrocommunity.project.nvim-spectre" },

  -- SCROLLING
  { import = "astrocommunity.scrolling.mini-animate" },
}
