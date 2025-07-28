return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    {
      "jbyuki/nabla.nvim",
      lazy = true,
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          show_latex = {
            {
            event = "FileType",
            pattern = {"markdown"},
            desc = "Show Latex Popup Render",
            callback = function()
              vim.keymap.set("n", "gl", function()
                require("nabla").popup { border = "rounded" }
              end, { buffer = true, desc = "Show latex render popup" })
              vim.keymap.set("n", "gj", function()
                  require("nabla").disable_virt()
              end, { buffer = true, desc = "Disable latex render virtual lines" })
              vim.keymap.set("n", "gk", function()
                  require("nabla").enable_virt { align_center= true }
              end, { buffer = true, desc = "Enable latex render virtual lines" })
            end,
            }
          }
        }
      }
    },
  },
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t" },
    anti_conceal = {
      -- This enables hiding added text on the line the cursor is on.
      enabled = true,
      -- Modes to disable anti conceal feature.
      disabled_modes = false,
      -- Number of lines above cursor to show.
      above = 0,
      -- Number of lines below cursor to show.
      below = 0,
      -- Which elements to always show, ignoring anti conceal behavior. Values can either be
      -- booleans to fix the behavior or string lists representing modes where anti conceal
      -- behavior will be ignored. Valid values are:
      --   bullet
      --   callout
      --   check_icon, check_scope
      --   code_background, code_border, code_language
      --   dash
      --   head_background, head_border, head_icon
      --   indent
      --   link
      --   quote
      --   sign
      --   table_border
      --   virtual_lines
      ignore = {
        code_background = true,
        indent = true,
        sign = true,
        virtual_lines = true,
      },
    },
    code = {
      enabled = true,
      render_modes = false,
      sign = false,
      style = "full",
      position = "left",
      language_pad = 0,
      language_icon = true,
      language_name = true,
      language_info = true,
      disable_background = { "diff" },
      width = "full",
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = "hide",
      language_border = "█",
      language_left = "",
      language_right = "",
      above = "▄",
      below = "▀",
      inline_left = "",
      inline_right = "",
      inline_pad = 0,
      highlight = "RenderMarkdownCode",
      highlight_info = "RenderMarkdownCodeInfo",
      highlight_language = nil,
      highlight_border = "RenderMarkdownCodeBorder",
      highlight_fallback = "RenderMarkdownCodeFallback",
      highlight_inline = "RenderMarkdownCodeInline",
    },
    latex = {
      -- used nabla.nvim for latex parsing
      enabled = false,
      render_modes = false,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
      position = "above",
      top_pad = 0,
      bottom_pad = 1,
    },
    win_options = { conceallevel = { rendered = 2 } },
    on = {
      render = function()
        vim.schedule(function() require("nabla").enable_virt { align_center = true } end)
      end,
      clear = function()
        vim.schedule(function() require("nabla").disable_virt() end)
      end,
    },
    completions = {
      lsp = {
        enabled = true,
      },
      blink = {
        enabled = true,
      },
    },
  },
}
