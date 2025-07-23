-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  -- { import = "astrocommunity.pack.php" },
  -- { import = "astrocommunity.pack.full-dadbod" },

  -- AI
  { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.completion.copilot-cmp" },
  -- { import = "astrocommunity.completion.copilot-lua"},
  -- { import = "astrocommunity.completion.copilot-lua-cmp"},

  -- PROGRAMMING SUPPORT
  { import = "astrocommunity.programming-language-support.kulala-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- EDITING SUPPORT
  -- { import = "astrocommunity.editing-support.mcphub-nvim"},
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },


  -- MARKDOWN
  -- { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
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
  -- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },

  -- FILE EXPLORER
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.file-explorer.mini-files" },

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
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },

  -- Register
  -- { import = "astrocommunity.register.nvim-neoclip-lua" },

  -- THEMES
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-paper-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },
}
