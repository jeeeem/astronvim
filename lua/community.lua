-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.typescript-deno" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  -- { import = "astrocommunity.pack.full-dadbod" },

  -- MARKDOWN
  -- { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  { import = "astrocommunity.markdown-and-latex.peek-nvim" },

  -- MOTION
  { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.mini-move" },
  -- { import = "astrocommunity.motion.flash-nvim" },

  -- GIT
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },

  -- FUZZY
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },

  -- FILE EXPLORER
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.file-explorer.mini-files" },

  -- EDITING SUPPORT

  -- Programming Language Support
  -- { import = "astrocommunity.programming-language-support.rest-nvim" },
  { import = "astrocommunity.programming-language-support.nvim-jqx" },

  -- COLORSCHEME
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- PROJECT
  -- { import = "astrocommunity.project.nvim-spectre" },

  -- SCROLLING
  { import = "astrocommunity.scrolling.mini-animate" },

  -- RECIPE
  -- { import = "astrocommunity.recipe.vscode" },
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },

  -- Register
  { import = "astrocommunity.register.nvim-neoclip-lua" },
}
