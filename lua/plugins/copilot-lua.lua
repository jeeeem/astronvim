local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function copilot_action(action)
  local copilot = require "copilot.suggestion"
  return function()
    if copilot.is_visible() then
      copilot[action]()
      return true -- doesn't run the next command
    end
  end
end

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "User AstroFile",
  opts = {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right | horizontal | vertical
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 150,
      trigger_on_accept = true,
      -- keymap = {
      --   accept = "<M-l>",
      --   accept_word = false,
      --   accept_line = false,
      --   next = "<M-]>",
      --   prev = "<M-[>",
      --   dismiss = "<C-]>",
      -- },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
    logger = {
      file = vim.fn.stdpath "log" .. "/copilot-lua.log",
      file_log_level = vim.log.levels.OFF,
      print_log_level = vim.log.levels.WARN,
      trace_lsp = "off", -- "off" | "messages" | "verbose"
      trace_lsp_progress = false,
      log_lsp_messages = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 20
    workspace_folders = {},
    copilot_model = "",
    root_dir = function() return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]) end,
    -- should_attach = function(_, _)
    --   if not vim.bo.buflisted then
    --     logger.debug "not attaching, buffer is not 'buflisted'"
    --     return false
    --   end
    --
    --   if vim.bo.buftype ~= "" then
    --     logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
    --     return false
    --   end
    --
    --   return true
    -- end,
    server = {
      type = "nodejs", -- "nodejs" | "binary"
      custom_server_filepath = nil,
    },
    server_opts_overrides = {},
  },
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = function(_, opts)
        vim.api.nvim_create_autocmd("User", {
          pattern = "BlinkCmpMenuOpen",
          callback = function() vim.b.copilot_suggestion_hidden = true end,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "BlinkCmpMenuClose",
          callback = function() vim.b.copilot_suggestion_hidden = false end,
        })
        if not opts.keymap then opts.keymap = {} end

        opts.keymap["<Tab>"] = {
          copilot_action "accept",
          "select_next",
          "snippet_forward",
          function(cmp)
            if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        }
        opts.keymap["<A-[>"] = { copilot_action "prev" }
        opts.keymap["<A-]>"] = { copilot_action "next" }
        opts.keymap["<A-l>"] = { copilot_action "accept_word" }
        -- opts.keymap["<A-l>"] = {
        --   function()
        --     copilot_action("accept_word")
        --     copilot_action("next")
        --   end,
        -- }
        opts.keymap["<A-j>"] = { copilot_action "accept_line", "select_next", "fallback" }
        opts.keymap["<C-Right>"] = { copilot_action "accept_word" }
        -- opts.keymap["<C-Down>"] = { copilot_action "accept_line" }
        opts.keymap["<C-Down>"] = { copilot_action "accept_line", "select_next", "fallback" }
        -- opts.keymap["<C-L>"] = { copilot_action "accept_word" }
        opts.keymap["<C-q>"] = { copilot_action "dismiss" }
        opts.keymap["<C-]>"] = { copilot_action "dismiss" }
        opts.sources.providers.copilot = {
          name = "copilot",
          module = "blink.compat.source",
          transform_items = function(ctx, items)
            for _, item in ipairs(items) do
              item.kind_icon = ""
              item.kind_name = "Copilot"
            end
            return items
          end,
        }
      end,
    },
  },
}
