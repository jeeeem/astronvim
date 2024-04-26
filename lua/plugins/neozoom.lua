return {
  {
    "nyngwang/NeoZoom.lua",
    config = function()
      require("neo-zoom").setup {
        popup = {
          -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
          -- This way you won't see two windows of the same buffer
          -- got updated at the same time.
          enabled = true,
          exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
          exclude_buftypes = { "terminal" },
        },
        exclude_buftypes = { "terminal" },
        exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
        winopts = {
          offset = {
            -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
            -- top = 0,
            -- left = 0.17,
            width = 150,
            height = 0.85,
          },
          -- NOTE: check :help nvim_open_win() for possible border values.
          border = "thicc", -- this is a preset, try it :)
        },
        presets = {
          {
            -- NOTE: regex pattern can be used here!
            filetypes = { "dapui_.*", "dap-repl" },
            winopts = {
              offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
            },
          },
          {
            filetypes = { "markdown" },
            callbacks = {
              function() vim.wo.wrap = true end,
            },
          },
        },
      }
      vim.keymap.set("n", "<C-w><CR>", function() vim.cmd "NeoZoomToggle" end, { silent = true, nowait = true })
    end,
  },
}
