-- -- Listen for opencode events
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "OpencodeEvent",
--   callback = function(args)
--     -- See the available event types and their properties
--     -- vim.notify(vim.inspect(args.data), vim.log.levels.DEBUG)
--     -- Do something interesting, like show a notification when opencode finishes responding
--     if args.data.type == "session.idle" then
--       vim.notify("opencode finished responding", vim.log.levels.INFO)
--     end
--   end,
-- })

return {
  "NickvanDyke/opencode.nvim",
  enabled = true,
  dependencies = { "folke/snacks.nvim" },
  ---@type opencode.Config
  opts = {
    -- https://github.com/NickvanDyke/opencode.nvim/blob/main/lua/opencode/config.lua
    on_opencode_not_found = false, -- don't create nvim terminal, only use external opencode. Error if not found
    on_send = function()
      -- "if exists" because user may alternate between embedded and external opencode.
      -- `opts.on_opencode_not_found` comments also apply here.
      pcall(require("opencode.terminal").show_if_exists)
    end,
    prompts = {
      ---@class opencode.Prompt
      ---@field description? string Description of the prompt. Shown in selection menu.
      ---@field prompt? string The prompt to send to opencode, with placeholders for context like `@cursor`, `@buffer`, etc.
      explain = {
        description = "Explain code near cursor",
        prompt = "Explain @cursor and its context",
      },
      fix = {
        description = "Fix diagnostics",
        prompt = "Fix these @diagnostics",
      },
      optimize = {
        description = "Optimize selection",
        prompt = "Optimize @selection for performance and readability",
      },
      document = {
        description = "Document selection",
        prompt = "Add documentation comments for @selection",
      },
      test = {
        description = "Add tests for selection",
        prompt = "Add tests for @selection",
      },
      review_buffer = {
        description = "Review buffer",
        prompt = "Review @buffer for correctness and readability",
      },
      review_diff = {
        description = "Review git diff",
        prompt = "Review the following git diff for correctness and readability:\n@diff",
      },
    },
    -- contexts = {
    --   ---@class opencode.Context
    --   ---@field description? string Description of the context. Shown in completion docs.
    --   ---@field value fun(): string|nil Function that returns the context value for replacement.
    --   ["@buffer"] = { description = "Current buffer", value = require("opencode.context").buffer },
    --   ["@buffers"] = { description = "Open buffers", value = require("opencode.context").buffers },
    --   ["@cursor"] = { description = "Cursor position", value = require("opencode.context").cursor_position },
    --   ["@selection"] = { description = "Selected text", value = require("opencode.context").visual_selection },
    --   ["@visible"] = { description = "Visible text", value = require("opencode.context").visible_text },
    --   ["@diagnostic"] = {
    --     description = "Current line diagnostics",
    --     value = function() return require("opencode.context").diagnostics(true) end,
    --   },
    --   ["@diagnostics"] = { description = "Current buffer diagnostics", value = require("opencode.context").diagnostics },
    --   ["@quickfix"] = { description = "Quickfix list", value = require("opencode.context").quickfix },
    --   ["@diff"] = { description = "Git diff", value = require("opencode.context").git_diff },
    --   ["@grapple"] = { description = "Grapple tags", value = require("opencode.context").grapple_tags },
    -- },
  },
  -- stylua: ignore
  keys = {
    -- Recommended keymaps
    { '<leader>oA', function() require('opencode').ask() end, desc = 'Ask opencode', },
    { '<leader>oa', function() require('opencode').ask('@buffer: ') end, desc = 'Ask opencode about this', mode = 'n', },
    { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
    { '<leader>oe', function() require('opencode').ask('@buffer: Explain current file') end, desc = 'Ask opencode about this', mode = 'n', },
    { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
    { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
    { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
    -- { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
    -- { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
    -- { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    -- Example: keymap for custom prompt
    -- { '<leader>oe', function() require('opencode').prompt("Explain current file @buffer") end, desc = "Explain code near cursor", },
  },
}
