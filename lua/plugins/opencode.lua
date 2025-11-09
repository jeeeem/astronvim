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
  config = function()
    vim.g.opencode_opts = {
      --   -- Your configuration, if any — see `lua/opencode/config.lua`
      --   port = nil,
      --   on_opencode_not_found = function()
      --     -- Ignore error so users can safely exclude `snacks.nvim` dependency without overriding this function.
      --     -- Could incidentally hide an unexpected error in `snacks.terminal`, but seems unlikely.
      --
      --     -- Don't call built-in terminal, I preferred to use opencode in terminal multiplexer (zellij)
      --     -- pcall(require("opencode.terminal").open)
      --   end,
      --   on_send = function()
      --     -- "if exists" because user may alternate between embedded and external opencode.
      --     -- `opts.on_opencode_not_found` comments also apply here.
      --     pcall(require("opencode.terminal").show_if_exists)
      --   end,
      --
      -- }
      --
      ---@type opencode.Provider
      provider = {
        toggle = function(self)
          -- Called by `require("opencode").toggle()`
        end,
        start = function(self)
          -- Called when sending a prompt or command to `opencode` but no process was found.
          -- `opencode.nvim` will poll for a couple seconds waiting for one to appear.
        end,
        show = function(self)
          -- Called when a prompt or command is sent to `opencode`,
          -- *and* this provider's `toggle` or `start` has previously been called
          -- (so as to not interfere when `opencode` was started externally).
        end,
      },
    }

    -- Required for `vim.g.opencode_opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set(
      { "n", "x" },
      "<leader>oa",
      function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask about this" }
    )
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
    vim.keymap.set({ "n", "x" }, "<leader>o+", function() require("opencode").prompt "@this" end, { desc = "Add this" })
    vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
    vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
    vim.keymap.set(
      "n",
      "<leader>on",
      function() require("opencode").command "session_new" end,
      { desc = "New session" }
    )
    vim.keymap.set(
      "n",
      "<leader>oi",
      function() require("opencode").command "session_interrupt" end,
      { desc = "Interrupt session" }
    )
    vim.keymap.set(
      "n",
      "<leader>oA",
      function() require("opencode").command "agent_cycle" end,
      { desc = "Cycle selected agent" }
    )
    vim.keymap.set(
      "n",
      "<S-C-u>",
      function() require("opencode").command "messages_half_page_up" end,
      { desc = "Messages half page up" }
    )
    vim.keymap.set(
      "n",
      "<S-C-d>",
      function() require("opencode").command "messages_half_page_down" end,
      { desc = "Messages half page down" }
    )
  end,
}
